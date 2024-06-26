# Lo-Fi Radio

Welcome to the Lo-Fi Radio app! This is a Flutter application designed to stream lo-fi music. 

## Features

- Stream lo-fi music from various sources.
- User-friendly interface with a sleek design.
- Background play support.
- Play, pause, and skip tracks.

## Screenshots

(Add some screenshots of your app here)

## Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed the latest version of [Flutter](https://flutter.dev/docs/get-started/install).
- You have a [GitHub](https://github.com/) account.
- You have installed [Git](https://git-scm.com/).
- You have a device or emulator to run the app.

## Setup Instructions

### 1. Clone the Repository

Open your terminal and run the following command:

```bash
git clone https://github.com/mash3al-29/lo-fi-radio.git
```
Navigate to the project directory:

```bash
cd lo-fi-radio
```
Run the following command to get the required dependencies:

``` bash
flutter pub get
```
Connect your device or start an emulator, then run:

``` bash
flutter run
```
To build an APK for debug, run:
``` bash
flutter build apk --debug
```

## Firebase Integration
The app uses Firebase for authentication and other backend services. Ensure you have set up a Firebase project and configured it for your app.

### Steps to Setup Firebase
1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Create a new project or select an existing project.
3. Add an Android app to your Firebase project.
4. Register your app with the package name (e.g., `com.example.lofiradio`).
5. Download the `google-services.json` file and place it in the `android/app` directory.
6. Add the Firebase SDK to your project by following the [Firebase setup instructions](https://firebase.google.com/docs/flutter/setup).

## Contributing
Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit them (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a pull request.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact
If you have any questions or feedback, feel free to contact me at abdelrahmanmashaal@gmail.com.

