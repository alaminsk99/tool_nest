
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUser {
  final String id;
  final String name;
  final String email;
  final String photoUrl;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  factory AppUser.fromFirebaseUser(User user) {
    return AppUser(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL ?? '',
    );
  }

  factory AppUser.fromSharedPreferences(SharedPreferences prefs) {
    return AppUser(
      id: prefs.getString('userId') ?? '',
      name: prefs.getString('userName') ?? '',
      email: prefs.getString('userEmail') ?? '',
      photoUrl: prefs.getString('userPhotoUrl') ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  @override
  String toString() {
    return 'AppUser{id: $id, name: $name, email: $email, photoUrl: $photoUrl}';
  }
}