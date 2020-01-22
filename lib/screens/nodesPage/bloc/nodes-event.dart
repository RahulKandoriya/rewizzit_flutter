import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NodesEvent extends Equatable {
  const NodesEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends NodesEvent {}

class Delete extends NodesEvent {
  final String id;

  const Delete({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Delete { id: $id }';
}

class Deleted extends NodesEvent {
  final String id;

  const Deleted({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Deleted { id: $id }';
}

