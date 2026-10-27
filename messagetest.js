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