# GreenGrid Hill - Deployment Guide

## ✅ Completed Setup

- ✅ Flutter dependencies installed
- ✅ MVVM architecture implemented
- ✅ 3 core modules (Telemetry, Control, Analytics)
- ✅ Complete UI (Dashboard, Analytics, Settings)
- ✅ Demo data working
- ✅ App running successfully on web

## 🚀 Next Steps

### 1. Firebase Configuration (Optional but Recommended)

**Current Status**: App uses demo data because Firebase is not configured

**To Enable Firebase**:
1. Follow [FIREBASE_SETUP.md](FIREBASE_SETUP.md) guide
2. Create Firebase project
3. Enable Realtime Database
4. Configure `firebase_options.dart`
5. Uncomment Firebase initialization in `lib/main.dart`

### 2. ESP32 Hardware Setup

**Current Status**: App is ready to communicate with ESP32

**To Connect ESP32**:
1. Follow [ESP32_API_DOCS.md](ESP32_API_DOCS.md)
2. Flash ESP32 with web server code
3. Implement the 4 required API endpoints:
   - `POST /api/pump/control` - Control pumps
   - `POST /api/pump/mode` - Set auto/manual mode
   - `GET /api/pump/status/:id` - Get pump status
   - `POST /api/emergency/stop` - Emergency stop
4. Connect to same WiFi network
5. Set ESP32 static IP to `192.168.1.100` (or configure in app Settings)

### 3. Deploy to Physical Devices

#### For Android:

```bash
# Connect Android device via USB
flutter devices

# Build and install
flutter build apk
flutter install

# Or run directly
flutter run -d <android-device-id>
```

#### For iOS:

```bash
# Connect iPhone via USB
flutter devices

# Build and install (requires macOS)
flutter build ios
flutter run -d <ios-device-id>
```

#### For Windows Desktop:

```bash
flutter run -d windows
```

### 4. Production Build

#### Android APK:

```bash
# Release build
flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

#### iOS IPA (macOS only):

```bash
flutter build ios --release

# Then use Xcode to archive and export
```

#### Web Deployment:

```bash
# Build for web
flutter build web

# Deploy the build/web directory to your hosting service
```

### 5. Testing Checklist

- [ ] Test app launches successfully
- [ ] Dashboard displays demo moisture sensors
- [ ] Dashboard displays demo tank levels
- [ ] Dashboard displays demo pump controls
- [ ] Analytics screen shows charts
- [ ] Settings screen saves preferences
- [ ] Navigation between screens works
- [ ] Pull-to-refresh works
- [ ] Pump toggle buttons work (will fail without ESP32)
- [ ] Mode switching works
- [ ] Firebase sync works (after configuration)
- [ ] ESP32 communication works (after hardware setup)

### 6. Current Features Working

**Without Hardware/Firebase**:
- ✅ Complete UI navigation
- ✅ Demo sensor data visualization
- ✅ Demo tank levels
- ✅ Demo pump controls (UI only)
- ✅ Demo analytics charts
- ✅ Settings configuration
- ✅ All widgets and screens

**With Firebase** (after setup):
- ✅ Real-time sensor data updates
- ✅ Real-time tank level monitoring
- ✅ Historical water usage analytics
- ✅ Cloud data synchronization

**With ESP32** (after hardware setup):
- ✅ Actual pump control
- ✅ Live sensor readings
- ✅ Real-time moisture monitoring
- ✅ Automatic irrigation triggering

### 7. Configuration Files Created

1. **lib/utils/constants.dart** - All app constants
2. **lib/utils/helpers.dart** - Utility functions
3. **ESP32_API_DOCS.md** - ESP32 API specification
4. **FIREBASE_SETUP.md** - Firebase setup guide
5. **IMPLEMENTATION.md** - Implementation summary

### 8. Known Limitations

1. **Demo Mode**: Currently using simulated data
2. **ESP32 Required**: Pump controls need hardware
3. **Firebase Optional**: Works without it using demo data
4. **Network Dependency**: Requires WiFi for ESP32 communication

### 9. Recommended Development Flow

**Phase 1** (Current - COMPLETED ✅):
- Flutter app with demo data
- Complete UI implementation
- All screens functional

**Phase 2** (Next - Firebase):
1. Create Firebase project
2. Configure Realtime Database
3. Enable Firebase in app
4. Test cloud sync

**Phase 3** (Hardware Integration):
1. Set up ESP32 with sensors
2. Implement API endpoints
3. Test ESP32 ↔ App communication
4. Test Firebase ↔ ESP32 sync

**Phase 4** (Field Deployment):
1. Install hardware on hillside
2. Configure WiFi network
3. Deploy mobile app to farmers
4. Monitor and optimize

### 10. Quick Commands Reference

```bash
# Run on web
flutter run -d chrome

# Run on edge
flutter run -d edge

# Hot reload (while app is running)
r

# Check for errors
flutter analyze

# List connected devices
flutter devices

# Clean build cache
flutter clean
flutter pub get

# Update dependencies
flutter pub upgrade
```

### 11. Support & Documentation

- **App Documentation**: See IMPLEMENTATION.md
- **Firebase Guide**: See FIREBASE_SETUP.md
- **ESP32 API**: See ESP32_API_DOCS.md
- **Flutter Docs**: https://docs.flutter.dev
- **Firebase Docs**: https://firebase.google.com/docs

### 12. Contact & Maintenance

**Version**: 1.0.0  
**Last Updated**: January 30, 2026  
**Status**: Development - Demo Mode Active

---

## 🎯 Current Action Items

1. **Try the Demo** ✅ - App is running on Edge browser
2. **Review Documentation** - Check ESP32_API_DOCS.md and FIREBASE_SETUP.md
3. **Plan Hardware** - Gather ESP32, sensors, relays, pumps
4. **Setup Firebase** (Optional) - For cloud sync
5. **Build ESP32 Code** - Implement API endpoints
6. **Field Test** - Deploy on actual hillside

The foundation is complete. Choose your next step based on your priority:
- **Want cloud features?** → Setup Firebase
- **Have ESP32 ready?** → Start hardware integration  
- **Want to deploy?** → Build APK for Android
- **Just testing?** → Keep using demo mode
