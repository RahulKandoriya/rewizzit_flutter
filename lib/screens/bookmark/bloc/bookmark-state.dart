import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/models/card-model.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

class Loading extends BookmarkState {}

class Loaded extends BookmarkState {
  final List<CardModel> bookmarkCards;

  const Loaded({@required this.bookmarkCards});

  @override
  List<Object> get props => [bookmarkCards];

  @override
  String toString() => 'Loaded { items: ${bookmarkCards.length} }';
}

class Failure extends BookmarkState {}