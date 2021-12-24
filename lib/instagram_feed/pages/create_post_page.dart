import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hw/gallery/image_screen.dart';
import 'package:flutter_hw/instagram_feed/constant/user_item.dart';
import 'package:flutter_hw/instagram_feed/storage/post.dart';
import 'package:flutter_hw/instagram_feed/storage/posts.dart';
import 'package:flutter_hw/instagram_feed/storage/user.dart';
import 'package:hive/hive.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_hw/instagram_feed/theme/colors.dart';

class CreatePostPage extends StatefulWidget {
  CreatePostPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  List<String> files = [];
  String selectedFile = "";

  @override
  void initState() {
    super.initState();
    getImagesPath();
  }

  getImagesPath() async {
    var assetPathList = await PhotoManager.getAssetPathList();
    List<String> filesOnDevice = [];
    assetPathList.forEach((element) async {
      var assetsList = await element.assetList;
      var filePaths =
          await Future.wait(assetsList.map((i) async => await i.file));
      var filesUri = filePaths.map((i) => i!.path);

      filesOnDevice = filesUri.whereType<String>().toList();

      if (filesOnDevice.isNotEmpty) {
        setState(() {
          files = filesOnDevice;
          selectedFile = filesOnDevice[0];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    Icon(Icons.clear),
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    var store = await Hive.openBox('instagram_store');

                    var newPost = Post(
                        user: User(
                            profileImg: currentUser.profileImg,
                            name: currentUser.name),
                        postImg: selectedFile,
                        isLoved: true,
                        likedBy: currentUser.name,
                        viewCount: 1000,
                        dayAgo: 3,
                        caption: ""
                    );

                    Posts storagePosts = store.get('posts',
                        defaultValue: Posts(posts: List.empty())) as Posts;

                    var listOfPosts = storagePosts.posts.toList();
                    listOfPosts.add(newPost);

                    store.put('posts', Posts(posts: listOfPosts));

                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Create post',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            const Divider(),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: Image.file(File(selectedFile),
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width)),
            const Divider(),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(0),
                children: List.generate(files.length, (index) {
                  return Center(
                    child: InkWell(
                        child: OpenContainer(
                      transitionType: ContainerTransitionType.fade,
                      transitionDuration: const Duration(seconds: 1),
                      openBuilder: (context, _) =>
                          ImageScreen(imagePath: files[index]),
                      closedElevation: 0,
                      closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side:
                              const BorderSide(color: Colors.white, width: 1)),
                      closedBuilder: (context, _) => GestureDetector(
                        child: Image.file(File(files[index]),
                            width: 300.0, height: 300.0, fit: BoxFit.fitHeight),
                        onTap: () {
                          setState(() {
                            selectedFile = files[index];
                          });
                        },
                      ),
                    )),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
