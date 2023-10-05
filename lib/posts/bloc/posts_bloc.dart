import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_list/posts/post_repository.dart';
import 'package:infinite_list/posts/bloc/throtller.dart';
import '../models/Post.dart';

part 'posts_event.dart';

part 'posts_state.dart';

const throttleDuration = Duration(milliseconds: 100);

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this.postRepository)
      : super(const PostState(
          hasReachedMax: false,
          status: PostStatus.initial,
          posts: [],
        )) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final PostRepository postRepository;

  FutureOr<void> _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == PostStatus.initial) {
        final posts = await postRepository.fetchPosts();
        return emit(state.copyWith(
          posts: posts,
          status: PostStatus.success,
          hasReachedMax: false,
        ));
      }

      final posts = await postRepository.fetchPosts(state.posts.length);
      emit(posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              posts: List.of(state.posts)..addAll(posts),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
