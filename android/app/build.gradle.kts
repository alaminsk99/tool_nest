plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.ariact.toolest"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" ?: flutter.ndkVersion

    defaultConfig {
        applicationId = "com.ariact.toolest"
        minSdk = 23
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        resConfigs("en")
    }

    signingConfigs {
        create("release") {
            storeFile = file("../keystore/toolest-key.jks")
            storePassword = "31326465"
            keyAlias = "toolestkey"
            keyPassword = "31326465"
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release") //  Use  release key
            isMinifyEnabled = false
            isShrinkResources = false
            // Optional: Enable these for optimization
            // proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }
}

flutter {
    source = "../.."
}

dependencies {
    //  add custom dependencies here if needed
}
