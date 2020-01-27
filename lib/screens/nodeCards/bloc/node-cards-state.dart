import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/models/card-model.dart';

abstract class NodeCardsState extends Equatable {
  const NodeCardsState();

  @override
  List<Object> get props => [];
}

class Loading extends NodeCardsState {}

class Loaded extends NodeCardsState {
  final List<CardModel> nodeCards;

  const Loaded({@required this.nodeCards});

  @override
  List<Object> get props => [nodeCards];

  @override
  String toString() => 'Loaded { items: ${nodeCards.length} }';
}

class Failure extends NodeCardsState {}