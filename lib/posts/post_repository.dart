import 'package:infinite_list/posts/providers/PostProvider.dart';
import 'models/Post.dart';

final class PostRepository {
  PostRepository({required this.postProvider});

  final PostProvider postProvider;

  Future<List<Post>> fetchPosts([int startIndex = 0]) async {
    return postProvider.fetchPosts(startIndex);
  }
}
