importScripts('https://www.gstatic.com/firebasejs/9.22.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.22.0/firebase-messaging-compat.js');

// Initialize Firebase inside the Service Worker
const firebaseConfig = {
  apiKey: "AIzaSyDBBaqmybxqA3Ak9BzLnsEubAuGBn_vrp8",
  authDomain: "csen268-f25.firebaseapp.com",
  projectId: "csen268-f25",
  storageBucket: "csen268-f25.firebasestorage.app",
  messagingSenderId: "1055393658402",
  appId: "1:1055393658402:web:401934657b102459003c7b",
  measurementId: "G-EJGFTXNNDB"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Display system notifications for background messages
messaging.onBackgroundMessage((payload) => {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);

  const notificationTitle = payload.notification?.title || 'New Message';
  const notificationOptions = {
    body: payload.notification?.body || '',
    icon: '/icons/Icon-192.png', // Optional icon path
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});