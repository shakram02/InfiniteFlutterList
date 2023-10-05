import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list/posts/bloc/posts_bloc.dart';
import 'package:infinite_list/posts/post_repository.dart';
import 'package:infinite_list/posts/providers/PostProvider.dart';
import 'package:infinite_list/posts/widgets/widgets.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  final postProvider = const PostProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocProvider(
        create: (_) => PostBloc(
          PostRepository(
            postProvider: postProvider,
          ),
        )..add(PostFetched()),
        child: const PostList(),
      ),
    );
  }
}
