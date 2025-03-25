import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:news_reader/profile_screen.dart';


import 'home_screen.dart';
import 'tab_screen.dart';
import 'news_categoryscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('newsCache');
  runApp(const MyApp());
}

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
      ),
      darkTheme: ThemeData(
        //primaryColor: Colors.blueGrey,
        brightness: Brightness.dark,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      themeMode: ThemeMode.system,
      home:  MainScreen(),
    );
  }
}


class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final RxInt selectedIndex = 0.obs;

  final List<Widget> _screens = [
     HomeScreen(category: "top_news"),
     NewsCategoryScreen(category: "videos"),
     NewsCategoryScreen(category: "podcasts"),
     TabScreen(),
     ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selectedIndex.refresh();
    });
    return Scaffold(
        appBar:AppBar(
          title:  Text("News"),
          centerTitle: true,
          actions: [
            Obx(() => IconButton(
              icon: Icon(themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode),
              onPressed: () {
                themeController.toggleTheme();
              },
            )),
          ],),
      body: Obx(() => _screens[selectedIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: selectedIndex.value,
        onTap: (index) {
          selectedIndex.value = index;
        },
        selectedItemColor: themeController.isDarkMode.value ? Colors.blueGrey :Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).iconTheme.color,
        type: BottomNavigationBarType.fixed,
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Videos"),
          BottomNavigationBarItem(icon: Icon(Icons.podcasts), label: "Podcasts"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      )),
    );
  }
}

// class MainScreen extends StatelessWidget {
//   MainScreen({super.key});
//
//   final RxInt selectedIndex = 0.obs;
//
//   final List<Widget> _screens = [
//     const HomeScreen(),
//     const Center(child: Text("Videos Page")),
//     const Center(child: Text("Podcasts Page")),
//     const Center(child: Text("Categories Page")),
//     const Center(child: Text("Profile Page")),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(() => _screens[selectedIndex.value]),
//       bottomNavigationBar: Obx(() => BottomNavigationBar(
//         currentIndex: selectedIndex.value,
//         onTap: (index) {
//           selectedIndex.value = index;
//         },
//         selectedItemColor: Theme.of(context).primaryColor,
//         unselectedItemColor: Theme.of(context).iconTheme.color,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Videos"),
//           BottomNavigationBarItem(icon: Icon(Icons.podcasts), label: "Podcasts"),
//           BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       )),
//     );
//   }
// }













