# Artifacts MMO Flutter App

This Flutter app provides a basic user interface for interacting with the [Artifacts MMO](https://artifactsmmo.com) game API. The app will allow players to manage their in-game characters, access game data, and perform various actions within the game directly from web and maybe eventually from a mobile device. High hopes.

## Feature Goals

- **Character Management:** View and manage your in-game characters.
    - ***Multiple character management:*** Eventually I'd like to add management for multiple characters like the API allows.
- **Game Data Access:** Retrieve and display game-related data such as stats, inventory, and more.
- **API Integration:** Interacts with the Artifacts MMO API.

## Getting Started

To set up this project on your local machine, follow these steps:

### 1. Fork and Clone the Repository

1. Fork this repository to your GitHub account.
2. Clone the forked repository to your local machine:
   ```bash
   git clone https://github.com/your-username/artifactsmmo-flutter-app.git
   cd artifactsmmo-flutter-app
   ```

### 2. Create an Account on Artifacts MMO

You will need an account on [Artifacts MMO](https://artifactsmmo.com) to use the API. 

1. Sign up for an account on the [Artifacts MMO website](https://artifactsmmo.com).
2. Once signed in, obtain your server address, private token, and character name.

### 3. Configure App Settings

1. Open the `lib/assets/app_settings.config.dart` file.
2. Enter the following information in the file:
   - **Server Address:** The API server address.
   - **Private Token:** The private token you received when signing up.
   - **Character Name:** Your in-game character's name.

   Example configuration:
   ```dart
   final Map<String, String> config = {
  "server": "https://api.artifactsmmo.com",
  "token": "your-token",
  "character": "your-character-name"
};

   ```

### 4. Set Up the Development Environment

If you don't already have Flutter and Dart installed on your machine, follow the instructions [here](https://flutter.dev/docs/get-started/install) to set up the environment.

### 5. Install Dependencies and Build the Project

Run the following commands in your terminal:

```bash
flutter clean
flutter pub get
```

These commands will clean any existing build files and install all the necessary dependencies for the project.

### 6. Run the App

You can now run the app on an emulator or a physical device:

```bash
flutter run
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with your changes.