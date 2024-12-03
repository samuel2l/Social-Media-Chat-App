# WhatsApp Clone - A Messaging App Built with Flutter & Firebase

This project is a WhatsApp clone, a real-time messaging application built using Flutter and Firebase. It allows users to send text messages, share media, and manage contacts, mimicking the core functionalities of the popular messaging app WhatsApp.

## Features

- **User Authentication**: Sign up and log in with Firebase Authentication.
- **Real-time Messaging**: Send and receive messages instantly using Firebase Firestore.
- **Multimedia Sharing**: Share images, videos, and documents.
- **Group Chats**: Create and manage group chats with multiple participants.
- **Profile Management**: Users can update their profile picture and display name.
- **Status Updates**: Post and view status updates even with captions.
- **End-to-End Encryption**: Messages are encrypted end-to-end to ensure privacy.
- **User Presence**: See if users are online or typing.

## Architecture

The WhatsApp Clone follows a client-server architecture with the following components:

- **Frontend (Flutter)**: The mobile app frontend that communicates with the backend (Firebase).
- **Backend (Firebase)**:
  - **Firebase Authentication**: Manages user login and registration.
  - **Firebase Firestore**: Real-time database used for storing messages, user data, and group information.
  - **Firebase Storage**: Used for storing and retrieving media files such as images, videos, and documents.
  - **Firebase Cloud Messaging (FCM)**: For sending push notifications to users when they receive new messages or notifications.
  - **Firebase Functions**: Serverless functions for advanced features like automatic message deletion or status updates.
