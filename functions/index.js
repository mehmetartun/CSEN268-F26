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
const { getFirestore } = require("firebase-admin/firestore")
const { onDocumentCreated } = require("firebase-functions/v2/firestore");

const logger = require("firebase-functions/logger");

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