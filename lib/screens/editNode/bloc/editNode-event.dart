import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class EditNodeEvent extends Equatable {
  const EditNodeEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends EditNodeEvent {}

class Delete extends EditNodeEvent {
  final String id;

  const Delete({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Delete { id: $id }';
}

class Deleted extends EditNodeEvent {
  final String id;

  const Deleted({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Deleted { id: $id }';
}

