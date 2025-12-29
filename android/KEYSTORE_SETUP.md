# Keystore Setup Instructions

## Generate a Release Keystore

1. **Create a keystore directory** (optional, but recommended for organization):
   ```bash
   mkdir android/keystore
   ```

2. **Generate the keystore file**:
   ```bash
   keytool -genkey -v -keystore android/keystore/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

   You will be prompted for:
   - Keystore password (remember this!)
   - Key password (can be same as keystore password)
   - Your name, organizational unit, organization, city, state, and country code
   - Confirmation

3. **Create key.properties file**:
   - Copy `android/key.properties.template` to `android/app/key.properties`
   - Open `android/app/key.properties` and fill in your keystore details:
   
   ```properties
   storePassword=YOUR_KEYSTORE_PASSWORD
   keyPassword=YOUR_KEY_PASSWORD
   keyAlias=upload
   storeFile=../keystore/upload-keystore.jks
   ```

   **Important**: Use relative path from `android/app/` directory. If your keystore is at `android/keystore/upload-keystore.jks`, use `../keystore/upload-keystore.jks`

4. **Verify the setup**:
   - The `key.properties` file is automatically ignored by git (configured in `.gitignore`)
   - The keystore file should also be backed up securely (you cannot recover it if lost!)
   - Keep your keystore password safe - you'll need it for all future releases

## Backup Your Keystore

**CRITICAL**: Back up your keystore file and passwords securely. If you lose the keystore or forget the password, you will not be able to update your app on Google Play Store.

- Store the keystore file in a secure location (encrypted backup, password manager, etc.)
- Store the passwords in a password manager
- Consider using Google Play App Signing for additional security

## Building Release App Bundle

After setting up the keystore, build your release app bundle:

```bash
flutter build appbundle --release
```

The signed AAB file will be generated at: `build/app/outputs/bundle/release/app-release.aab`

This is the file you upload to Google Play Console.

