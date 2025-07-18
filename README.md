# cystella
# 🌸 Cystella - Patient App

**Cystella** is a Flutter-based mobile application tailored for patients to access healthcare services, communicate with doctors, and manage their health efficiently. It integrates with a backend system via RESTful APIs hosted on local IP addresses.

---

## 🛠️ Getting Started

### 📦 Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/b-ukusi/cystella.git
   cd cystella
2.Install dependencies:
flutter pub get


3.Run the app:
flutter run

Important Notes
✅ Update IP Addresses:

The app uses hardcoded local IP addresses (e.g. http://192.168.x.x:8000) to communicate with the backend.

Before running, search the project for file auth_service.dart in the folder services under lib , and replace the Ip's with your local machine/server IP.

4.Backend Required:

Ensure the backend API server is up and running on the same network.



