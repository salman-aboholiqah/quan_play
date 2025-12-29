# Pre-Submission Checklist for Perfect First Play Store Release

This checklist ensures your first Google Play Store submission is perfect and ready for publication.

## ✅ Technical Requirements (Code Changes - DONE)

- [x] App description updated in `pubspec.yaml`
- [x] Target SDK 34 (Android 14) configured
- [x] Security: Cleartext traffic disabled in production
- [x] ProGuard/R8 configured with proper rules
- [x] Google Play Core dependency added
- [x] NDK version 27.0.12077973 configured
- [x] App bundle build configuration ready
- [x] Permissions properly declared
- [x] Google Mobile Ads configured
- [x] No TODO/FIXME comments in production code
- [x] Debug statements verified (debugPrint is safe - auto-stripped in release)

## ⚠️ Manual Actions Required

### 1. Keystore Setup (CRITICAL - DO THIS FIRST)

**Steps:**
1. Generate release keystore:
   ```bash
   keytool -genkey -v -keystore android/keystore/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```
   - **IMPORTANT**: Remember the passwords you set!
   - Store the keystore file securely

2. Create `android/app/key.properties`:
   - Copy `android/key.properties.template` to `android/app/key.properties`
   - Fill in your keystore details:
     ```properties
     storePassword=YOUR_KEYSTORE_PASSWORD
     keyPassword=YOUR_KEY_PASSWORD
     keyAlias=upload
     storeFile=../keystore/upload-keystore.jks
     ```

3. **BACKUP YOUR KEYSTORE**:
   - Copy keystore file to secure location (encrypted backup, password manager, etc.)
   - Save passwords in password manager
   - **If you lose this, you cannot update your app on Play Store!**

**Status:** ⚠️ **REQUIRED BEFORE BUILDING RELEASE**

### 2. Build and Test Release Version

**Commands:**
```bash
# Clean build
flutter clean
flutter pub get

# Build release app bundle
flutter build appbundle --release

# Build release APK for testing (optional)
flutter build apk --release
```

**Verification:**
- [ ] AAB file created at: `build/app/outputs/bundle/release/app-release.aab`
- [ ] Build completes without errors
- [ ] Install release APK on physical device
- [ ] Test all core features in release build
- [ ] Verify ads display correctly (use test ad units)
- [ ] Check app size is reasonable

**Test Checklist:**
- [ ] App launches without crashes
- [ ] Video playback works
- [ ] Search functionality works
- [ ] Link management (add/edit/delete) works
- [ ] Theme switching works
- [ ] No obvious bugs or crashes
- [ ] Performance is acceptable

### 3. Store Listing Materials

#### 3.1 App Icon
- [ ] High-resolution icon: **512 x 512 pixels** (PNG, no transparency)
- [ ] Professional, clear design
- [ ] Matches app branding

#### 3.2 Feature Graphic
- [ ] **1024 x 500 pixels** (PNG or JPG, no transparency)
- [ ] Banner-style graphic
- [ ] Includes app name and key features
- [ ] Professional design

#### 3.3 Screenshots
- [ ] **At least 2 screenshots** (recommended: 6-8)
- [ ] Phone screenshots: 16:9 or 9:16 aspect ratio
- [ ] Minimum: 320px, Maximum: 3840px (side)
- [ ] Show real app functionality (not mockups)
- [ ] High quality, clear images
- [ ] Consider adding text overlays with key features

**How to create screenshots:**
1. Build release APK: `flutter build apk --release`
2. Install on device or emulator
3. Take screenshots showing different screens/features
4. Edit if needed (add text overlays, crop, etc.)

#### 3.4 App Descriptions

**Short Description (80 characters max):**
```
Example: "Stream videos from URLs with advanced controls, quality selection, and local link management."
```
- [ ] Write engaging short description
- [ ] Includes key features/keywords
- [ ] Under 80 characters

**Full Description (4000 characters max):**
- [ ] Write comprehensive description
- [ ] Highlight all key features
- [ ] Use bullet points for readability
- [ ] Include relevant keywords naturally
- [ ] No misleading claims
- [ ] Proofread for errors

### 4. Privacy Policy (REQUIRED)

**Why required:**
- App uses Google Mobile Ads (collects user data)
- App accesses network for video streaming

**Content to include:**
- [ ] What data is collected (Google Ads SDK automatically collects data)
- [ ] How data is used
- [ ] Third-party services (Google Ads)
- [ ] Data storage (local - ObjectBox)
- [ ] User rights
- [ ] Contact information
- [ ] Last updated date

**Hosting:**
- [ ] Create privacy policy HTML
- [ ] Host on HTTPS URL (GitHub Pages recommended - free)
- [ ] Verify URL is accessible
- [ ] Test URL in browser

**Free hosting options:**
- GitHub Pages (recommended)
- Netlify
- Firebase Hosting

### 5. Google Play Console Setup

#### 5.1 Account Creation
- [ ] Create Google Play Developer account
- [ ] Pay one-time $25 registration fee
- [ ] Complete account setup

#### 5.2 App Creation
- [ ] Create new app in Play Console
- [ ] Choose app name (can change later)
- [ ] Select default language
- [ ] Choose app type: App
- [ ] Set app access: Free (or Paid)

#### 5.3 Store Listing
- [ ] Upload app icon (512x512)
- [ ] Upload feature graphic (1024x500)
- [ ] Upload screenshots (at least 2)
- [ ] Add short description
- [ ] Add full description
- [ ] Select app category
- [ ] Add contact details (email, website)
- [ ] Add privacy policy URL

#### 5.4 Content Rating
- [ ] Complete IARC questionnaire
- [ ] Answer questions honestly about app content
- [ ] Submit for rating (usually instant)
- [ ] Receive rating certificate

#### 5.5 Data Safety
- [ ] Complete Data Safety section
- [ ] Disclose data collection:
  - Google Mobile Ads SDK collects data (automatic)
  - Data purpose: Advertising
  - Data shared with third parties: Yes (Google)
- [ ] Explain data security practices
- [ ] Specify data deletion policies

#### 5.6 App Content
- [ ] Review App access settings
- [ ] Declare ads (yes, using Google Mobile Ads)
- [ ] Review target audience
- [ ] Complete any other required sections

### 6. Submission Process

#### 6.1 Internal Testing (Recommended First)
- [ ] Create internal testing track
- [ ] Upload AAB file to internal testing
- [ ] Add testers (yourself + few others)
- [ ] Test thoroughly
- [ ] Fix any issues found
- [ ] Verify everything works perfectly

#### 6.2 Production Release
- [ ] Upload AAB file to Production track
- [ ] Review all sections are complete
- [ ] Verify store listing looks good
- [ ] Check app content policy compliance
- [ ] Submit for review
- [ ] Monitor review status via email

#### 6.3 After Submission
- [ ] Monitor review status
- [ ] Respond promptly to any questions
- [ ] If rejected, review reasons and fix
- [ ] Resubmit if needed

## Final Verification Before Submission

Run through this final checklist:

**Technical:**
- [ ] Release keystore created and configured
- [ ] `flutter build appbundle --release` succeeds
- [ ] AAB file exists and is valid
- [ ] Tested release build on physical device
- [ ] All features work correctly
- [ ] No crashes or critical bugs

**Store Listing:**
- [ ] All graphics prepared and uploaded
- [ ] Descriptions written and proofread
- [ ] All required fields completed

**Compliance:**
- [ ] Privacy policy created and hosted (HTTPS URL)
- [ ] Privacy policy URL added to Play Console
- [ ] Data Safety section completed accurately
- [ ] Content rating completed
- [ ] App doesn't violate Google Play policies

**Quality:**
- [ ] Thoroughly tested on physical device(s)
- [ ] Performance is acceptable
- [ ] User experience is smooth
- [ ] No obvious issues

## Quick Reference

### Build Commands
```bash
# Clean and prepare
flutter clean
flutter pub get

# Build release app bundle (for Play Store)
flutter build appbundle --release

# Build release APK (for testing)
flutter build apk --release
```

### File Locations
- AAB file: `build/app/outputs/bundle/release/app-release.aab`
- Keystore: `android/keystore/upload-keystore.jks` (create this)
- Key properties: `android/app/key.properties` (create from template)

### Important Links
- [Google Play Console](https://play.google.com/console)
- [Google Play Policy](https://play.google.com/about/developer-content-policy/)
- [Flutter Release Guide](https://docs.flutter.dev/deployment/android)

## Timeline Estimate

- Keystore setup: 10 minutes
- Build and test: 30-60 minutes
- Store listing preparation: 2-4 hours (graphics, descriptions)
- Privacy policy: 1-2 hours
- Play Console setup: 1-2 hours
- **Total: 5-10 hours** (depending on graphics experience)

## Success Criteria

Your submission is ready when:
✅ All checkboxes above are checked
✅ You've tested the release build thoroughly
✅ All required materials are prepared
✅ Play Console sections are complete
✅ You're confident the app is ready for users

Good luck with your first Play Store submission! 🚀

