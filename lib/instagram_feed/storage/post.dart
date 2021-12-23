import 'package:flutter_hw/instagram_feed/storage/user.dart';
import 'package:hive/hive.dart';

part 'post.g.dart';

@HiveType(typeId: 0)
class Post {
  Post({
    required this.user,
    required this.postImg,
    required this.isLoved,
    required this.likedBy,
    required this.viewCount,
    required this.dayAgo,
    required this.caption,
  });

  @HiveField(0)
  User user;

  @HiveField(1)
  String postImg;

  @HiveField(2)
  bool isLoved;

  @HiveField(3)
  String likedBy;

  @HiveField(4)
  int viewCount;

  @HiveField(5)
  int dayAgo;

  @HiveField(6)
  String caption;
}
