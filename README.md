# 📱 Task Manager App (Flutter)

## 🚀 Overview

This is a Flutter-based Task Management application built as part of an assignment. The app allows users to create, manage, and track tasks efficiently with support for dependencies, search, filtering, and persistent local storage.

---

## ✨ Features

### ✅ Core Features

* Create, Read, Update, Delete (CRUD) tasks
* Each task includes:

  * Title
  * Description
  * Due Date
  * Status (To-Do, In Progress, Done)
  * Blocked By (dependency on another task)

### 🔗 Task Dependency

* Tasks can depend on other tasks using **Blocked By**
* Blocked tasks are visually disabled (greyed out)
* Automatically become active when dependency is marked as **Done**

### 🔍 Search & Filter

* Search tasks by title
* Filter tasks by status

### 💾 Draft Persistence

* Unsaved task data is preserved if user exits the screen accidentally

### ⏳ Async Loading

* Simulated 2-second delay for create/update operations
* Loading indicator shown
* Prevents duplicate submissions

---

## 🧠 Tech Stack

* **Flutter (Dart)**
* **Provider** (State Management)
* **Hive** (Local Database)

---

## 📂 Project Structure

```bash
lib/
│── models/        # Task model
│── providers/     # State management (TaskProvider)
│── screens/       # UI screens (Home, Add/Edit)
│── widgets/       # Reusable widgets (TaskCard)
│── main.dart      # Entry point
```

---

## 🛠️ Setup Instructions

### 1. Clone Repository

```bash
git clone https://github.com/yourusername/task-manager-flutter.git
```

### 2. Navigate to Project

```bash
cd task_manager_app
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run Application

```bash
flutter run
```

---

## 🎯 Track Chosen

**Track B: Mobile Specialist**

* Implemented using Flutter with local database (Hive)
* Focused on clean UI/UX and smooth user experience

---

## ⚡ Key Technical Decisions

* Used **Provider** for simple and scalable state management
* Used **Hive** for fast and lightweight local storage
* Implemented **dependency logic** for blocked tasks
* Simulated API delay to mimic real-world scenarios

---

## 🤖 AI Usage

* Used AI tools (ChatGPT) for:

  * Project structure guidance
  * Debugging setup issues (NDK, SDK)
  * Improving UI and logic

* Example issue:

  * Faced NDK error during build
  * Resolved by reinstalling SDK components

---

## 🎥 Demo Video

👉 (https://drive.google.com/file/d/11GlIBROjnhpoJvsETP9DcIHBDa_qdGo5/view?usp=sharing)

---

## 📌 Future Improvements

* Debounced search with highlighted results
* Drag-and-drop task reordering
* Better UI animations and transitions

---

## 👨‍💻 Author

**Suraj Golambade**
