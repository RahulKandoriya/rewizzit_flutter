import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends BookmarkEvent {}

class Delete extends BookmarkEvent {
  final String id;

  const Delete({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Delete { id: $id }';
}

class Deleted extends BookmarkEvent {
  final String id;

  const Deleted({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Deleted { id: $id }';
}

