
# Lecture 11 - 05 Testing Messaging Programmatically

In order to test messaging we write a simple **Node.js** script and run this from project directory. However, before that we have to create a key to be able to connect to **Firebase**.

## Creating the Key
In your firebase console go to **\<Your Project\> / Settings / Service accounts**

Create a new private key by clicking **Generate new private key**

Save the key as `firebase_admin_sdk_key.json` at the root of your directory.

Edit `.gitignore` file by entering the name of your key above so that it doesn't get pushed up to the repo.

## Install `firebase-admin` SDK
```npm install firebase-admin@latest
```
and ensure that you are running **NodeJS v22**
```
node --version
```
To install **22**
```
nvm install v22
nvm use 22
```


## The NodeJS program
The script we will use is the following (`messagetest.js`):
```javascript
const { initializeApp, cert } = require('firebase-admin/app');
const { getMessaging } = require('firebase-admin/messaging');
const path = require('path');

const serviceAccount = require(path.join(__dirname, 'firebase_admin_sdk_key.json'));

// 1. Initialize using modular app methods
initializeApp({
  credential: cert(serviceAccount),
});

const targetFID = 'eELmAl5qgcEgSCNHr5Rm5X';

// 2. Construct payload with the 'fid' field
const message = {
  fid: targetFID,
  
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
};

// 3. Send via getMessaging()
async function sendTestMessage() {
  try {
    const response = await getMessaging().send(message);
    console.log('Successfully sent message to FID:', response);
  } catch (error) {
    console.error('Error sending message:', error);
  }
}

sendTestMessage();
```

and to run it we will simply have to call:

```bash
node messagetest
```