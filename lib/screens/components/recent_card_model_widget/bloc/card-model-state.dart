import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CardModelState extends Equatable {
  const CardModelState();

  @override
  List<Object> get props => [];
}

class Loading extends CardModelState {}

class BookmarkLoading extends CardModelState {}

class ReviseLoading extends CardModelState {}

class DeleteLoading extends CardModelState {}

class Bookmarked extends CardModelState {
  final String bookmarkResponse;

  const Bookmarked({@required this.bookmarkResponse,});

  @override
  List<Object> get props => [bookmarkResponse,];

  @override
  String toString() => 'Bookmarked { items: $bookmarkResponse }';
}

class Revised extends CardModelState {
  final String revisionResponse;

  const Revised({@required this.revisionResponse, });

  @override
  List<Object> get props => [revisionResponse];

  @override
  String toString() => 'Revised { items: $revisionResponse }';
}

class Deleted extends CardModelState {
  final String deleteResponse;

  const Deleted({@required this.deleteResponse,});

  @override
  List<Object> get props => [deleteResponse,];

  @override
  String toString() => 'Bookmarked { items: $deleteResponse }';
}

class BookmarkFailure extends CardModelState {}

class ReviseFailure extends CardModelState {}

class DeleteFailure extends CardModelState {}