#!/bin/sh
cp -R ios/Runner.xcodeproj_beta/project.pbxproj ios/Runner.xcodeproj/project.pbxproj
cp android/app/build_beta.gradle android/app/build.gradle
cp android/app/google-services_beta.json android/app/google-services.json
cp android/app/src/main/AndroidManifest_beta.xml android/app/src/main/AndroidManifest.xml
cp android/app/src/debug/AndroidManifest_beta.xml android/app/src/debug/AndroidManifest.xml
cp android/app/src/main/kotlin/com/xemotransfer/mobileapp/MainActivity_beta.txt android/app/src/main/kotlin/com/xemotransfer/mobileapp/MainActivity.kt
cp lib/firebase_options_beta.dart lib/firebase_options.dart