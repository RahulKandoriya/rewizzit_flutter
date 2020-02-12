import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/api_response/api-response.dart';

abstract class SelectNodeState extends Equatable {
  const SelectNodeState();

  @override
  List<Object> get props => [];
}

class Loading extends SelectNodeState {}

class NodesLoading extends SelectNodeState {}

class Loaded extends SelectNodeState {
  final SubNodesResponse subNodesResponse;
  final List<CardsNodesData> cardNodes;


  const Loaded({@required this.subNodesResponse, this.cardNodes});

  @override
  List<Object> get props => [subNodesResponse];

  @override
  String toString() => 'Loaded { items: ${subNodesResponse.data.nodes.length}, }';
}

class CardNodesLoaded extends SelectNodeState {
  final List<CardsNodesData> cardNodes;

  const CardNodesLoaded({@required this.cardNodes});

  @override
  List<Object> get props => [cardNodes];

  @override
  String toString() => 'Loaded { items: ${cardNodes.length} }';
}

class Failure extends SelectNodeState {}