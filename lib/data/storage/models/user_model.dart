import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String? role;
  @HiveField(1)
  String? accessToken;
  User({
    required this.role,
    required this.accessToken,
  });
}
