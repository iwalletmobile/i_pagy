import 'package:example/model/post.dart';
import 'package:example/service/post_service.dart';
import 'package:flutter/material.dart';
import 'package:ipagy/ipagy.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final PagyType _paginationListType = PagyType.animated;

  final PostService _postService = PostService();
  List<Post>? _posts;
  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final List<Post>? response =
        await _postService.fetchAllPosts(page: currentPage);
    if (response?.isNotEmpty ?? false) {
      setState(() {
        _posts ??= [];
        _posts!.addAll(response!);
        currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ipagy Example'),
      ),
      body: Pagy<Post>(
        items: _posts,
        loadMoreItems: _loadPosts,
        listType: _paginationListType,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        itemPadding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) => Card(
          child: ListTile(
            leading: Text(_posts![index].id.toString()),
            title: Text(_posts![index].title ?? ''),
            subtitle: Text(_posts![index].body ?? ''),
          ),
        ),
      ),
    );
  }
}
