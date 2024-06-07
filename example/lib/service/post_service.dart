import 'dart:io';

import 'package:dio/dio.dart';
import 'package:example/model/post.dart';

class PostService {
  Future<List<Post>?> fetchAllPosts({
    required int page,
  }) async {
    try {
      final response = await Dio().get('https://jsonplaceholder.typicode.com/posts?_page=$page');
      if (response.statusCode == HttpStatus.ok) {
        final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(response.data);
        return data.map((post) => Post.fromJson(post)).toList();
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
