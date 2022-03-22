# caro_unsplash

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Run and Compile this app 

These app is for connet with UnSplash, is easy to use and compile. Just you have to follow the steps. 

### Run

if you want to run the app you have to create a user on [UnSplash Developers](https://unsplash.com/developers) and you have to register a New app on UnSplash for to have an AccessKEY.

The code dosent'n have AccessKEY, You neet to implement an eviroment var. you have to Called ACCES_KEY.

### Run in console

```
$ flutter run --dart-define=ACCES_KEY=<<your access_key>>
```

## Build an Apk file

### Obfuscating your app

```
$ flutter build apk --obfuscate --split-debug-info=/<project-name>/<directory>
```

```
$ flutter build apk --target-platform android-arm64 --split-per-abi --obfuscate --split-debug-info=ofuscate

```

***Note: only 64 bits devices***


