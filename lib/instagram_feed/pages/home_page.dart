import 'package:flutter/material.dart';
import 'package:flutter_hw/instagram_feed/constant/user_item.dart';
import 'package:flutter_hw/instagram_feed/storage/post.dart';
import 'package:flutter_hw/instagram_feed/storage/posts.dart';
import 'package:flutter_hw/instagram_feed/theme/colors.dart';
import 'package:flutter_hw/instagram_feed/widgets/story_item.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:hive/hive.dart';
import 'package:flutter_hw/instagram_feed/widgets/post_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];

  @override
  Widget build(BuildContext context) => FocusDetector(
      onFocusGained: () {
        getPosts();
      },
      child: getBody());

  getPosts() async {
    var store = await Hive.openBox('instagram_store');
    setState(() {
      Posts storagePosts = store.get('posts') as Posts;
      posts.addAll(storagePosts.posts.toList());
    });
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: StoryItem(
                img: currentUser.profileImg,
                name: currentUser.name,
              ),
            ),
          ),
          Divider(
            color: white.withOpacity(0.3),
          ),
          Column(
            children: List.generate(posts.length, (index) {
              return PostItem(
                post: posts[index],
              );
            }),
          )
        ],
      ),
    );
  }
}
