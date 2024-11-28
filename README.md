# **Flutter News App**

A simple news app built with Flutter, using **NewsAPI** to fetch the latest headlines.

---

## **Features**

- Display a list of news articles with headlines, images, and descriptions.
- View detailed article information on a separate screen.
- Open full articles in a WebView.
- Basic error handling for API requests.

---

## **Tech Stack**

- **Framework**: Flutter
- **Language**: Dart
- **API**: [NewsAPI](https://newsapi.org)
- **Packages**:
  - `http` (for API calls)
  - `webview_flutter` (to load articles in WebView)

---

## **Setup Instructions**

1. Clone the repository:
   ```bash
   git clone https://github.com/Bfestus/flutter-news-app.git
   cd flutter-news-app

## App Structure
### Main Files
- main.dart: Entry point of the application.
- home_screen.dart: Displays a list of news articles fetched from the API.
- article_detail_screen.dart: Shows detailed information about a selected article.
- webview_screen.dart: Loads the full article using a WebView.

## How to Use the App
1. Launch the app on your emulator or physical device.
2. The home screen will display a list of the latest news headlines.
3. Tap an article to view its details, including a brief description.
4. Click "Read Full Article" to open the full article in a WebView.


video demo: https://youtu.be/peJUd8XjG8g

done by Festus
