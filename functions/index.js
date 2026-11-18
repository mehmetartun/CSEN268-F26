/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const { setGlobalOptions } = require("firebase-functions");
const { onCall, onRequest, HttpsError } = require("firebase-functions/v2/https");
const { initializeApp } = require("firebase-admin/app")
const { getFirestore, Timestamp } = require("firebase-admin/firestore")
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { beforeUserCreated, beforeUserSignedIn } = require("firebase-functions/v2/identity");
const { getMessaging } = require("firebase-admin/messaging");
const { googleAI } = require('@genkit-ai/google-genai');

const logger = require("firebase-functions/logger");

const { getStorage, getDownloadURL } = require("firebase-admin/storage");
const { onObjectFinalized } = require("firebase-functions/storage");
const path = require("path");
const sharp = require("sharp");
const fs = require("fs");
const os = require("os");

const { defineSecret } = require('firebase-functions/params');
const { onInit } = require('firebase-functions/v2/core');
const { get } = require("http");
const { enableFirebaseTelemetry } = require('@genkit-ai/firebase');
const { onCallGenkit } = require("firebase-functions/https");
const { genkit, z } = require("genkit");

const {
    GoogleGenerativeAI,
    HarmCategory,
    HarmBlockThreshold,
} = require('@google/generative-ai');
const apiKey = defineSecret('GEMINI_API_KEY');

let genAI;
onInit(() => {
    genAI = new GoogleGenerativeAI(apiKey.value());
})

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



const ai = genkit({
    plugins: [googleAI()],
    model: 'googleai/gemini-2.5-flash',
});

enableFirebaseTelemetry();

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

exports.getRecipe = onCall({
    secrets: ['GEMINI_API_KEY'],
    timeoutSeconds: 540,
}, async (request) => {
    const schema = request.data.schema;
    const languageModel = request.data.languageModel;
    try {
        const model = genAI.getGenerativeModel({
            model: languageModel,
            generationConfig: {
                responseMimeType: 'application/json',
                responseSchema: schema,
            },
        });

        const safetySettings = [
            {
                category: HarmCategory.HARM_CATEGORY_HARASSMENT,
                threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
            },
            {
                category: HarmCategory.HARM_CATEGORY_HATE_SPEECH,
                threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
            },
        ];
        const prompt = request.data.prompt;
        const result = await model.generateContent({
            contents: [{ role: 'user', parts: [{ text: prompt }] }],
            safetySettings,
        });
        const response = result.response;
        if (!response || !response.candidates || !response.candidates[0].content) {
            throw new Error('Invalid response from Gemini API.');
        }
        const jsonString = response.candidates[0].content.parts[0].text;
        const recipeJson = JSON.parse(jsonString);
        return recipeJson;
    } catch (error) {
        console.error('Error calling Gemini API:', error);
        if (error.response) {
            console.error('API Response Data:', error.response.data);
        }
        return { 'error': error.message };
    }
});

const answerQuestionFlow = ai.defineFlow({
    name: "answerQuestion",
    inputSchema: z.object({
        question: z.string(),
        system: z.string().optional(),
    }),
    outputSchema: z.string(),
    streamSchema: z.string(),
}, async (input, { sendChunk }) => {
    const { stream, response } =  ai.generateStream({
        system: input.system,
        prompt: input.question,
    });
    for await (const chunk of stream) {
        if (chunk.text) {
            sendChunk(chunk.text);
        }
    }
    const finalResponse = await response;
    return finalResponse.text;
});

exports.answerQuestion = onCallGenkit({
    secrets: ['GEMINI_API_KEY'],
    timeoutSeconds: 540,
}, answerQuestionFlow);


function getAspectRatio(width, height) {
    if (!width || !height) return '1:1';
    const ratio = width / height;
    const supported = [
        { label: '1:1', value: 1 },
        { label: '4:3', value: 4 / 3 },
        { label: '3:4', value: 3 / 4 },
        { label: '16:9', value: 16 / 9 },
        { label: '9:16', value: 9 / 16 },
    ];
    return supported.reduce((prev, curr) =>
        Math.abs(curr.value - ratio) < Math.abs(prev.value - ratio) ? curr : prev
    ).label;
}

const imageGenerator = async (schema) => {
    const { description, image_style, width, height } = schema;
    const stylePrompt = image_style ? `Style: ${image_style}. ` : "";
    const prompt = `Create an image based on the following description: ${description}.\n${stylePrompt}`;
    try {
        const result = await ai.generate({
            prompt,
            model: 'googleai/gemini-3.1-flash-image',
            config: {
                responseModalities: ['TEXT', 'IMAGE'],
                imageConfig: {
                    aspectRatio: getAspectRatio(width, height),
        },
    },
        });
        console.log(result);
        const media = result.media;
        const dataUrl = media?.url || '';
        let initialBase64 = dataUrl.startsWith('data:') ? dataUrl.split(',')[1] : dataUrl;

        // 1. Convert to Buffer
        let imageBuffer;
        if (dataUrl.startsWith('data:')) {
            imageBuffer = Buffer.from(initialBase64, 'base64');
        } else if (dataUrl.startsWith('http://') || dataUrl.startsWith('https://')) {
            const response = await fetch(dataUrl);
            const arrayBuffer = await response.arrayBuffer();
            imageBuffer = Buffer.from(arrayBuffer);
        } else {
            imageBuffer = Buffer.from(initialBase64, 'base64');
        }

        // 2. Process image with Sharp (Resize if specified, always convert to JPEG)
        let sharpPipeline = sharp(imageBuffer);
        if (width && height) {
            sharpPipeline = sharpPipeline.resize({
                width: width,
                height: height,
                fit: 'cover', // crop and resize to fill the exact dimensions nicely
            });
        }
        const jpegBuffer = await sharpPipeline.jpeg().toBuffer();
        const imageBase64 = jpegBuffer.toString('base64');

        // 3. Save to Firebase Storage
        const bucket = getStorage().bucket();
        const filename = `generated_images/${Date.now()}_${Math.random().toString(36).substring(2, 15)}.jpg`;
        const file = bucket.file(filename);

        await file.save(jpegBuffer, {
            contentType: 'image/jpeg',
            metadata: {
                cacheControl: 'public, max-age=31536000',
            }
        });

        // 4. Get Storage path and Download URL
        const storagePath = file.name;
        const downloadUrl = await getDownloadURL(file);

        return { imageBase64, storagePath, downloadUrl };
    } catch (error) {
        console.error('Error generating image:', error);
        throw new Error('Image generation failed: ' + error.message);
    }
};

const generateImageFlow = ai.defineFlow({
    name: "generateImage",
    inputSchema: z.object({
        description: z.string(),
        image_style: z.string().optional(),
        width: z.number().optional(),
        height: z.number().optional(),
    }),
    outputSchema: z.object({
        imageBase64: z.string(),
        storagePath: z.string().optional(),
        downloadUrl: z.string().optional(),
    }),
}, async (input) => {
    const result = await imageGenerator(input);
    return result;
});

exports.generateImage = onCallGenkit({
    secrets: ['GEMINI_API_KEY'],
    timeoutSeconds: 540,
}, generateImageFlow);
