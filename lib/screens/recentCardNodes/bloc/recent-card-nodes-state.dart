import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/api_response/api-response.dart';
import 'package:rewizzit/data/models/models/card-model.dart';

abstract class RecentCardNodesState extends Equatable {
  const RecentCardNodesState();

  @override
  List<Object> get props => [];
}

class Loading extends RecentCardNodesState {}

class Loaded extends RecentCardNodesState {
  final List<CardsNodesData> cardNodes;

  const Loaded({@required this.cardNodes});

  @override
  List<Object> get props => [cardNodes];

  @override
  String toString() => 'Loaded { items: ${cardNodes.length} }';
}

class Failure extends RecentCardNodesState {}