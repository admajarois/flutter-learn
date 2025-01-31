import 'package:fakeflix/config/config.dart';

class Credit {
  final int id;
  final String name;
  final String profilePath;

  Credit({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  factory Credit.fromJson(Map<String, dynamic> json) {
    return Credit(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'],
    );
  }

  String profileUrl() {
    return '${Config.imageUrl}w500$profilePath';
  }
}