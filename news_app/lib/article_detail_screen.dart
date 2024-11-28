import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailScreen extends StatelessWidget {
  final String title;
  final String content;
  final String url;
  final String imageUrl;

  ArticleDetailScreen({
    required this.title,
    required this.content,
    required this.url,
    required this.imageUrl,
  });

  @override
/*************  ✨ Codeium Command ⭐  *************/
  /// Builds a screen to display the details of an article.
  ///
  /// Shows a horizontal image (if available), title, content, and a button to
  /// navigate to a new screen to display the full article in a WebView.
/******  26c383fc-b1f2-4574-8b07-dec484a6d66d  *******/
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Article Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.grey[200],
                    child: Icon(Icons.image),
                  ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to a new screen with WebView to display full article
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewScreen(url: url),
                    ),
                  );
                },
                child: Text('Read Full Article'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize WebView for Android platform
    WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Article'),
        backgroundColor: Colors.blue,
      ),
      body: WebView(
        initialUrl: widget.url, // URL passed from ArticleDetailScreen
        javascriptMode: JavascriptMode.unrestricted, // Allow JS to run
        onWebViewCreated: (WebViewController webViewController) {},
        onPageStarted: (String url) {
          print("Page started loading: $url");
        },
        onPageFinished: (String url) {
          print("Page finished loading: $url");
        },
        onWebResourceError: (WebResourceError error) {
          print("WebView error: ${error.description}");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error loading article'),
          ));
        },
        gestureNavigationEnabled: true, // Enable swipe gestures for navigation
      ),
    );
  }
}
