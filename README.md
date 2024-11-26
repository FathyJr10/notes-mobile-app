## Notes App 📒

A mobile application built with Flutter and Firebase, designed to help users create, organize, and manage their notes efficiently.
This app allows users to categorize notes for easier organization, perform CRUD operations (Create, Read, Update, Delete),
and securely sign in using Google authentication or email/password sign-in.

## Features
 User Authentication: Sign in with Google account for secure access to your notes.
 Categorized Notes: Save notes under different categories for easy organization.
 CRUD Operations: Perform full CRUD operations to add, view, edit, and delete notes.
 Real-time Sync with Firebase: Notes are stored in Firebase Firestore, allowing instant updates and access across devices.
 Offline Support: Access notes even when offline. Changes sync automatically when reconnected.

## Tech Stack
Frontend: Flutter (Dart)
Backend: Firebase (Firestore, Authentication)
State Management: Provider (or other preferred state management solution)

## App Structure
Firebase Authentication: Allows users to log in using Google or using email/password, ensuring secure access to personal notes.

## Firestore Database Structure:

categories Collection:
Each document represents a category of notes.
Fields include category name and other metadata.
notes Subcollection (under each category):
Each note has fields like title, content, timestamp, and noteID.
User Interface:

Home Screen: Displays a list of categories, allowing users to select a category and view associated notes.
Notes Screen: Shows a list of notes within a selected category. Users can add, edit, or delete notes here.
Edit/Add Note Screen: Allows users to create a new note or update an existing one.



## Firebase Integration
Firestore Database:

The app uses Firestore as the database to store and categorize notes.
Each user’s data is stored under their unique user ID to ensure privacy.
Google Authentication:

Firebase Authentication is used for Google sign-in.
Ensures secure, password-less access for users.
Firestore Database Structure:

Main Collection: categories
Subcollection: notes under each category document


This app is a simple, effective solution for anyone looking to organize and manage their notes on the go.
The combination of Flutter’s rich UI and Firebase’s robust backend makes it a reliable and user-friendly app.
