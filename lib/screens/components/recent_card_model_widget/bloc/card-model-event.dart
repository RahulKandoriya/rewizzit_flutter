import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CardModelEvent extends Equatable {
  const CardModelEvent();

  @override
  List<Object> get props => [];
}

class Bookmark extends CardModelEvent {
  final String cardId;

  const Bookmark({@required this.cardId});

  @override
  List<Object> get props => [cardId];

  @override
  String toString() => 'Bookmark { item: $cardId }';
}


class Revise extends CardModelEvent {
  final String cardId;

  const Revise({@required this.cardId});

  @override
  List<Object> get props => [cardId];

  @override
  String toString() => 'Revise { item: $cardId }';
}

class Delete extends CardModelEvent {
  final String cardId;

  const Delete({@required this.cardId});

  @override
  List<Object> get props => [cardId];

  @override
  String toString() => 'Delete { item: $cardId }';
}

