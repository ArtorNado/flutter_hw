import 'package:flutter_hw/instagram_feed/storage/post.dart';
import 'package:hive/hive.dart';

part 'posts.g.dart';

@HiveType(typeId: 2)
class Posts {
  Posts({
    required this.posts,
  });

  @HiveField(0)
  List<Post> posts;
}
