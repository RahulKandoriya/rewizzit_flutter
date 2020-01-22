import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RevisionCardsEvent extends Equatable {
  const RevisionCardsEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends RevisionCardsEvent {}

class Delete extends RevisionCardsEvent {
  final String id;

  const Delete({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Delete { id: $id }';
}

class Deleted extends RevisionCardsEvent {
  final String id;

  const Deleted({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Deleted { id: $id }';
}

