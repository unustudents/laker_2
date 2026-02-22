import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}


val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.unustudents.laker2"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.14206865"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.unustudents.laker2"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
                
        // Additional security configurations
        multiDexEnabled = true
        
        // Disable debugging in release builds
        manifestPlaceholders["usesCleartextTraffic"] = "false"
    }

    signingConfigs {
        if (keystorePropertiesFile.exists()) {
            create("release") {
                keyAlias = keystoreProperties["keyAlias"]?.toString()
                keyPassword = keystoreProperties["keyPassword"]?.toString()
                storeFile = file(keystoreProperties["storeFile"]?.toString() ?: "")
                storePassword = keystoreProperties["storePassword"]?.toString()
            }
        }
    }

    buildTypes {
        release {
            if(keystorePropertiesFile.exists()){
                // Signing configuration
                signingConfig = signingConfigs.getByName("release")
            }
            
            // Enable code shrinking, obfuscation, and optimization
            isMinifyEnabled = true
            isShrinkResources = true
            
            // ProGuard rules for obfuscation
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            
            // Additional security flags
            ndk {
                debugSymbolLevel = "FULL"
            }
        }
    }
}

flutter {
    source = "../.."
}


dependencies {
    // Google Play Core - Updated untuk kompatibilitas dengan Android 14 (SDK 34)
    // Play Core library sudah deprecated, gunakan Google Play Services
    implementation("com.google.android.gms:play-services-base:18.5.0")
    
    // Untuk App Update & In-App Review (opsional)
    // implementation("com.google.android.play:app-update:2.1.0")
    // implementation("com.google.android.play:review:2.0.1")
}
