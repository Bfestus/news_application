import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/utils/string_extensions.dart';
import 'dart:convert';
import 'article_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List articles = [];
  String selectedCategory = 'general';

  // lets create Categories for the Dropdown button
  List<String> categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology'
  ];

  @override
  void initState() {
    super.initState();
    fetchNews(); // this will Fetch news when the screen is loaded
  }

// creating a function that is responsible for fetching news
  Future<void> fetchNews() async {
    const String baseUrl = 'https://newsapi.org/v2/top-headlines';
    const String apiKey = '840d00294a0649dc930a215b639855ad';

    String getApiUrl(String selectedCategory) {
      return '$baseUrl?country=us&category=$selectedCategory&apiKey=$apiKey';
    }

    final response = await http.get(
      Uri.parse(getApiUrl(selectedCategory)),
    );

    if (response.statusCode == 200) {
      setState(() {
        articles = json.decode(response.body)['articles'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // lets Handle error gracefully
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load news. Please try again later.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quick News Global',
          style: TextStyle(
            color: Colors.white, // Text color to white
          ),
        ),
        backgroundColor: Colors.blue, // Set the AppBar color to blue
        actions: [
          DropdownButton<String>(
            value: selectedCategory,
            onChanged: (String? newCategory) {
              setState(() {
                selectedCategory = newCategory!;
                isLoading = true;
              });
              fetchNews(); // Fetch news with the new category
            },
            dropdownColor: Colors.blue, // Set the dropdown color to blue
            items: categories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value.capitalize(),
                  style: TextStyle(
                    color: Colors.white, // White color for the category name
                  ),
                ),
              );
            }).toList(),
          ),
        ],
        iconTheme: IconThemeData(
          color: Colors.white, // Icon color to white
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                var article = articles[index];
                var imageUrl =
                    article['urlToImage'] ?? ''; // Handle missing images

                return Padding(
                  padding: const EdgeInsets.all(
                      8.0), // Add padding between the boxes
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Rounded corners for the box
                    ),
                    elevation: 5, // Shadow effect for the box
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // If the image URL is not empty, display the image
                        imageUrl.isNotEmpty
                            ? Image.network(
                                imageUrl,
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: double.infinity,
                                height: 180,
                                color: Colors.grey[200],
                                child: Icon(Icons.image),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            article['title'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            article['description'] ??
                                'No description available.',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to the Article Detail screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArticleDetailScreen(
                                    title: article['title'],
                                    content: article['content'] ??
                                        'No content available.',
                                    url: article['url'],
                                    imageUrl: article['urlToImage'] ??
                                        '', // Pass the image URL here
                                  ),
                                ),
                              );
                            },
                            child: Text('Read More'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            Colors.blue, // Set the Bottom Navigation Bar color to blue
        selectedItemColor: Colors.white, // Set selected item color to white
        unselectedItemColor: Colors.white, // Set unselected item color to white
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
