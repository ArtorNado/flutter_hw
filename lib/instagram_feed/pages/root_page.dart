import 'package:flutter/material.dart';
import 'package:flutter_hw/instagram_feed/pages/create_post_page.dart';
import 'package:flutter_hw/instagram_feed/storage/post.dart';
import 'package:flutter_hw/instagram_feed/storage/posts.dart';
import 'package:flutter_hw/instagram_feed/theme/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_hw/instagram_feed/pages/home_page.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_hw/instagram_feed/storage/user.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();

    initStore();
  }

  initStore() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(PostAdapter());
    Hive.registerAdapter(PostsAdapter());
    Hive.registerAdapter(UserAdapter());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: black,
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      HomePage(),
      const Center(
        child: Text(
          "Search Page",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: white),
        ),
      ),
      const Center(
        child: Text(
          "Reels Page",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: white),
        ),
      ),
      const Center(
        child: Text(
          "Activity Page",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: white),
        ),
      ),
      const Center(
        child: Text(
          "Account Page",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: white),
        ),
      )
    ];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  PreferredSizeWidget? getAppBar() {
    if (pageIndex == 0) {
      return AppBar(
        backgroundColor: appBarColor,
        title: Row(
          children: const <Widget>[
            Text(
              "Instagram",
              style: TextStyle(fontFamily: 'Billabong', fontSize: 35),
            ),
            Spacer(flex: 1),
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon:
                  SvgPicture.asset("assets/images/upload_icon.svg", width: 24),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostPage(title: "Create post")));
              }),
          const SizedBox(
            width: 8,
          ),
          IconButton(
              icon:
                  SvgPicture.asset("assets/images/message_icon.svg", width: 24),
              onPressed: () {}),
        ],
      );
    } else if (pageIndex == 1) {
      return AppBar(
        backgroundColor: appBarColor,
        title: const Text("Search"),
      );
    } else if (pageIndex == 2) {
      return AppBar(
        backgroundColor: appBarColor,
        title: const Text("Reels"),
      );
    } else if (pageIndex == 3) {
      return AppBar(
        backgroundColor: appBarColor,
        title: const Text("Activity"),
      );
    } else {
      return AppBar(
        backgroundColor: appBarColor,
        title: const Text("Account"),
      );
    }
  }

  Widget getFooter() {
    List bottomItems = [
      pageIndex == 0
          ? "assets/images/home_active_icon.svg"
          : "assets/images/home_icon.svg",
      pageIndex == 1
          ? "assets/images/search_active_icon.svg"
          : "assets/images/search_icon.svg",
      pageIndex == 2
          ? "assets/images/instagram.svg"
          : "assets/images/instagram-reels.svg",
      pageIndex == 3
          ? "assets/images/love_active_icon.svg"
          : "assets/images/love_icon.svg",
      pageIndex == 4
          ? "assets/images/account_active_icon.svg"
          : "assets/images/account_icon.svg",
    ];
    return Container(
      width: double.infinity,
      height: 80,
      decoration: const BoxDecoration(color: appFooterColor),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index) {
            return InkWell(
                onTap: () {
                  selectedTab(index);
                },
                child: SvgPicture.asset(
                  bottomItems[index],
                  width: 24,
                ));
          }),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
