part of 'posts_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

final class PostFetched extends PostEvent {}
