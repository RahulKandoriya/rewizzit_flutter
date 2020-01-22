import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddCardEvent extends Equatable {
  const AddCardEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends AddCardEvent {}

class Delete extends AddCardEvent {
  final String id;

  const Delete({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Delete { id: $id }';
}

class Deleted extends AddCardEvent {
  final String id;

  const Deleted({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Deleted { id: $id }';
}

