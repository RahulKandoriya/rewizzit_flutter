import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AllRevisionCardModelState extends Equatable {
  const AllRevisionCardModelState();

  @override
  List<Object> get props => [];
}

class Loading extends AllRevisionCardModelState {}

class BookmarkLoading extends AllRevisionCardModelState {}

class ReviseLoading extends AllRevisionCardModelState {}

class DeleteLoading extends AllRevisionCardModelState {}

class Bookmarked extends AllRevisionCardModelState {
  final String bookmarkResponse;

  const Bookmarked({@required this.bookmarkResponse,});

  @override
  List<Object> get props => [bookmarkResponse];

  @override
  String toString() => 'Bookmarked { items: $bookmarkResponse }';
}

class Revised extends AllRevisionCardModelState {
  final String revisionResponse;

  const Revised({@required this.revisionResponse,});

  @override
  List<Object> get props => [revisionResponse];

  @override
  String toString() => 'Revised { items: $revisionResponse }';
}

class Deleted extends AllRevisionCardModelState {
  final String deleteResponse;

  const Deleted({@required this.deleteResponse,});

  @override
  List<Object> get props => [deleteResponse,];

  @override
  String toString() => 'Bookmarked { items: $deleteResponse }';
}


class BookmarkFailure extends AllRevisionCardModelState {}

class ReviseFailure extends AllRevisionCardModelState {}

class DeleteFailure extends AllRevisionCardModelState {}

class UpdateRevisionLoading extends AllRevisionCardModelState {}


class RevisionUpdated extends AllRevisionCardModelState {
  final String updateRevisionResponse;

  const RevisionUpdated({@required this.updateRevisionResponse, });

  @override
  List<Object> get props => [updateRevisionResponse];

  @override
  String toString() => 'Revised { items: $updateRevisionResponse }';
}


class UpdateRevisionFailure extends AllRevisionCardModelState {}
