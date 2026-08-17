# Flashcard Quiz App

A Flutter mobile app for creating and studying flashcards — flip to reveal answers, navigate with Next/Previous, and manage your own deck. Built as **Task #1** for the CodeAlpha App Development Internship.

---

## 📋 Overview

Flashcard Quiz App lets you build your own study deck: add a question and answer, then review it in Study mode where tapping the card (or pressing "Show Answer") flips it to reveal the answer. Cards are saved locally, so your deck is there every time you reopen the app.

---

## ✨ Features

- **Question on front, answer on back** — tap the card or press "Show Answer" to flip it (animated 3D flip).
- **Next / Previous navigation** — move through your deck in Study mode, wrapping around at either end.
- **Add, edit, and delete flashcards** — full customization of your own deck from the Home screen.
- **Simple, clean UI** — Material 3 design, minimal color palette, no clutter.
- Starter deck of 3 example flashcards seeded on first launch, so the app isn't empty out of the box.

---

## 🛠️ Tech Stack

- **Framework:** Flutter (Dart)
- **State Management:** StatefulWidget + setState (single-user, local-only app — no external state library needed)
- **Local Storage:** SQLite via the `sqflite` package
- **Architecture:** Feature-first (models / database / screens / widgets)

---

## 🏗️ Architecture

```
lib/
├── main.dart                          # App entry point, theme setup
├── models/
│   └── flashcard.dart                  # Flashcard data model
├── database/
│   └── database_helper.dart            # SQLite CRUD (singleton)
├── screens/
│   ├── home_screen.dart                # List, add/edit/delete, entry to study mode
│   ├── study_screen.dart               # Flip card, Show Answer, Next/Previous
│   └── add_edit_flashcard_screen.dart  # Shared form for add + edit
└── widgets/
    └── flip_card_widget.dart           # Reusable animated flip-card UI
```

---

## 🔑 Scope Decisions (Documented for Transparency)

**Local storage over cloud:** The task brief doesn't specify a storage method for this app. For a single-user study tool like flashcards, local SQLite storage is the right fit — no login, no network dependency, works fully offline, matching how a real flashcard app (e.g. Anki) behaves.

**No authentication / roles:** This app has a single user role by design — the task brief doesn't call for multi-user or admin-style access, so no auth layer was added, keeping the app focused on exactly what was asked.

**Wrap-around navigation:** Next/Previous wrap around (last → first and first → last) instead of disabling at the ends, so studying flows as a continuous loop.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable) — [Install guide](https://docs.flutter.dev/get-started/install)
- Android Studio (or VS Code) with the Flutter/Dart plugins
- An Android emulator or physical device

### Setup

1. Clone the repository
   ```
   git clone https://github.com/Muhammad-Hassan-3077/CodeAlpha_FlashcardQuizApp.git
   cd CodeAlpha_FlashcardQuizApp
   ```

2. Install dependencies
   ```
   flutter pub get
   ```

3. Run the app
   ```
   flutter run
   ```

No backend setup, API keys, or environment configuration required — the app works fully offline.

---

## 📱 Screens

| Screen | Description |
|---|---|
| Home Screen | List of all flashcards; add (+), edit, delete, and tap-to-study actions |
| Add/Edit Screen | Form with Question, Answer, Category fields; validates non-empty question/answer |
| Study Screen | Animated flip card, Show/Hide Answer, Next/Previous navigation |

---

## 👤 Author

**Muhammad Hassan**
Flutter Developer Intern — CodeAlpha
Task #1: Flashcard Quiz App