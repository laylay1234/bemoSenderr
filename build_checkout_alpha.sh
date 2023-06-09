#!/bin/sh
cp -R ios/Runner.xcodeproj_alpha/project.pbxproj ios/Runner.xcodeproj/project.pbxproj
cp android/app/build_alpha.gradle android/app/build.gradle
cp android/app/google-services_alpha.json android/app/google-services.json
cp android/app/src/main/AndroidManifest_alpha.xml android/app/src/main/AndroidManifest.xml
cp android/app/src/debug/AndroidManifest_alpha.xml android/app/src/debug/AndroidManifest.xml
cp android/app/src/main/kotlin/com/xemotransfer/mobileapp/MainActivity_alpha.txt android/app/src/main/kotlin/com/xemotransfer/mobileapp/MainActivity.kt
cp lib/firebase_options_alpha.dart lib/firebase_options.dart