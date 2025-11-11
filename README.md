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
```

---

## 🏗️ Architecture

El proyecto sigue **Clean Architecture** con el patrón **BLoC (Cubit)** para la gestión de estado. La arquitectura está organizada en capas independientes que facilitan el mantenimiento, testing y escalabilidad.

### Diagrama de Arquitectura

```mermaid
graph TB
    subgraph "Presentation Layer"
        UI[Pages & Views]
        Cubit[BLoC Cubits]
        UI --> Cubit
    end
    
    subgraph "Domain Layer"
        Entities[Entities]
        Repos[Repository Interfaces]
        UseCases[Business Logic]
        Cubit --> Repos
        Repos --> Entities
    end
    
    subgraph "Data Layer"
        RepoImpl[Repository Implementations]
        Models[Data Models]
        DataSources[Data Sources]
        Repos -.->|implements| RepoImpl
        RepoImpl --> Models
        RepoImpl --> DataSources
    end
    
    subgraph "External Services"
        Firebase[Firebase Services]
        Hive[Hive Local Storage]
        DataSources --> Firebase
        DataSources --> Hive
    end
    
    subgraph "Core Module"
        Session[Session Management]
        Utils[Utilities]
        Theme[Theme]
        Constants[Constants]
        UI --> Session
        UI --> Utils
        UI --> Theme
    end
    
    subgraph "Features"
        Auth[Auth Feature]
        Catalog[Catalog Feature]
        Cart[Cart Feature]
        Orders[Orders Feature]
        Profile[Profile Feature]
        Settings[Settings Feature]
        Splash[Splash Feature]
    end
    
    style UI fill:#e1f5ff
    style Cubit fill:#e1f5ff
    style Entities fill:#fff4e1
    style Repos fill:#fff4e1
    style RepoImpl fill:#f3e5f5
    style Models fill:#f3e5f5
    style DataSources fill:#f3e5f5
    style Firebase fill:#ffebee
    style Hive fill:#ffebee
```

### Flujo de Datos

```mermaid
sequenceDiagram
    participant UI as UI/View
    participant Cubit as BLoC Cubit
    participant Repo as Repository Interface
    participant RepoImpl as Repository Implementation
    participant DataSource as Data Source
    participant Firebase as Firebase/Hive
    
    UI->>Cubit: User Action
    Cubit->>Repo: Call Repository Method
    Repo->>RepoImpl: Implementation
    RepoImpl->>DataSource: Fetch/Update Data
    DataSource->>Firebase: API Call / Local Storage
    Firebase-->>DataSource: Response
    DataSource-->>RepoImpl: Data/Entity
    RepoImpl-->>Repo: Entity
    Repo-->>Cubit: Entity
    Cubit->>Cubit: Emit New State
    Cubit-->>UI: State Update
    UI->>UI: Rebuild UI
```

### Capas de la Arquitectura

#### 🎨 **Presentation Layer**
- **Responsabilidad**: Interfaz de usuario y gestión de estado
- **Componentes**:
  - `Pages`: Pantallas de la aplicación
  - `Views`: Widgets de presentación
  - `Cubits`: Gestión de estado con BLoC pattern
  - `Models`: ViewModels para la UI

#### 🧠 **Domain Layer**
- **Responsabilidad**: Lógica de negocio pura (independiente de frameworks)
- **Componentes**:
  - `Entities`: Objetos de dominio
  - `Repository Interfaces`: Contratos para acceso a datos
  - `Use Cases`: Lógica de negocio (implícita en los repositorios)

#### 💾 **Data Layer**
- **Responsabilidad**: Implementación de acceso a datos
- **Componentes**:
  - `Repository Implementations`: Implementación de repositorios
  - `Data Models`: Modelos de datos (JSON serialization)
  - `Data Sources`: Fuentes de datos (Firebase, Hive)

#### 🔧 **Core Module**
- **Responsabilidad**: Funcionalidades compartidas
- **Componentes**:
  - `Session Management`: Gestión de sesiones de usuario, carrito, catálogo
  - `Utils`: Utilidades (navegación, validadores, formatters)
  - `Theme`: Configuración de temas
  - `Constants`: Constantes de la aplicación
  - `Widgets`: Widgets reutilizables

### Dependencias Externas

- **Firebase**: Autenticación, base de datos (Firestore) y almacenamiento
- **Hive**: Almacenamiento local para carrito, órdenes y configuración
- **GetIt**: Inyección de dependencias
- **GoRouter**: Navegación declarativa
- **Easy Localization**: Internacionalización (i18n)


### Home Screen
![Home Screen](assets/readme/IMG_4995.png)

### Login Screen
![Login](assets/readme/IMG_4993.png)

### Loading
![Loading](assets/readme/IMG_4994.png)

## Add to Shopping Cart
![Add to Shopping Cart](assets/readme/IMG_4996.png)
