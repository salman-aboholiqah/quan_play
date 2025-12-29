# Google Play Compliance Checklist

This document tracks the compliance status for Google Play Store submission.

## ✅ Completed Requirements

### 1. App Signing Configuration
- ✅ Created signing configuration in `android/app/build.gradle.kts`
- ✅ Added `android/key.properties.template` file for reference
- ✅ Added `android/app/key.properties` to `.gitignore` to prevent committing sensitive data
- ✅ Configured release build type to use release signing config
- ⚠️ **Action Required**: Create your release keystore file
  - Run: `keytool -genkey -v -keystore android/keystore/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload`
  - Copy `android/key.properties.template` to `android/app/key.properties`
  - Fill in your keystore details in `android/app/key.properties`

### 2. Target SDK Version
- ✅ Explicitly set `targetSdk = 34` (Android 14) in `build.gradle.kts`
- ✅ Meets Google Play requirement for 2024 (minimum API 33)
- ✅ Compile SDK uses Flutter defaults (compatible)

### 3. Security Configuration
- ✅ Disabled cleartext traffic in production (`usesCleartextTraffic="false"` in main manifest)
- ✅ Enabled cleartext traffic only in debug builds (via debug manifest)
- ✅ Production builds enforce HTTPS for security compliance

### 4. ProGuard/R8 Configuration
- ✅ Enabled code minification and obfuscation for release builds
- ✅ Enabled resource shrinking (`isShrinkResources = true`)
- ✅ Created `android/app/proguard-rules.pro` with rules for:
  - Flutter framework
  - ObjectBox (database)
  - Google Mobile Ads
  - Google Play Core (deferred components support)
  - Video player libraries
  - Kotlin coroutines
- ✅ Configured ProGuard in `build.gradle.kts` release build type

### 4.1 Google Play Core Dependency
- ✅ Added `com.google.android.play:core:1.10.3` dependency
- ✅ Added `com.google.android.play:core-ktx:1.8.1` dependency
- ✅ Required for Flutter deferred components support
- ✅ Prevents R8 missing class errors during build

### 5. App Bundle Configuration
- ✅ Build configuration supports Android App Bundle (AAB) format
- 📝 **Build Command**: `flutter build appbundle --release`
- ⚠️ **Note**: Always build as AAB (not APK) for Google Play submission

### 6. Permissions
- ✅ Only `INTERNET` permission declared (appropriate for app functionality)
- ✅ Permission is necessary and properly declared
- ✅ Google Mobile Ads SDK permissions are handled automatically

### 7. App Metadata
- ✅ App icon exists in all required densities (mipmap-hdpi through mipmap-xxxhdpi)
- ✅ Application label: "Tsalul URL Player"
- ✅ Application ID: `com.quansoft.tsalul_url_player`

### 8. Version Management
- ✅ Current version: `1.0.0+1` (versionName: 1.0.0, versionCode: 1)
- ✅ Version code increments with each release (currently 1 for initial release)
- 📝 **Note**: Increment version code for each Play Store release

### 9. Google Mobile Ads
- ✅ Google Mobile Ads SDK initialized in `main.dart`
- ✅ AdMob Application ID configured in `AndroidManifest.xml`
- ✅ Using `google_mobile_ads` package version ^6.0.0

### 10. App Metadata
- ✅ Updated `pubspec.yaml` description (was "A new Flutter project")
- ✅ App label verified in AndroidManifest.xml: "Tsalul URL Player"
- ✅ Application ID verified: `com.quansoft.tsalul_url_player`
- ✅ No TODO/FIXME comments in production code

## ⚠️ Action Items for Play Console

### Privacy Policy (REQUIRED)
- ⚠️ **Required**: Create and host a privacy policy URL
  - Required because app uses Google Mobile Ads
  - Must disclose data collection practices
  - Add privacy policy URL in Play Console under "Store presence" > "Main store listing" > "Privacy Policy"

### Content Rating
- ⚠️ **Required**: Complete content rating questionnaire in Play Console
  - Required for all apps on Google Play
  - Access via Play Console > "Store presence" > "Content rating"

### Store Listing Materials
- ⚠️ **Required**: Prepare the following:
  - App description (short and full)
  - App screenshots (at least 2, up to 8)
  - Feature graphic (1024 x 500 pixels)
  - High-resolution icon (512 x 512 pixels)

### Data Safety Section
- ⚠️ **Required**: Complete Data Safety section in Play Console
  - Disclose data collection practices
  - Specify data sharing practices
  - Required for apps that collect or share user data

## 📋 Pre-Submission Checklist

Before uploading to Google Play:

- [ ] Create release keystore and configure `key.properties`
- [ ] Test release build: `flutter build appbundle --release`
- [ ] Test the app on physical devices with release build
- [ ] Verify ads display correctly in release mode
- [ ] Verify all core functionality works in release build
- [ ] Create privacy policy and host it online
- [ ] Prepare store listing materials (screenshots, description, etc.)
- [ ] Complete content rating questionnaire
- [ ] Complete Data Safety section
- [ ] Review Google Play Developer Program Policies
- [ ] Verify app doesn't violate any content policies

## 🔍 Build and Test Commands

### Build Release App Bundle
```bash
flutter build appbundle --release
```

### Build Release APK (for testing only, use AAB for Play Store)
```bash
flutter build apk --release
```

### Install Release APK on connected device
```bash
flutter install --release
```

## 📝 Notes

- The app uses ObjectBox for local database storage
- The app streams video content from network URLs
- Cleartext HTTP traffic is disabled in production builds (HTTPS only)
- ProGuard rules are configured to preserve necessary classes for:
  - ObjectBox model classes and generated code
  - Google Mobile Ads SDK
  - Video player libraries
  - Flutter framework classes

## 🔗 Useful Links

- [Google Play Developer Policy](https://play.google.com/about/developer-content-policy/)
- [Android App Bundle Guide](https://developer.android.com/guide/app-bundle)
- [Google Mobile Ads Documentation](https://developers.google.com/admob/flutter)
- [Flutter Release Build Guide](https://docs.flutter.dev/deployment/android)

