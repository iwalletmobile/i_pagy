import 'package:flutter/foundation.dart' show immutable;

@immutable
class Post {
  final int? id;
  final int? userId;
  final String? title;
  final String? body;

  const Post({this.id, this.userId, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}
