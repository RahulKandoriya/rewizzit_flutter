import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddNodeEvent extends Equatable {
  const AddNodeEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends AddNodeEvent {}

class Delete extends AddNodeEvent {
  final String id;

  const Delete({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Delete { id: $id }';
}

class Deleted extends AddNodeEvent {
  final String id;

  const Deleted({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Deleted { id: $id }';
}

