import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RevisionCardModelState extends Equatable {
  const RevisionCardModelState();

  @override
  List<Object> get props => [];
}

class Loading extends RevisionCardModelState {}

class BookmarkLoading extends RevisionCardModelState {}

class ReviseLoading extends RevisionCardModelState {}

class DeleteLoading extends RevisionCardModelState {}

class Bookmarked extends RevisionCardModelState {
  final String bookmarkResponse;

  const Bookmarked({@required this.bookmarkResponse,});

  @override
  List<Object> get props => [bookmarkResponse];

  @override
  String toString() => 'Bookmarked { items: $bookmarkResponse }';
}

class Revised extends RevisionCardModelState {
  final String revisionResponse;

  const Revised({@required this.revisionResponse,});

  @override
  List<Object> get props => [revisionResponse];

  @override
  String toString() => 'Revised { items: $revisionResponse }';
}

class Deleted extends RevisionCardModelState {
  final String deleteResponse;

  const Deleted({@required this.deleteResponse,});

  @override
  List<Object> get props => [deleteResponse,];

  @override
  String toString() => 'Bookmarked { items: $deleteResponse }';
}


class BookmarkFailure extends RevisionCardModelState {}

class ReviseFailure extends RevisionCardModelState {}

class DeleteFailure extends RevisionCardModelState {}

class UpdateRevisionLoading extends RevisionCardModelState {}


class RevisionUpdated extends RevisionCardModelState {
  final String updateRevisionResponse;

  const RevisionUpdated({@required this.updateRevisionResponse, });

  @override
  List<Object> get props => [updateRevisionResponse];

  @override
  String toString() => 'Revised { items: $updateRevisionResponse }';
}


class UpdateRevisionFailure extends RevisionCardModelState {}
