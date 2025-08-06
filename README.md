# 🧠🛍️ Smart Catalog

**Smart Catalog** is a mobile application that turns printed magazine pages into interactive shopping catalogs. Powered by AI, it allows users to browse, view, and order products directly from scanned magazine content.

---

## 🚀 Features

- Splash screen and onboarding
- User authentication with Firebase
- Upload or scan magazine pages
- Product extraction using **Gemini AI**
- Product listing and detail views
- Shopping cart and order placement
- Admin interface for managing catalogs and products

---

## 🛠️ Tech Stack

| Layer            | Technology                       |
|------------------|----------------------------------|
| UI               | Flutter                          |
| Architecture     | Clean Architecture + BLoC        |
| Navigation       | GoRouter                         |
| Backend          | Firebase (Auth, Firestore, Storage) |
| AI Integration   | Gemini AI (Google)               |

---

## 📁 Project Structure

```bash
/lib
├── core                # Shared utilities (errors, usecases, etc.)
├── features/           # Feature modules (e.g., splash, catalog, orders)
│   └── splash/
│       ├── presentation/
│       │   ├── bloc/
│       │   └── pages/
│
├── app/
│   ├── routes/         # GoRouter config and path constants
│   └── themes/         # App theme, UI constants
│
├── injection_container.dart  # get_it setup
└── main.dart
