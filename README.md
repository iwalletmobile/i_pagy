# ipagy

ipagy offers a powerful tool for Flutter developers with its main features, making paging easy and effective. Developed to meet your paging needs, this package adapts to various usage scenarios by supporting common widgets such as Grid View, List View, Separated ListView.

One of the main advantages of ipagy is that it optimizes paging operations and improves performance. When working with large datasets or pulling data from web services, you can choose ipagy to efficiently manage paging operations. It also makes the paging experience more user-friendly with animated transitions.

ipagy's flexible structure offers developers easy customization. You can customize paging controls and views to suit your needs. This ensures a paging solution that matches the design and functionality of your application.

No need to define a ScrollController, we have already integrated the controller for you! Your pagination is ready with very few arguments!

## Table of contents

- [Installation](#installation)

- [Import](#import)

- [Usage](#usage)

- [License](#license)

## Installation
```yaml
dependencies:
  ipagy: <latest version>
```

## Import
```dart
import 'package:ipagy/ipagy.dart';
```

## Usage

```dart
final class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final PagyType _paginationListType = PagyType.listView;

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
    final List<Post>? response = await _postService.fetchAllPosts(page: currentPage);
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
        title: const Text('ipagy'),
      ),
      body: switch (_paginationListType) {
        PagyType.listView || PagyType.animated => Pagy<Post>(
            items: _posts,
            loadMoreItems: _loadPosts,
            listType: _paginationListType,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (BuildContext context, int index) => Card(
              child: ListTile(
                leading: Text(_posts![index].id.toString()),
                title: Text(_posts![index].title ?? ''),
                subtitle: Text(_posts![index].body ?? ''),
              ),
            ),
          ),
        PagyType.grid => Pagy<Post>(
            items: _posts,
            loadMoreItems: _loadPosts,
            listType: _paginationListType,
            firstLoadingItemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemBuilder: (BuildContext context, int index) => Card(
              child: ListTile(
                leading: Text(_posts![index].id.toString()),
                title: Text(_posts![index].title ?? ''),
              ),
            ),
          ),
        PagyType.separated => SizedBox(
            child: Pagy<Post>(
              items: _posts,
              loadMoreItems: _loadPosts,
              loadingWidget: SizedBox(
                height: MediaQuery.sizeOf(context).height * .7,
                child: const CircularProgressIndicator.adaptive(),
              ),
              listType: _paginationListType,
              separatedWidget: Divider(color: Theme.of(context).primaryColor),
              itemBuilder: (BuildContext context, int index) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(_posts![index].id.toString()),
                  ),
                  title: Text(_posts![index].title ?? ''),
                  subtitle: Text(_posts![index].body ?? ''),
                ),
              ),
            ),
          ),
      },
    );
  }
}
```

## License

MIT

