import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RecentNodesEvent extends Equatable {
  const RecentNodesEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends RecentNodesEvent {}

class Delete extends RecentNodesEvent {
  final String id;

  const Delete({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Delete { id: $id }';
}

class Deleted extends RecentNodesEvent {
  final String id;

  const Deleted({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Deleted { id: $id }';
}

