# 🌱 Grow Your Forest

**Grow Your Forest** is a motivational **weight loss app** built with Flutter. It encourages users to build healthy habits by completing **daily tasks** — and rewards their consistency by growing a virtual forest! 🌳

Each time you complete 3 tasks in a day, a tree grows in your forest. Stay consistent, stay healthy, and watch your forest flourish!

---

## 📱 What This App Does

- ✅ Lets you complete **3 daily wellness tasks**
- 🌳 Plants a **tree** in your forest **after 3 tasks are completed**
- 🌿 Includes **3 different tree species**, each with different growth stages:
  - Species 1: 2 growth stages
  - Species 2: 3 growth stages
  - Species 3: 4 growth stages
- 🌲 Once one tree is fully grown, the next one is planted automatically
- 🌄 All trees are drawn using **CustomPainter** – no images used
- 👋 Includes a beautiful **splash screen**
- 🔄 Forest and task logic fully integrated
- 💡 Built using **Flutter + Riverpod**

---

## 🛠 How to Run the App

### ✅ Prerequisites

- Flutter SDK (version 3.10 or above recommended)
- Dart SDK
- Android Studio, VS Code, or any IDE with Flutter support
- A physical device or emulator

### ▶️ Steps to Run

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/grow-your-forest.git
   cd grow-your-forest 
   
2.Install Dependencies
   flutter pub get

3. Run the App
   flutter run

📁 Folder Structure
lib/
│
├── main.dart                 # Entry point of the app
│
├── screens/
│   ├── splash_screen.dart    # Initial splash screen
│   ├── task_screen.dart      # Main screen for daily tasks
│   └── forest_screen.dart    # Forest view showing planted trees
│
├── widgets/
│   └── animated_tree_painter.dart  # CustomPaint for trees & growth
│
├── models/
│   └── tree_model.dart       # Defines species, stages, tree logic

