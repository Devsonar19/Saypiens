# Saypiens

A modern, responsive landing page for the Saypiens community, built with Flutter Web. The project emphasizes "Offline Human Connection, rather than online Algorithms" and features a dark, elegant aesthetic with kinetic typography, interactive grid backgrounds, and responsive layouts across all device sizes.

## Features

* Responsive Architecture: Fluidly adapts to desktop, tablet, and mobile screens using a custom responsive layout builder.
* Kinetic Typography: Custom kinetic text rollers built from scratch for the hero section to create an engaging visual experience.
* Interactive Backgrounds: A mouse and touch-responsive breathing dot grid that illuminates as users interact with the page.
* Clean Architecture: Structured by features (Home, Splash, etc.) with a clear separation of UI components and styling.
* Firebase Integration: Configured for seamless deployment to Firebase Hosting.

## Tech Stack

* Framework: Flutter (Web)
* Language: Dart
* Theming: Google Fonts (Libre Caslon Text, Plus Jakarta Sans, Syne, Cormorant Garamond), custom Material 3 color schemes.
* Deployment: Firebase Hosting

## Getting Started

### Prerequisites

* Flutter SDK (latest stable version)
* Dart SDK
* Firebase CLI (for deployment)

### Installation

1. Clone the repository to your local machine.
2. Navigate to the project directory:
   cd saypiens
3. Install the required dependencies:
   flutter pub get

### Running Locally

To run the application locally in development mode:

flutter run -d chrome

Alternatively, you can run it on a local web server:

flutter run -d web-server --web-port 8080

## Project Structure

The codebase follows a feature-first architecture:

lib/
  core/
    app_constants.dart      - Global application constants
  features/
    home/
      presentation/
        pages/              - Screen-level widgets (e.g., home_page.dart)
        widgets/            - Reusable UI components (Hero, Gatherings, Nav Bar)
  theme/
    app_color.dart          - Centralized application color palette and ThemeData
  utils/
    responsive_layout.dart  - Breakpoint definitions for layout switching

## Deployment

The project is configured for Firebase Hosting. To deploy a new version:

1. Build the production web bundle:
   flutter build web --release

2. Deploy using the Firebase CLI:
   firebase deploy --only hosting

## Licensing

This project is not published to pub.dev (marked as private). All rights reserved.
