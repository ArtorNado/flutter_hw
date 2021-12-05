import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animations/animations.dart';

import 'image_screen.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  final String title = "Gallery";

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {

  List<String> mediaList = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(0),
              children: List.generate(mediaList.length, (index) {
                return Center(
                  child: InkWell(
                    child: OpenContainer(
                      transitionType: ContainerTransitionType.fade,
                      transitionDuration: const Duration(seconds: 1),
                      openBuilder: (context, _) => ImageScreen(imagePath: mediaList[index]),
                      closedElevation: 0,
                      closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.white, width: 1)),
                      closedBuilder: (context, _) => Container(
                          alignment: Alignment.center,
                          child: Image.file(File(mediaList[index]),
                              width: 300.0, height: 300.0, fit: BoxFit.fitHeight)
                      ),
                    )
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.camera),
                  iconSize: 50,
                  onPressed: () {
                    _addImageFromCamera();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.image_rounded),
                  iconSize: 50,
                  onPressed: () {
                    _addImageFromGallery();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addImageFromGallery() async {
    XFile? image = (await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50));

    setState(() {
      mediaList.add(image!.path);
    });
  }

  void _addImageFromCamera() async {
    XFile? image = (await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50));
    setState(() {
      mediaList.add(image!.path);
    });
  }
}
