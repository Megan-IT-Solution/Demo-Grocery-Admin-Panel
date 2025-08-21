// web/firebase-messaging-sw.js

importScripts('https://www.gstatic.com/firebasejs/10.12.2/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.12.2/firebase-messaging-compat.js');

firebase.initializeApp({
      apiKey: 'AIzaSyBXyphCe_y7ocyo__9rTMEwyIcNdKFsfHI',
      appId: '1:523868825106:web:2616e3b5484bc4509a5acb',
      messagingSenderId: '523868825106',
      projectId: 'grocery-6c200',
      authDomain: 'grocery-6c200.firebaseapp.com',
      storageBucket: 'grocery-6c200.firebasestorage.app',
      measurementId: 'G-4X70KPZBRR',
});

const messaging = firebase.messaging();

// Optional: For background notification display
messaging.onBackgroundMessage(function (payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/icons/icon-192.png' // Optional
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
