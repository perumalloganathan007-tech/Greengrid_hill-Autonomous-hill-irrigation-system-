# Firebase Setup Guide for GreenGrid

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: **greengrid-hill**
4. Disable Google Analytics (optional)
5. Click "Create project"

## Step 2: Register Your App

### For Android:
1. Click Android icon in Firebase console
2. Enter package name: `com.greengrid.greengridhill`
3. Download `google-services.json`
4. Place it in `android/app/` directory

### For iOS:
1. Click iOS icon in Firebase console
2. Enter bundle ID: `com.greengrid.greengridhill`
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/` directory

### For Web:
1. Click Web icon
2. Register app name: "GreenGrid Web"
3. Copy the Firebase configuration

## Step 3: Enable Realtime Database

1. In Firebase Console, go to "Realtime Database"
2. Click "Create Database"
3. Choose location (e.g., us-central1)
4. Start in **test mode** (for development)
5. Click "Enable"

## Step 4: Set Database Rules

Replace the default rules with these (for development):

```json
{
  "rules": {
    "sensors": {
      ".read": true,
      ".write": true
    },
    "tanks": {
      ".read": true,
      ".write": true
    },
    "pumps": {
      ".read": true,
      ".write": true
    },
    "analytics": {
      ".read": true,
      ".write": true
    }
  }
}
```

**⚠️ Important**: For production, implement proper authentication and security rules!

## Step 5: Get Database URL

1. In Realtime Database section, copy the database URL
2. It looks like: `https://greengrid-hill-default-rtdb.firebaseio.com/`

## Step 6: Configure Flutter App

### Option A: Using FlutterFire CLI (Recommended)

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for your app
flutterfire configure
```

This will automatically generate `firebase_options.dart`

### Option B: Manual Configuration

Create `lib/firebase_options.dart`:

```dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR_WEB_API_KEY',
    appId: 'YOUR_WEB_APP_ID',
    messagingSenderId: 'YOUR_SENDER_ID',
    projectId: 'greengrid-hill',
    authDomain: 'greengrid-hill.firebaseapp.com',
    databaseURL: 'https://greengrid-hill-default-rtdb.firebaseio.com',
    storageBucket: 'greengrid-hill.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_ANDROID_API_KEY',
    appId: 'YOUR_ANDROID_APP_ID',
    messagingSenderId: 'YOUR_SENDER_ID',
    projectId: 'greengrid-hill',
    databaseURL: 'https://greengrid-hill-default-rtdb.firebaseio.com',
    storageBucket: 'greengrid-hill.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_SENDER_ID',
    projectId: 'greengrid-hill',
    databaseURL: 'https://greengrid-hill-default-rtdb.firebaseio.com',
    storageBucket: 'greengrid-hill.appspot.com',
    iosBundleId: 'com.greengrid.greengridhill',
  );
}
```

## Step 7: Initialize Firebase in App

Update `lib/main.dart`:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const GreenGridApp());
}
```

## Step 8: Test Firebase Connection

Add test data to your database:

1. Go to Realtime Database in Firebase Console
2. Click "+" to add data
3. Add this structure:

```json
{
  "sensors": {
    "sensor_zone_a": {
      "sensorId": "sensor_zone_a",
      "moistureLevel": 65.5,
      "timestamp": "2026-01-30T12:00:00.000Z",
      "status": "Safe",
      "location": "Zone A"
    }
  },
  "tanks": {
    "main_tank": {
      "tankId": "main_tank",
      "levelPercentage": 75.5,
      "volumeLiters": 1510,
      "capacityLiters": 2000,
      "timestamp": "2026-01-30T12:00:00.000Z",
      "status": "Normal"
    }
  }
}
```

## Step 9: Run the App

```bash
flutter run
```

The app should now connect to Firebase and display live data!

## Troubleshooting

### Issue: "FirebaseException: type 'FirebaseException' is not a subtype"

**Solution**: Make sure Firebase is initialized before running the app. Uncomment the Firebase initialization code in `main.dart`

### Issue: "Permission denied"

**Solution**: Check database rules - make sure `.read` and `.write` are set to `true` for development

### Issue: "Database URL not found"

**Solution**: Verify the `databaseURL` in `firebase_options.dart` matches your Firebase project

### Issue: Web app not connecting

**Solution**: Make sure web platform is registered in Firebase Console and configuration is correct

## Production Security Rules

When deploying to production, use proper authentication:

```json
{
  "rules": {
    "sensors": {
      ".read": "auth != null",
      ".write": "auth != null"
    },
    "tanks": {
      ".read": "auth != null",
      ".write": "auth != null"
    },
    "pumps": {
      ".read": "auth != null",
      ".write": "auth.uid != null"
    },
    "analytics": {
      ".read": "auth != null",
      ".write": "auth != null"
    }
  }
}
```

## Next Steps

1. ✅ Create Firebase project
2. ✅ Enable Realtime Database
3. ✅ Configure Flutter app
4. ✅ Test connection with sample data
5. 🔄 Connect ESP32 to Firebase (see ESP32_API_DOCS.md)
6. 🔄 Implement authentication
7. 🔄 Deploy to production
