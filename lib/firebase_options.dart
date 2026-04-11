import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Firebase configuration for GreenGrid Hill
///
/// SETUP INSTRUCTIONS:
/// 1. Go to https://console.firebase.google.com/
/// 2. Create a new project named "greengrid-hill"
/// 3. Add your app for each platform (Web, Android, iOS)
/// 4. Copy the configuration values below
/// 5. Replace 'YOUR_XXX' placeholders with actual values
///
/// To enable Firebase in the app:
/// - Uncomment the Firebase initialization in lib/main.dart

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCkC9bnmFI3SjQbJCVUcYKtjiIvD54JoHfw',
    appId: '1:810444862955:web:994f788cc82da7a9c655ae',
    messagingSenderId: '810444862955',
    projectId: 'green-hill-2e19e',
    authDomain: 'green-hill-2e19e.firebaseapp.com',
    databaseURL: 'https://green-hill-2e19e-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'green-hill-2e19e.firebasestorage.app',
    measurementId: 'G-R7JQ41VYKQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCkC9bnmFI3SjQbJCVUcYKtjiIvD54JoHfw',
    appId: '1:810444862955:android:YOUR_ANDROID_APP_ID', // Requires google-services.json
    messagingSenderId: '810444862955',
    projectId: 'green-hill-2e19e',
    databaseURL: 'https://green-hill-2e19e-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'green-hill-2e19e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkC9bnmFI3SjQbJCVUcYKtjiIvD54JoHfw',
    appId: '1:810444862955:ios:YOUR_IOS_APP_ID', // Requires GoogleService-Info.plist
    messagingSenderId: '810444862955',
    projectId: 'green-hill-2e19e',
    databaseURL: 'https://green-hill-2e19e-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'green-hill-2e19e.firebasestorage.app',
    iosBundleId: 'com.greengrid.greengridhill',
  );
}
