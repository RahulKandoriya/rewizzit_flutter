import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NodeCardModelState extends Equatable {
  const NodeCardModelState();

  @override
  List<Object> get props => [];
}

class Loading extends NodeCardModelState {}

class BookmarkLoading extends NodeCardModelState {}

class ReviseLoading extends NodeCardModelState {}

class DeleteLoading extends NodeCardModelState {}

class Bookmarked extends NodeCardModelState {
  final String bookmarkResponse;

  const Bookmarked({@required this.bookmarkResponse,});

  @override
  List<Object> get props => [bookmarkResponse, ];

  @override
  String toString() => 'Bookmarked { items: $bookmarkResponse }';
}

class Revised extends NodeCardModelState {
  final String revisionResponse;

  const Revised({@required this.revisionResponse, });

  @override
  List<Object> get props => [revisionResponse];

  @override
  String toString() => 'Revised { items: $revisionResponse }';
}

class Deleted extends NodeCardModelState {
  final String deleteResponse;

  const Deleted({@required this.deleteResponse,});

  @override
  List<Object> get props => [deleteResponse,];

  @override
  String toString() => 'Bookmarked { items: $deleteResponse }';
}


class BookmarkFailure extends NodeCardModelState {}

class ReviseFailure extends NodeCardModelState {}

class DeleteFailure extends NodeCardModelState {}