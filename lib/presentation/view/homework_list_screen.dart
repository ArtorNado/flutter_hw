import 'package:flutter/material.dart';

import 'chat_screen.dart';

const firstHomework = 'Widgets';
const chatScreenRoute = '/chat_screen';

class HomeworkListScreen extends StatelessWidget {
  const HomeworkListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Homeworks';
    final List<String> homeworks = [firstHomework];

    return MaterialApp(
      title: title,
      routes: {
        chatScreenRoute: (context) => const ChatScreen(),
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
