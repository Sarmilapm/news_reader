import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import 'news_detailscreen.dart';

class NewsCategoryScreen extends StatefulWidget {
  final String category;
  const NewsCategoryScreen({super.key, required this.category});

  @override
  _NewsCategoryScreenState createState() => _NewsCategoryScreenState();
}

class _NewsCategoryScreenState extends State<NewsCategoryScreen> {
  bool isLoading = true;
  List newsList = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isLoading) {
      fetchNews();
    }
  }
  Future<void> fetchNews() async {
    const String apiKey = "4af53640cf8e401e92db6831e591886a";
    String url = widget.category == "videos"
        ? "https://newsapi.org/v2/everything?q=video&apiKey=$apiKey"
        : widget.category == "podcasts"
        ? "https://newsapi.org/v2/everything?q=podcast&apiKey=$apiKey"
        : "https://newsapi.org/v2/top-headlines?country=us&category=${widget.category}&apiKey=$apiKey";

    var box = Hive.box('newsCache');

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          newsList = jsonData['articles'];
          isLoading = false;
        });

        // Store fetched data in Hive for offline access
        box.put(widget.category, jsonData['articles']);
      } else {
        loadCachedNews(); // Load cached data if API fails
      }
    } catch (e) {
      loadCachedNews(); // Load cached data in case of network error
    }
  }

  void loadCachedNews() {
    var box = Hive.box('newsCache');
    List? cachedNews = box.get(widget.category);

    if (cachedNews != null) {
      setState(() {
        newsList = cachedNews;
        isLoading = false;
      });
    } else {
      Get.snackbar("No Internet", "No cached news available");
    }
  }


  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        var article = newsList[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: article['urlToImage'] != null
                  ? Image.network(article['urlToImage'], fit: BoxFit.cover, width: 80, height: 80)
                  : const Icon(Icons.image_not_supported, size: 80),
            ),
            title: Text(article['title'] ?? 'No Title', style: const TextStyle(fontSize: 17)),
            subtitle: Text(
              article['publishedAt'] != null
                  ? "Published: ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(article['publishedAt']))}"
                  : 'No Date Available',
              style: const TextStyle(fontSize: 14),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Get.to(() => NewsDetailScreen(article: article));
            },
          ),
        );
      },
    );
  }
}