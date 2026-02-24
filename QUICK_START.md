# QUICK START GUIDE

## 🚀 Firebase Setup (Option 4)

### Step 1: Create Firebase Project
1. Go to https://console.firebase.google.com/
2. Click "+ Add project"
3. Project name: **greengrid-hill**
4. Disable Google Analytics (or keep it)
5. Click "Create project"

### Step 2: Enable Realtime Database
1. In left sidebar, click "Realtime Database"
2. Click "Create Database"
3. Choose location (e.g., us-central1)
4. Start in **test mode** (for now)
5. Click "Enable"

### Step 3: Configure Your App

#### Web Platform:
1. In Firebase Console, click the web icon `</>`
2. App nickname: **GreenGrid Web**
3. Copy the config values
4. Open `lib/firebase_options.dart`
5. Replace `YOUR_WEB_API_KEY`, etc. with actual values

#### Android Platform:
1. Click Android icon
2. Package name: `com.greengrid.greengridhill`
3. Download `google-services.json`
4. Place in `android/app/` folder
5. Update `firebase_options.dart` with Android config

### Step 4: Enable Firebase in App
1. Open `lib/main.dart`
2. Uncomment these lines (around line 33):
```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

### Step 5: Test Firebase
```bash
flutter run -d edge
```

Check Firebase Console → Realtime Database to see if data appears!

---

## 🎨 Development Enhancements (Option 5)

### ✅ What Was Added:

#### 1. **Dark Mode Support**
- Light theme
- Dark theme  
- System theme (auto-switches)
- Theme switcher in Settings screen

#### 2. **Firebase Configuration Template**
- Ready-to-use `firebase_options.dart`
- Clear setup instructions
- Platform support (Web, Android, iOS)

#### 3. **Preferences Service**
- Persistent settings storage
- First launch detection
- Theme mode persistence
- All settings saved automatically

#### 4. **Custom Theme System**
- Professional color palette
- Consistent design across all screens
- Material 3 components
- Smooth theme transitions

### 🎯 Try It Now:

```bash
# Hot reload to apply changes
r
```

Then go to **Settings** → **Appearance** and switch between Light/Dark/System themes!

---

## 📝 Firebase Database Rules (After Setup)

Go to Firebase Console → Realtime Database → Rules, paste this:

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
      "water_usage": {
        ".read": true,
        ".write": true
      }
    }
  }
}
```

**⚠️ Warning**: These rules are for development only! Add authentication for production.

---

## 🔗 Quick Links

- **Firebase Console**: https://console.firebase.google.com/
- **Firebase Docs**: https://firebase.google.com/docs/flutter/setup
- **FlutterFire CLI**: https://firebase.flutter.dev/docs/cli

---

## ✨ New Features Summary

| Feature | Status | Location |
|---------|--------|----------|
| Dark Mode | ✅ Added | Settings → Appearance |
| Firebase Template | ✅ Added | lib/firebase_options.dart |
| Preferences Service | ✅ Added | Automatic on first launch |
| Custom Themes | ✅ Added | Applied globally |
| First Launch Setup | ✅ Added | Sets defaults automatically |

---

## 🐛 Troubleshooting

**Q: Theme not changing?**  
A: Press 'R' in terminal for hot restart (not just 'r')

**Q: Firebase not working?**  
A: Make sure you uncommented the initialization in main.dart

**Q: Where is firebase_options.dart?**  
A: It's in `lib/firebase_options.dart` - update the YOUR_XXX values

---

Your app now has **professional theming** and is **ready for Firebase**! 🎉
