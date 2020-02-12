import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RevisionCardModelEvent extends Equatable {
  const RevisionCardModelEvent();

  @override
  List<Object> get props => [];
}

class Bookmark extends RevisionCardModelEvent {
  final String cardId;

  const Bookmark({@required this.cardId});

  @override
  List<Object> get props => [cardId];

  @override
  String toString() => 'Bookmark { item: $cardId }';
}


class Revise extends RevisionCardModelEvent {
  final String cardId;

  const Revise({@required this.cardId});

  @override
  List<Object> get props => [cardId];

  @override
  String toString() => 'Revise { item: $cardId }';
}

class Delete extends RevisionCardModelEvent {
  final String cardId;

  const Delete({@required this.cardId});

  @override
  List<Object> get props => [cardId];

  @override
  String toString() => 'Delete { item: $cardId }';
}

class UpdateRevision extends RevisionCardModelEvent {
  final String reviId;

  const UpdateRevision({@required this.reviId});

  @override
  List<Object> get props => [reviId];

  @override
  String toString() => 'RevisionId { item: $reviId }';
}

