import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/api_response/api-response.dart';

abstract class NodeCardsState extends Equatable {
  const NodeCardsState();

  @override
  List<Object> get props => [];
}

class Loading extends NodeCardsState {}

class NodeDeleteLoading extends NodeCardsState {}

class Loaded extends NodeCardsState {
  final NodeCardsResponse nodeCardsResponse;

  const Loaded({@required this.nodeCardsResponse});

  @override
  List<Object> get props => [nodeCardsResponse];

  @override
  String toString() => 'Loaded { items: ${nodeCardsResponse.data.cards.length} }';
}

class Failure extends NodeCardsState {}

class NodeDeleted extends NodeCardsState {
  final String deleteResponse;

  const NodeDeleted({@required this.deleteResponse,});

  @override
  List<Object> get props => [deleteResponse,];

  @override
  String toString() => 'Bookmarked { items: $deleteResponse }';
}

class NodeDeleteFailure extends NodeCardsState {}