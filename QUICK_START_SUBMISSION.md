# Quick Start Guide: First Play Store Submission

This is your step-by-step guide to submit your app to Google Play Store.

## 🚀 Step 1: Create Release Keystore (5 minutes)

```bash
# Navigate to project root
cd E:\projects\quan_play

# Create keystore directory
mkdir android\keystore

# Generate keystore (you'll be prompted for passwords and info)
keytool -genkey -v -keystore android\keystore\upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

**Important:**
- Choose strong passwords (save them!)
- Fill in your name, organization, city, state, country
- Save passwords in a password manager
- **Backup the keystore file securely**

## 📝 Step 2: Configure Key Properties (2 minutes)

1. Copy the template:
   ```bash
   copy android\key.properties.template android\app\key.properties
   ```

2. Edit `android\app\key.properties` and fill in:
   ```properties
   storePassword=YOUR_KEYSTORE_PASSWORD
   keyPassword=YOUR_KEY_PASSWORD
   keyAlias=upload
   storeFile=../keystore/upload-keystore.jks
   ```

## 🔨 Step 3: Build Release App Bundle (5 minutes)

```bash
# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build release app bundle
flutter build appbundle --release
```

**Verify:**
- Check that `build\app\outputs\bundle\release\app-release.aab` exists
- File should be several MB in size
- No errors in build output

## 📱 Step 4: Test Release Build (30 minutes)

```bash
# Build release APK for testing
flutter build apk --release

# Install on connected device
flutter install --release
```

**Test thoroughly:**
- Launch app
- Test video playback
- Test all features
- Check for crashes or bugs
- Verify ads work (test ads)

## 🎨 Step 5: Prepare Store Listing Materials (2-4 hours)

### Required Assets:
1. **App Icon**: 512 x 512 pixels (PNG)
2. **Feature Graphic**: 1024 x 500 pixels (PNG/JPG)
3. **Screenshots**: At least 2 (recommended 6-8), various sizes
4. **Descriptions**: Short (80 chars) and Full (4000 chars)

### How to Create Screenshots:
1. Install release APK on device/emulator
2. Navigate through app showing key features
3. Take screenshots (Power + Volume Down on Android)
4. Edit if needed (add text, crop, etc.)

### App Descriptions:
- **Short**: "Stream videos from URLs with advanced controls, quality selection, and local link management."
- **Full**: Write detailed description highlighting features, benefits, use cases

## 📄 Step 6: Create Privacy Policy (1-2 hours)

**Required content:**
- Data collection (Google Ads SDK)
- Data usage (advertising)
- Third-party services (Google)
- Local storage (ObjectBox - not shared)
- Contact information
- Last updated date

**Hosting (choose one):**
- GitHub Pages (free, recommended)
- Netlify (free)
- Firebase Hosting (free)

**GitHub Pages quick setup:**
1. Create `docs/privacy-policy.html` in your repo
2. Enable GitHub Pages in repo settings
3. URL will be: `https://YOUR_USERNAME.github.io/YOUR_REPO/privacy-policy.html`

## 🏪 Step 7: Google Play Console Setup (1-2 hours)

### 7.1 Create Account
1. Go to https://play.google.com/console
2. Pay $25 one-time registration fee
3. Complete account setup

### 7.2 Create App
1. Click "Create app"
2. Fill in app details:
   - App name: "Tsalul URL Player" (or your choice)
   - Default language: Your language
   - App type: App
   - Free or Paid: Free
3. Create app

### 7.3 Complete Store Listing
1. Go to "Store presence" > "Main store listing"
2. Upload app icon (512x512)
3. Upload feature graphic (1024x500)
4. Upload screenshots (at least 2)
5. Add short description
6. Add full description
7. Add privacy policy URL
8. Fill in contact details
9. Select app category
10. Save

### 7.4 Content Rating
1. Go to "Store presence" > "Content rating"
2. Complete IARC questionnaire
   - App type: App
   - Content: Video player, user-provided URLs
   - Answer questions honestly
3. Submit for rating
4. Receive rating (usually instant)

### 7.5 Data Safety
1. Go to "App content" > "Data safety"
2. Complete all sections:
   - Data collection: Yes (Google Ads SDK)
   - Data types: App info, Device IDs, Advertising IDs
   - Data usage: Advertising
   - Data sharing: Yes (with Google)
   - Security practices: Describe your practices
3. Save

### 7.6 App Content
1. Go to "App content"
2. Complete:
   - App access: Free
   - Ads: Yes (Google Mobile Ads)
   - Target audience: Appropriate age
   - Other sections as applicable
3. Save

## 📤 Step 8: Upload and Submit (15 minutes)

### 8.1 Upload AAB
1. Go to "Production" > "Create new release"
2. Upload `build\app\outputs\bundle\release\app-release.aab`
3. Add release notes (for future updates)
4. Review release

### 8.2 Final Review
1. Verify all sections are complete (green checkmarks)
2. Review app content policy compliance
3. Check store listing preview
4. Ensure no warnings or errors

### 8.3 Submit for Review
1. Click "Submit for review"
2. Confirm submission
3. Monitor status via email
4. Typically reviewed in 1-3 days (up to 7 days)

## ✅ Post-Submission

### While Waiting:
- [ ] Monitor email for updates
- [ ] Check Play Console for status
- [ ] Be ready to respond to questions

### If Approved:
- [ ] 🎉 Celebrate!
- [ ] Monitor user reviews
- [ ] Track analytics
- [ ] Plan updates

### If Rejected:
- [ ] Read rejection reason carefully
- [ ] Fix identified issues
- [ ] Update app if needed
- [ ] Resubmit with explanation

## 📊 Estimated Timeline

| Task | Time |
|------|------|
| Keystore setup | 5 min |
| Build and test | 30 min |
| Store listing materials | 2-4 hours |
| Privacy policy | 1-2 hours |
| Play Console setup | 1-2 hours |
| **Total** | **5-10 hours** |

## 🆘 Troubleshooting

### Build fails:
- Check keystore is configured correctly
- Verify `key.properties` file exists and is correct
- Run `flutter clean` and rebuild

### Keystore issues:
- Verify file path in `key.properties` is correct
- Check passwords match what you set
- Ensure keystore file exists

### Play Console errors:
- Read error messages carefully
- Complete all required sections (marked with *)
- Verify file formats and sizes

## 📚 Additional Resources

- [Flutter Release Guide](https://docs.flutter.dev/deployment/android)
- [Google Play Console Help](https://support.google.com/googleplay/android-developer)
- [Play Store Policy](https://play.google.com/about/developer-content-policy/)
- [Privacy Policy Generator](https://www.freeprivacypolicy.com/)

---

**You've got this!** Follow this guide step-by-step, and your app will be on the Play Store soon. 🚀

