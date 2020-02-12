import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NodeCardModelEvent extends Equatable {
  const NodeCardModelEvent();

  @override
  List<Object> get props => [];
}

class Bookmark extends NodeCardModelEvent {
  final String cardId;

  const Bookmark({@required this.cardId});

  @override
  List<Object> get props => [cardId];

  @override
  String toString() => 'Bookmark { item: $cardId }';
}


class Revise extends NodeCardModelEvent {
  final String cardId;

  const Revise({@required this.cardId});

  @override
  List<Object> get props => [cardId];

  @override
  String toString() => 'Revise { item: $cardId }';
}

class Delete extends NodeCardModelEvent {
  final String cardId;

  const Delete({@required this.cardId});

  @override
  List<Object> get props => [cardId];

  @override
  String toString() => 'Delete { item: $cardId }';
}

