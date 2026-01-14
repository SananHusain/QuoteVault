# QuoteVault 📱✨

QuoteVault is a modern iOS application built with SwiftUI that helps users discover, save, organize, and share inspirational quotes.  
The app uses Supabase as a backend for authentication and cloud data sync, and includes a Home Screen widget for daily inspiration.

---

## 🚀 Features

### 🔐 Authentication
- Email & password signup
- Login / Logout
- Email verification
- Forgot password support

### 📖 Quotes
- Browse all quotes
- Search quotes by text
- Daily “Quote of the Day”
- Clean, card-based UI

### ❤️ Favorites
- Save / remove favorite quotes
- Cloud synced with Supabase
- Available across devices

### 📁 Collections
- Create custom collections
- Add / remove quotes from collections
- View quotes inside collections
- Per-user secure storage (RLS)

### 📤 Sharing
- Share quotes as **text** via system share sheet
- Save quotes as **images** to Photos
- Multiple quote card styles

### 🎨 Personalization
- Dark Mode support
- Adjustable font size
- Multiple quote card styles (Classic, Gradient, Minimal)

### 🧩 Home Screen Widget
- Displays Quote of the Day
- Updates daily
- Uses WidgetKit + App Groups
- Supports iOS 16 & iOS 17 (`containerBackground`)

---

## 🛠 Tech Stack

- **SwiftUI**
- **MVVM Architecture**
- **Supabase**
  - Authentication
  - PostgreSQL Database
  - Row Level Security (RLS)
- **WidgetKit**
- **UserDefaults + App Groups**
- **Async/Await (Swift Concurrency)**

---

## 📸 Screenshots
- Login / Signup
- Home (Quotes)
- Favorites
- Collections
- Settings (Dark Mode)
- Home Screen Widget

_(Screenshots included in submission)_

---

## ⚙️ Setup Instructions

1. Clone the repository
2. Open `QuoteVault.xcodeproj` in Xcode
3. Add your Supabase URL & anon key in `SupabaseService.swift`
4. Enable App Groups: group.com.sananhusain.quotevault
5. Run the app on a simulator or real device

---

## 👨‍💻 Author
**Sanan Husain**  
iOS Developer

---

## 📄 License
This project is created for assessment and learning purposes.
