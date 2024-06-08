part of 'person_bloc.dart';

final class PersonState extends Equatable {
  const PersonState({
    this.persons = const <Person>[],
    this.loadCount = 0,
    this.isLoading = false,
    this.hasError = false,
  });

  final List<Person> persons;
  final int loadCount;
  final bool isLoading;
  final bool hasError;

  bool get hasReachedMax {
    return loadCount >= pagesLimit;
  }

  PersonState copyWith({
    List<Person>? persons,
    int? loadCount,
    bool? isLoading,
    bool? hasError,
  }) {
    return PersonState(
      persons: persons ?? this.persons,
      loadCount: loadCount ?? this.loadCount,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  String toString() {
    return '''PersonState { loadCount: $loadCount, persons: ${persons.length}, isLoading: $isLoading, hasError: $hasError }''';
  }

  @override
  List<Object> get props => [persons, loadCount, isLoading, hasError];
}
