# Firebase Authentication Setup Guide

## 🔐 Enable Authentication in Firebase Console

Follow these steps to enable **Email/Password** and **Google Sign-In** authentication for your GreenGrid Hill app:

### Step 1: Access Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: **greengrid-hill**

### Step 2: Enable Email/Password Authentication

1. In the left sidebar, click on **"Build"** → **"Authentication"**
2. Click on the **"Get Started"** button (if first time) or **"Sign-in method"** tab
3. Under **"Sign-in providers"**, find **"Email/Password"**
4. Click on **"Email/Password"** to expand it
5. Toggle the **"Enable"** switch to ON
6. Click **"Save"**

### Step 3: Enable Google Sign-In Authentication ⭐

1. In the same **"Sign-in method"** tab
2. Find **"Google"** in the providers list
3. Click on **"Google"** to expand it
4. Toggle the **"Enable"** switch to ON
5. Enter your **Project support email** (your email address)
6. Click **"Save"**

**For Web App (important):**
- The Firebase Console will automatically configure OAuth 2.0 for web
- No additional setup needed for Chrome/web platform

**For Android/iOS (if needed later):**
- Download the updated `google-services.json` (Android) or `GoogleService-Info.plist` (iOS)
- Add SHA-1/SHA-256 fingerprints in Firebase Project Settings → Your apps

### Step 4: Deploy Firestore Security Rules

1. In Firebase Console, go to **"Firestore Database"** in the left sidebar
2. Click on the **"Rules"** tab
3. Copy the contents from `firestore.rules` file in your project
4. Paste it into the rules editor
5. Click **"Publish"**

**Current Firestore Rules Location:** `d:\MAD PROJECT\greengrid hill\greengridhill\firestore.rules`

### Step 5: Deploy Realtime Database Security Rules

1. In Firebase Console, go to **"Realtime Database"** in the left sidebar
2. Click on the **"Rules"** tab
3. Copy the contents from `database.rules.json` file in your project
4. Paste it into the rules editor
5. Click **"Publish"**

**Current Database Rules Location:** `d:\MAD PROJECT\greengrid hill\greengridhill\database.rules.json`

### Step 6: Test Authentication

1. Run your Flutter app: `flutter run -d chrome`
2. The app should show the **Splash Screen** → **Login Screen**
3. You have two sign-in options:

**Option A: Email/Password Sign Up**
- Click **"Sign Up"** to create the first user
- Enter:
  - Display Name: Admin User
  - Email: admin@greengridhill.com
  - Password: (minimum 6 characters)
- The first user will automatically be assigned **Admin** role

**Option B: Google Sign-In** ⭐
- Click **"Continue with Google"** button
- Select your Google account
- Authorize the app
- The first user will automatically be assigned **Admin** role
- Your Google display name and email will be used for your profile

## 🔑 Security Rules Explanation

### Firestore (User Profiles)
- ✅ All authenticated users can read user profiles
- ✅ Users can create their own profile during signup
- ✅ Users can update their own profile
- ✅ Admins can update any profile
- ✅ Only admins can delete users

### Realtime Database (Sensor Data & Audit Logs)
- ✅ All authenticated users can read/write sensor data
- ✅ Users can view their own audit logs
- ✅ Admins can view all audit logs
- ✅ All authenticated users can write audit logs

## 👥 User Roles

### Admin User (First User)
- Full access to all features
- User management (view/edit/delete users)
- Emergency pump stop
- View all audit logs
- Manage schedules and settings

### Regular User
- ViewGoogle Sign-In authentication enabled in Firebase Console
- [ ] Firestore security rules deployed
- [ ] Realtime Database security rules deployed
- [ ] First admin user created (via email/password OR Google)
- [ ] Login/logout working with both methods
- [ ] Google sign-in redirects correctly
- [ ] Profile management working
- [ ] Audit logs recording actions

## 🚨 Important Notes

1. **First User is Admin**: The very first user who signs up (via ANY method) automatically becomes an admin
2. **Google Sign-In**: Uses your Google account display name and email
3. **Password Requirements**: Minimum 6 characters (only for email/password, not Google)
4. **Remember Me**: Uses local storage to persist login for 30 days (email/password only)
5. **Secure Operations**: Pump control and emergency stop are protected by authentication
6. **Audit Trail**: All critical actions are logged with user information
7. **Sign Out**: Logs out from both Firebase AND Google accounts

## 🔧 Testing Credentials

Create these test users after enabling authentication:

**Method 1: Email/Password**
- Email: admin@greengridhill.com
- Password: admin123 (change in production!)
- Role: Admin (automatic for first user)

**Method 2: Google Sign-In** ⭐ (Recommended)
- Use your own Google account
- Instant sign-in, no password to remember
- First Google user becomes admin automatically

**Additional Users:**
- Email: operator@greengridhill.com
- Password: operator123
- Role: Regular User (assigned via admin panel)

## 📱 Supported Platforms

### ✅ Web (Chrome) - Fully Configured
- Email/Password: ✅ Working
- Google Sign-In: ✅ Working
- No additional setup needed

### 📱 Android (Future)
- Requires: SHA-1/SHA-256 fingerprints in Firebase Console
- Download: `google-services.json`
- Google Sign-In package handles OAuth

### 🍎 iOS (Future)
- Requires: Bundle ID configuration in Firebase Console
- Download: `GoogleService-Info.plist`
- Google Sign-In package handles OAuth

## 📞 Troubleshooting

### "User not found" error
- Check if Email/Password is enabled in Firebase Console
- Verify the user exists in Authentication → Users tab

### Google Sign-In popup blocked
- Allow popups for localhost in browser settings
- Check browser console for errors
- Ensure Google Sign-In is enabled in Firebase Console

### "Permission denied" errors
- Ensure security rules are deployed correctly
- Check if user is authenticated (not logged out)
- Verify Firebase initialization in app

### Login not persisting
- Check browser local storage is enabled
- Verify "Remember Me" is checked during login (email/password only)
- Check preferences service is initialized

### Google account picker not showing
- Clear browser cache and cookies
- Try incognito/private browsing mode
- Check Firebase Console for Google Sign-In configuration

## 🌟 Google Sign-In Benefits

1. **No Password Required**: Users don't need to remember another password
2. **Faster Registration**: One-click sign up with existing Google account
3. **Verified Emails**: Google accounts are already verified
4. **Better UX**: Familiar Google sign-in interface
5. **Secure**: OAuth 2.0 protocol managed by Google
6. **Multi-Device**: Same account works across all devices
### "Permission denied" errors
- Ensure security rules are deployed correctly
- Check if user is authenticated (not logged out)
- Verify Firebase initialization in app

### Login not persisting
- Check browser local storage is enabled
- Verify "Remember Me" is checked during login
- Check preferences service is initialized

## Next Steps

After authentication is working:
1. Create additional users via admin panel (to be implemented)
2. Test role-based access control
3. Review audit logs for security monitoring
4. Configure email templates in Firebase (for password reset)
