import 'package:flutter/material.dart';
import 'package:flutter_hw/gallery/gallery.dart';

import 'chat/presentation/view/chat_screen.dart';

const firstHomework = 'Widgets';
const gallery = 'Gallery';
const chatScreenRoute = '/chat_screen';
const galleryRoute = '/gallery_screen';

class HomeworkListScreen extends StatelessWidget {
  const HomeworkListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Homeworks';
    final List<String> homeworks = [firstHomework, gallery];

    return MaterialApp(
      title: title,
      routes: {
        chatScreenRoute: (context) => const ChatScreen(),
        galleryRoute: (context) => const Gallery(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: homeworks.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(homeworks[index]),
                onTap: () {
                  switch (homeworks[index]) {
                    case firstHomework:
                      Navigator.pushNamed(context, chatScreenRoute);
                      break;
                    case gallery:
                      Navigator.pushNamed(context, galleryRoute);
                      break;
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
