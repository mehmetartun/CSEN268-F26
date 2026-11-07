# Lecture 14 - 06 - Cloud Functions

## Setting up Cloud Functions for our Project
Here we set up Cloud Functions for our project by using
```bash
firebase init
```
and choosing **Javascript** as our language (you can choose Python as well). As a result of this our `firebase.json` is modified to reflect this initialization.
```json
{
   ...
   "functions": [
    {
      "source": "functions",
      "codebase": "default",
      "disallowLegacyRuntimeConfig": true,
      "ignore": [
        "node_modules",
        ".git",
        "firebase-debug.log",
        "firebase-debug.*.log",
        "*.local"
      ]
    }
  ]
  ...
}
```
## Directory Structure
The `functions` directory contains:
```bash
functions
├── .gitignore
├── index.js
├── node_modules
├── package-lock.json
└── package.json
```
> Important: Ensure .gitignore is properly configured to prevent committing unnecessary dependencies (node_modules) or sensitive environment variables and API keys to source control.

## Writing Functions (onRequest vs onCall)
**Firebase Functions v2** provides two main HTTP trigger types via `firebase-functions/v2/https`
:

| Trigger | Purpose | Primary Use Case|
|---|---|---|
| onCall | Callable functions designed to be invoked directly from the Flutter app using cloud_functions. Handles authentication context, serialization, and CORS automatically. |In-app actions, secure database queries, custom logic|
| onRequest | Standard HTTP endpoints accessible via URL (browser, curl, or external Webhooks).|Webhooks, public APIs, browser testing
|

```javascript
exports.helloWorld = onRequest((request, response) => {
    logger.info("Hello logs!", { structuredData: true });
    response.send("Hello from Firebase!");
});

exports.helloWorldCall = onCall((request) => {
    return { 'message': 'Hello from Firebase' };
});
```

## Emulating Functions
To Emulate, we first need to get a service account from google to connect to Firebase. For this we need a key for the `App Engine Default Service Account` from the **Google Cloud Console**. Once we save it locally on the project as a `json` file and add it to `.gitignore` we can create a shell script in the file `em.sh` at the root of the project:
```bash
export GOOGLE_APPLICATION_CREDENTIALS="/Users/mehmetartun/Development/csen268f26/google_app_engine_service_account.json"
firebase emulators:start --only functions
```
You must change the execution mode of this file by `chmod 755 em.sh`.

Now, by adding
```dart
FirebaseFunctions.instance.useFunctionsEmulator("localhost", 5001);
```
we can use the emulators. To run the emulator, simply call in the terminal from the root of your project.
```bash
./em.sh
```
You will see the available functions and everytime there is an execution you will be able to see in the console. 

