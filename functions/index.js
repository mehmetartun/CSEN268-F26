/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const { setGlobalOptions } = require("firebase-functions");
const { onCall, onRequest } = require("firebase-functions/v2/https");
const { initializeApp } = require("firebase-admin/app")
const { getFirestore, Timestamp } = require("firebase-admin/firestore")
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { beforeUserCreated, beforeUserSignedIn } = require("firebase-functions/v2/identity");
const { getMessaging } = require("firebase-admin/messaging");

const logger = require("firebase-functions/logger");

const { getStorage } = require("firebase-admin/storage");
const { onObjectFinalized } = require("firebase-functions/storage");
const path = require("path");
const sharp = require("sharp");
const fs = require("fs");
const os = require("os");

// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
setGlobalOptions({ maxInstances: 10 });
initializeApp();


exports.helloWorld = onRequest((request, response) => {
    logger.info("Hello logs!", { structuredData: true });
    response.send("Hello from Firebase!");
});

exports.helloWorldCall = onCall((request) => {
    return { 'message': 'Hello from Firebase' };
});

exports.addData = onCall(async (request) => {
    var collection = request.data['collection'];
    var map = request.data['map'];
    var documentReference = await getFirestore().collection(collection).add(map);
    return { 'path': documentReference.path, 'id': documentReference.id };
});

exports.getData = onCall(async (request) => {
    var path = request.data['path'];
    var result = await getFirestore().doc(path).get();
    return { 'data': result.data() };
});

exports.onUserCreated = onDocumentCreated("/function_test/{userId}", async (event) => {
    await getFirestore().collection('log_test').add(
        {
            'userId': event.data.params.userId,
            'createTime': event.data.createTime,
        }
    )
});

exports.onImageUploaded = onObjectFinalized(async (event) => {
    const fileBucket = event.data.bucket;
    const filePath = event.data.name;
    const contentType = event.data.contentType;
    const fileName = path.basename(filePath);


    if (contentType.startsWith('image/')) {
        const bucket = getStorage().bucket(fileBucket);
        const downloadResponse = await bucket.file(filePath).download();
        const imageBuffer = downloadResponse[0];

        // Create a thumbnail from the image buffer
        const thumbnailBuffer = await sharp(imageBuffer).resize({
            width: 100,
            height: 100,
            withoutEnlargement: true,
        }).toBuffer();

        // Convert the thumbnail buffer to a base64 string
        const thumbnailBase64 = thumbnailBuffer.toString('base64');

        // Save the base64 string to Firestore
        try {
            await getFirestore().collection('images').add({
                fileName: fileName,
                thumbnailBase64: thumbnailBase64,
                createdAt: new Date(),
            });
            logger.info(`Successfully created and stored thumbnail for ${fileName}`);
        } catch (error) {
            logger.error(`Error storing thumbnail for ${fileName}:`, error);
        }
    }
});

exports.saveUser = beforeUserCreated(async (event) => {
    const user = event.data;
    const db = getFirestore();
    const userRef = db.collection('users').doc(user.uid);
    await userRef.set({
        email: user.email ?? null,
        displayName: user.displayName ?? null,
        photoUrl: user.photoURL ?? null,
        createdAt: Timestamp.now(),
        uid: user.uid,
        emailVerified: user.emailVerified,
    }, { merge: true });
});

exports.updateUser = beforeUserSignedIn(async (event) => {
    const user = event.data;
    const db = getFirestore();
    const userRef = db.collection('users').doc(user.uid);
    await userRef.update({
        emailVerified: user.emailVerified,
    });
});

exports.updateUserFid = onCall(async (request) => {
    logger.info(request.data);
    if (!request.data.uid || !request.data.fid) {
        logger.info({ 'message': 'Invalid request' });
        return { 'message': 'Invalid request' };
    }
    const uid = request.data.uid;
    const fid = request.data.fid;
    const action = request.data.action;
    const db = getFirestore();
    const userRef = db.doc(`users/${uid}`);
    const qs = await userRef.get();
    var fids = qs.data().fids;
    if (!fids) {
        fids = [];
    }
    if (action == 'delete') {
        fids = fids.filter(item => item !== fid);
    } else if (action == 'add') {
        if (!fids.includes(fid)) {
            fids.push(fid);
        }
    }
    logger.info({fids: fids, userPath: userRef.path });
    await userRef.update({
        fids: fids,
    });
    return { 'message': 'Success' };
});


exports.sendMessageTest = onRequest(async (request, response) => {
    const email = request.query.email;
    const db = getFirestore();
    const userRef = db.collection('users').where('email', '==', email);
    const qs = await userRef.get();
    if (qs.empty) {
        response.status(404).send('User not found');
        return;
    }
    const user = qs.docs[0].data();
    const fids = user.fids;
    if (!fids || fids.length === 0) {
        response.status(404).send('No FID Found');
        return;
    }
    var messages = [];
    fids.forEach(fid => {
        messages.push(
          {
            fid: fid,

            notification: {
                title: 'Test Notification via FID',
                body: 'Sent from Node.js using Firebase Installation ID!',
            },

            data: {
                click_action: 'FLUTTER_NOTIFICATION_CLICK',
                screen: '/profile',
                timestamp: new Date().toISOString(),
            },

            webpush: {
                notification: {
                    icon: '/icons/Icon-192.png',
                },
                fcmOptions: {
                    link: 'http://localhost:58503/',
                },
            },
        } 
        );
        // messages.push({ 'fid': fid, 'notification': { 'title': 'Test', 'body': message } });
    });
    await getMessaging().sendEach(messages);
    response.send('Success');
})