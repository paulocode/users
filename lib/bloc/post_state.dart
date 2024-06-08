part of 'post_bloc.dart';

final class PostState extends Equatable {
  const PostState({
    this.posts = const <Person>[],
    this.loadCount = 0,
    this.isLoading = false,
    this.hasError = false,
  });

  final List<Person> posts;
  final int loadCount;
  final bool isLoading;
  final bool hasError;

  bool get hasReachedMax {
    return loadCount >= kPagesLimit;
  }

  PostState copyWith({
    List<Person>? posts,
    int? loadCount,
    bool? isLoading,
    bool? hasError,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      loadCount: loadCount ?? this.loadCount,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  String toString() {
    return '''PostState { loadCount: $loadCount, posts: ${posts.length}, isLoading: $isLoading, hasError: $hasError }''';
  }

  @override
  List<Object> get props => [posts, loadCount, isLoading, hasError];
}
