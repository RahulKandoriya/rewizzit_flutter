import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DailyCardsEvent extends Equatable {
  const DailyCardsEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends DailyCardsEvent {}

class Delete extends DailyCardsEvent {
  final String id;

  const Delete({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Delete { id: $id }';
}

class Deleted extends DailyCardsEvent {
  final String id;

  const Deleted({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Deleted { id: $id }';
}

