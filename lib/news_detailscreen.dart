import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'comment_screen.dart';


class NewsDetailScreen extends StatefulWidget {
  final dynamic article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    String publishedDate = widget.article['publishedAt'] ?? '';
    String formattedDate = publishedDate.isNotEmpty
        ? DateFormat.yMMMMd().format(DateTime.parse(publishedDate))
        : 'No Date';
    return Scaffold(
      appBar: AppBar(title: Text(widget.article['title'] ?? 'News Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: widget.article['urlToImage'] != null
                  ? Image.network(widget.article['urlToImage'],
                  fit: BoxFit.cover, width: double.infinity)
                  : const Icon(Icons.image_not_supported, size: 100),
            ),
            const SizedBox(height: 16),
            Text(widget.article['title'] ?? 'No Title',
                style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 10),
            Text(widget.article['description'] ?? 'No Description',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text("Published on: $formattedDate",
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                  icon: Icon(
                    isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                    size: 28,
                    color: isLiked
                        ? Theme.of(context).primaryColor
                        : Theme.of(context)
                        .iconTheme
                        .color, // Change color when liked
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Get.to(() => CommentScreen());
                    },
                    icon: const Icon(Icons.comment, size: 28)),
                IconButton(
                    onPressed: () {
                      String title = widget.article['title'] ?? 'No Title';
                      String url = widget.article['url'] ?? '';

                      String shareText = "$title\nRead more: $url";

                      Share.share(shareText);
                    },
                    icon: const Icon(Icons.share, size: 28)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}