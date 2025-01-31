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
      profilePath: json['profile_path'] ?? '',
    );
  }

  String profileUrl() {
    if (profilePath == '') return 'https://i.postimg.cc/9f3zRXHV/Cristiano-Ronaldo-ceremony-rename-airport-Santa-Cruz-Madeira-Portugal-March-29-2017.webp';
    return '${Config.imageUrl}w500$profilePath';
  }
}