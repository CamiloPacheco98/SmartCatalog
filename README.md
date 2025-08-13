# 🧠🛍️ Smart Catalog

**Smart Catalog** Smart Catalog is a mobile application that turns printed magazine pages into interactive shopping catalogs. It allows users to browse, view, and order products directly from scanned magazine content. The app is designed to facilitate product sales through catalogs, making it easier and more efficient to showcase products and place orders.

---

## 🚀 Features

- Splash screen and onboarding
- User authentication with Firebase
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

---

## 📁 Project Structure

```bash
SmartCatalog/
├─ lib/
│  ├─ app/
│  │  └─ routes/
│  ├─ core/
│  │  ├─ constants/
│  │  ├─ theme/
│  │  ├─ utils/
│  │  └─ widgets/
│  ├─ extensions/
│  ├─ features/
│  │  ├─ auth/
│  │  │  ├─ data/
│  │  │  ├─ domain/
│  │  │  └─ presentation/
│  │  ├─ catalog/
│  │  │  ├─ data/
│  │  │  ├─ domain/
│  │  │  └─ presentation/
│  │  ├─ splash/
│  │  └─ tabbar/
│  └─ main.dart

