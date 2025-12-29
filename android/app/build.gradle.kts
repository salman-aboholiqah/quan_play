plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties
import java.io.File

// Load keystore properties from key.properties file
val keystorePropertiesFile = rootProject.file("app/key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use { keystoreProperties.load(it) }
}

android {
    namespace = "com.quansoft.url_player"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.quansoft.url_player"
        minSdk = 23
        // Explicitly set targetSdk to 34 (Android 14) to meet Google Play requirements
        // Flutter 3.29.0 defaults should be sufficient, but explicit is better
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            if (keystorePropertiesFile.exists()) {
                val storeFileProperty = keystoreProperties["storeFile"] as String?
                if (storeFileProperty != null) {
                    // Resolve path relative to android directory (rootProject.projectDir)
                    val normalizedPath = storeFileProperty.replace("../", "")
                    val keystoreFile = File(rootProject.projectDir, normalizedPath)
                    if (keystoreFile.exists()) {
                        val keyAliasProperty = keystoreProperties["keyAlias"] as String?
                        val keyPasswordProperty = keystoreProperties["keyPassword"] as String?
                        val storePasswordProperty = keystoreProperties["storePassword"] as String?
                        
                        if (keyAliasProperty != null && keyPasswordProperty != null && storePasswordProperty != null) {
                            keyAlias = keyAliasProperty
                            keyPassword = keyPasswordProperty
                            storeFile = keystoreFile
                            storePassword = storePasswordProperty
                        }
                    }
                }
            }
        }
    }

    buildTypes {
        release {
            // Use release signing config if properly configured, otherwise fall back to debug for development
            val releaseSigningConfig = signingConfigs.findByName("release")
            val storeFile = releaseSigningConfig?.storeFile
            signingConfig = if (releaseSigningConfig != null && 
                               storeFile != null && 
                               storeFile.exists() &&
                               releaseSigningConfig.keyAlias != null) {
                releaseSigningConfig
            } else {
                signingConfigs.getByName("debug")
            }
            
            // Enable code shrinking, obfuscation, and optimization
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Google Play Core library for Flutter deferred components support
    // This is required to avoid R8 missing class errors
    implementation("com.google.android.play:core:1.10.3")
    implementation("com.google.android.play:core-ktx:1.8.1")
}
