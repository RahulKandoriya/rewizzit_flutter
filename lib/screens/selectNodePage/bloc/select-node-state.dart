import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/api_response/api-response.dart';
import 'package:rewizzit/data/models/models/models.dart';

abstract class SelectNodeState extends Equatable {
  const SelectNodeState();

  @override
  List<Object> get props => [];
}

class Loading extends SelectNodeState {}

class NodesLoading extends SelectNodeState {}

class Loaded extends SelectNodeState {
  final List<Node> nodes;
  final List<CardsNodesData> cardNodes;

  const Loaded({@required this.nodes, @required this.cardNodes});

  @override
  List<Object> get props => [nodes, cardNodes];

  @override
  String toString() => 'Loaded { items: ${nodes.length}, ${cardNodes.length} }';
}

class Failure extends SelectNodeState {}