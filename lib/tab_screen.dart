import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'main.dart';
import 'news_categoryscreen.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        body: Column(
          children: [
            Material(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                labelColor: themeController.isDarkMode.value ? Colors.blueGrey:Colors.white,
                unselectedLabelColor: themeController.isDarkMode.value ?Colors.white:Colors.black,

                tabs: const [
                  Tab(text: "Explore"),
                  Tab(text: "Business"),
                  Tab(text: "Entertainment"),
                  Tab(text: "Technology"),
                  Tab(text: "Science"),
                  Tab(text: "Health"),
                  Tab(text: "Sports"),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  NewsCategoryScreen(category: "general"),
                  NewsCategoryScreen(category: "business"),
                  NewsCategoryScreen(category: "entertainment"),
                  NewsCategoryScreen(category: "technology"),
                  NewsCategoryScreen(category: "science"),
                  NewsCategoryScreen(category: "health"),
                  NewsCategoryScreen(category: "sports"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
