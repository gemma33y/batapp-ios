# BatApp

BatApp is a multi-feature iOS application developed with Swift as part of a mobile application development project.

The application brings together several native iOS features, including user authentication, notes, maps, image galleries, local notifications and multilingual support.

## Features

* User login and authentication interface
* Home screen with access to the main application sections
* Notes management
* Image gallery
* Interactive map
* Local notifications
* Form validation
* Local data persistence
* Support for Catalan, Spanish and English

## Technologies

* Swift
* UIKit
* Xcode
* Core Data
* MapKit
* UserNotifications
* Storyboards
* Auto Layout
* Localization

## Project Structure

```text
BatApp/
├── Controllers/
│   ├── Gallery/
│   ├── Home/
│   ├── Login/
│   ├── Map/
│   ├── Note/
│   └── Notification/
├── Custom Cells/
├── Elements/
├── Localizable/
├── Persistence/
├── Utilities/
├── ca.lproj/
├── en.lproj/
├── es.lproj/
├── AppDelegate.swift
├── SceneDelegate.swift
└── Info.plist
```

### Controllers

The `Controllers` directory contains the view controllers responsible for the main sections of the application:

* `Login`: user login and validation
* `Home`: main application navigation
* `Gallery`: image gallery functionality
* `Map`: map visualization and location-related features
* `Note`: note creation and management
* `Notification`: local notification management

### Elements

The `Elements` directory contains reusable UI components and validation utilities, including:

* Email validation
* Password validation
* Required-field validation
* Custom text fields
* Shared validation protocols

### Persistence

The application uses local persistence to store and manage data between sessions.

### Localization

BatApp supports three languages:

* Catalan
* Spanish
* English

Localized resources are stored in the corresponding `.lproj` directories:

```text
ca.lproj/
es.lproj/
en.lproj/
```

## Requirements

To run the project, you will need:

* macOS
* Xcode
* An iOS Simulator or physical iOS device

No external package manager or third-party dependencies are required.

## Installation

Clone the repository:

```bash
git clone https://github.com/gemma33y/batapp-ios.git
```

Open the project directory:

```bash
cd batapp-ios
```

Open the Xcode project:

```bash
open BatApp.xcodeproj
```

Alternatively, open `BatApp.xcodeproj` directly from Finder.

## Running the Application

1. Open the project in Xcode.
2. Select the `BatApp` scheme.
3. Select an iOS Simulator or connected physical device.
4. Press `Run` or use:

```text
⌘ + R
```

## Architecture

The project follows a view-controller-based structure using UIKit.

Application responsibilities are separated into directories for:

* View controllers
* Reusable interface components
* Persistence
* Utilities
* Localization resources
* Custom table-view cells

This organization keeps the different application features isolated and easier to maintain.

## Screenshots

Add screenshots of the main application sections inside an `images` directory:

```text
images/
├── login.png
├── home.png
├── notes.png
├── gallery.png
└── map.png
```

Then include them in this section:

```markdown
![Login screen](images/login.png)
![Home screen](images/home.png)
![Notes screen](images/notes.png)
![Gallery screen](images/gallery.png)
![Map screen](images/map.png)
```

## Authors

* Gemma Yebra
* Add the remaining project contributors here

## Academic Context

This application was developed as part of a mobile application development course.

## License

This project is intended for educational and portfolio purposes.

Unless a license file is added, all rights remain with the project authors.
