import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NodeCardsEvent extends Equatable {
  const NodeCardsEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends NodeCardsEvent {}

class Delete extends NodeCardsEvent {
  final String id;

  const Delete({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Delete { id: $id }';
}

class Deleted extends NodeCardsEvent {
  final String id;

  const Deleted({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Deleted { id: $id }';
}

