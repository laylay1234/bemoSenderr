# Dev Doc

## Switching between env

### master

```shell
- git checkout master  
- run bash ./checkout_alpha.sh
- amplify env checkout master --restore  
- amplify env pull --restore  

```

### dev

```shell
- git checkout dev  
- run bash ./checkout_beta.sh
- amplify env checkout dev --restore  
- amplify env pull --restore

```  

## Before run Flutter build

### To set up ALPHA environment release (both AppStore and Play Store)

./checkout_alpha.sh

### To set up BETA environment release (both AppStore and Play Store)

./checkout_beta.sh

## To build a release build

### To build an APK release for Android
- Without `--dart-define BUILD_ENV`, default is `--dart-define BUILD_ENV=DEV`

flutter build appbundle --release --no-sound-null-safety [--dart-define BUILD_ENV=[DEV|PROD]]

### To build an AAB (app bundle) release for Android
- Without `--dart-define BUILD_ENV`, default is `--dart-define BUILD_ENV=DEV`

flutter build appbundle --release --no-sound-null-safety [--dart-define BUILD_ENV=[DEV|PROD]]

### To build an APP release for iOS
- Without `--dart-define BUILD_ENV`, default is `--dart-define BUILD_ENV=DEV`

flutter build ios --release --no-sound-null-safety [--dart-define BUILD_ENV=[DEV|PROD]]

### To build an IPA release for iOS
- Without `--dart-define BUILD_ENV`, default is `--dart-define BUILD_ENV=DEV`

flutter build ipa --release --no-sound-null-safety [--dart-define BUILD_ENV=[DEV|PROD]]
