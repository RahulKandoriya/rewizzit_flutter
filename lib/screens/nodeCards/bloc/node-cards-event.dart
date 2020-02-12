import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NodeCardsEvent extends Equatable {
  const NodeCardsEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends NodeCardsEvent {

  final String parentNodeId;

  const Fetch({@required this.parentNodeId});

  @override
  List<Object> get props => [parentNodeId];

  @override
  String toString() => 'Delete { id: $parentNodeId }';

}

class NodeDelete extends NodeCardsEvent {
  final String nodeId;

  const NodeDelete({@required this.nodeId});

  @override
  List<Object> get props => [nodeId];

  @override
  String toString() => 'Delete { item: $nodeId }';
}

class FetchAfterAddingCard extends NodeCardsEvent {

  final String parentNodeId;

  const FetchAfterAddingCard({@required this.parentNodeId});

  @override
  List<Object> get props => [parentNodeId];

  @override
  String toString() => 'Delete { id: $parentNodeId }';

}
