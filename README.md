# Learn Tamil (கற்க தமிழ்)

A modern, fast, and interactive Flutter application to learn spoken and written Tamil effortlessly. Learn Tamil is crafted for learners, travelers, and professionals looking to build real-world conversational confidence with vocabulary, daily life sentences, native audio pronunciation, and interactive quizzes.

---

## 🌟 Key Features

- **530+ Curated Vocabulary Words**: Categorized across 15 essential topics including Greetings, Numbers, People & Pronouns, Food & Dining, Travel, Shopping, Family, Verbs, Adjectives, and Emergency phrases.
- **290+ Real-Life Conversational Sentences**: Everyday dialogues for auto rides, restaurant dining, shopping, finding directions, house renting, office workplace, and daily greetings.
- **Authentic Script & Transliteration**: Every entry includes authentic Tamil script, clear English phonetic transliteration, and English translation.
- **Native Text-to-Speech (TTS)**: Offline/online audio pronunciation with interactive playback and mute toggle.
- **Smart Adaptive Quizzes**: Multiple-choice quizzes with randomized distractor generation and score breakdown summaries.
- **Personalized Favourites**: One-tap bookmarking to save challenging words and phrases for quick spaced-repetition review.
- **Dual Theme Support**: Beautiful Material 3 light and dark themes styled with brand green, cream, white, and gold accents.
- **Fully Responsive Architecture**: Designed for compact phones, large smartphones, foldables, and tablets.
- **Complete Privacy & Safety**: 100% offline data storage for bookmarks and progress; user-respectful ad and rating flows.

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.10.4 or higher)
- Android Studio / Xcode (for device compilation)
- Java 17+ for Android Gradle builds

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/uday0117/learntamil.git
   cd learntamil
   ```

2. **Install Flutter packages**:
   ```bash
   flutter pub get
   ```

3. **Run the test suite**:
   ```bash
   flutter test
   ```

4. **Run the application**:
   ```bash
   flutter run
   ```

---

## 📦 Project Architecture

```
lib/
├── core/
│   ├── constants/        # AppConfig (Title, Font, Version, Developer details)
│   ├── services/         # TTS, Favorites, Ratings, Monetization, Updates, Theme
│   └── theme/            # AppTheme, Color palette, Responsive breakpoints
├── data/
│   ├── content_repository.dart  # IContentRepository, JSON asset loader, search & quiz engine
│   └── tamil_data.dart          # High-performance bundled fallback dataset
├── models/
│   ├── learning_item.dart       # LearningItem model (word & sentence)
│   └── quiz_question.dart       # QuizQuestion model
├── screens/
│   ├── splash_screen.dart       # Animated branded entry splash
│   ├── main_navigation_screen.dart # Tab navigation (Home, Words, Sentences, Quiz, Saved)
│   ├── home_screen.dart         # Dashboard with stats, wisdom, categories
│   ├── words_screen.dart        # Filterable vocabulary browser with audio
│   ├── sentences_screen.dart    # Filterable conversational sentence browser
│   ├── quiz_screen.dart         # Interactive quiz flow and result analytics
│   ├── favourites_screen.dart   # Bookmarked items collection
│   └── search_screen.dart       # Instant bilingual search
└── widgets/
    ├── item_card.dart           # Interactive learning card with audio & bookmarking
    ├── ad_banner_widget.dart    # Responsive AdMob banner container
    ├── in_app_rating_dialog.dart # Milestone-based rating dialog
    └── developer_easter_egg_dialog.dart # Developer info dialog
```

---

## 📄 Privacy Policy & Terms

- **Privacy Policy**: [https://uday0117.github.io/learntamil/privacy_policy.html](https://uday0117.github.io/learntamil/privacy_policy.html)
- **Terms & Conditions**: [https://uday0117.github.io/learntamil/terms_and_conditions.html](https://uday0117.github.io/learntamil/terms_and_conditions.html)

---

## 👨‍💻 Developed By

**UK Solutions**  
Developer: Uday Kumar Reddy  
Contact: [apps.uksolutions@gmail.com](mailto:apps.uksolutions@gmail.com)  
Website: [https://uday0117.github.io/learntamil/](https://uday0117.github.io/learntamil/)
