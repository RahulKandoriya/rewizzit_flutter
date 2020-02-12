import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NodesEvent extends Equatable {
  const NodesEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends NodesEvent {

  final String parentNodeId;

  const Fetch({@required this.parentNodeId});

  @override
  List<Object> get props => [parentNodeId];

  @override
  String toString() => 'Delete { id: $parentNodeId }';

}

class Delete extends NodesEvent {
  final String nodeId;

  const Delete({@required this.nodeId});

  @override
  List<Object> get props => [nodeId];

  @override
  String toString() => 'Delete { item: $nodeId }';
}