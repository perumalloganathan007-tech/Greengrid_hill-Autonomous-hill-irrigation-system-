# 🔧 Fix Google Sign-In Error

## Error Message:
```
ClientID not set. Either set it on a <meta name="google-signin-client_id" content="CLIENT_ID"/> tag, or pass clientId when initializing GoogleSignIn
```

## ✅ How to Fix:

### Step 1: Get Your OAuth Client ID from Firebase Console

1. Go to **Firebase Console** → https://console.firebase.google.com/
2. Select your **greengrid-hill** project
3. Navigate to **Authentication** → **Sign-in method** tab
4. Click on **Google** provider (should show as enabled)
5. Scroll down to **"Web SDK configuration"** section
6. You'll see a field labeled **"Web client ID"**
7. Copy the entire Client ID (format: `100150620207-XXXXXXXXXXXXXXXXXXXXXXXX.apps.googleusercontent.com`)

### Step 2: Update web/index.html

1. Open `web/index.html` file
2. Find this line (around line 24):
```html
<meta name="google-signin-client_id" content="100150620207-XXXXXXXXXXXXXXXXXXXXXXXX.apps.googleusercontent.com">
```
3. Replace the `content` value with your actual Web Client ID from Step 1

### Example:
If your Web Client ID is: `100150620207-abc123def456xyz.apps.googleusercontent.com`

Update the line to:
```html
<meta name="google-signin-client_id" content="100150620207-abc123def456xyz.apps.googleusercontent.com">
```

### Step 3: Restart the App

```bash
# Stop the current running app (Ctrl+C in terminal or close Chrome)
cd "d:\MAD PROJECT\greengrid hill\greengridhill"
flutter run -d chrome
```

## 🎯 Where to Find Web Client ID:

**Firebase Console Path:**
```
Authentication > Sign-in method > Google > Web SDK configuration > Web client ID
```

The screen you saw earlier should have a section at the bottom showing:
- **Web client ID**: `100150620207-XXXXXXXX.apps.googleusercontent.com`
- **Web client secret**: (you don't need this)

## ✅ After Fix:

Once you add the correct Client ID:
- ✅ The red error will disappear
- ✅ "Continue with Google" button will work
- ✅ Clicking it will show Google account picker
- ✅ You can sign in with your Google account

## 🔍 Verification:

After updating and restarting:
1. Open the app in Chrome
2. Click "Continue with Google"
3. Should see Google account picker (no errors)
4. Sign in with your Google account
5. Redirected to dashboard as authenticated user

## 📝 Note:

The Client ID is project-specific and safe to include in your code. It's not a secret - it's meant to be public in the web app.
