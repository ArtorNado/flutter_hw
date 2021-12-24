import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  User({
    required this.profileImg,
    required this.name,
  });

  @HiveField(0)
  String profileImg;

  @HiveField(1)
  String name;
}
