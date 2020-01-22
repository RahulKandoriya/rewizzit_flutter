import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RecentCardsEvent extends Equatable {
  const RecentCardsEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends RecentCardsEvent {}

class Delete extends RecentCardsEvent {
  final String id;

  const Delete({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Delete { id: $id }';
}

class Deleted extends RecentCardsEvent {
  final String id;

  const Deleted({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Deleted { id: $id }';
}

