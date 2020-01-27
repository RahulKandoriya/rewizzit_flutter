import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/api_response/api-response.dart';
import 'package:rewizzit/data/models/models/card-model.dart';
import 'package:rewizzit/data/models/models/models.dart';

abstract class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object> get props => [];
}

class Loading extends DiscoverState {}

class Failure extends DiscoverState {}

class Loaded extends DiscoverState {

  final List<CardModel> bookmarkCards;
  final List<Revisions> revisionCards;
  final List<CardsNodesData> cardNodes;
  final List<TopNode> topNodes;

  const Loaded({@required this.bookmarkCards, @required this.revisionCards, @required this.cardNodes, @required this.topNodes});

  @override
  List<Object> get props => [bookmarkCards, revisionCards, cardNodes, topNodes];

  @override
  String toString() => 'Loaded { items: ${bookmarkCards.length}, ${revisionCards.length}, ${cardNodes.length}, ${topNodes.length} }}';

}

class BookmarkLoading extends DiscoverState {}

class RevisionCardsLoading extends DiscoverState {}

class TopNodesLoading extends DiscoverState {}

class CardNodesLoading extends DiscoverState {}

class BookmarkLoaded extends DiscoverState {
  final List<CardModel> bookmarkCards;

  const BookmarkLoaded({@required this.bookmarkCards});

  @override
  List<Object> get props => [bookmarkCards,];

  @override
  String toString() => 'Loaded { items: ${bookmarkCards.length} }}';
}

class RevisionCardsLoaded extends DiscoverState {

  final List<Revisions> revisionCards;

  const RevisionCardsLoaded({@required this.revisionCards,});

  @override
  List<Object> get props => [revisionCards];

  @override
  String toString() => 'Loaded { items: ${revisionCards.length} }}';
}

class CardNodesLoaded extends DiscoverState {
  final List<CardsNodesData> cardNodes;

  const CardNodesLoaded({@required this.cardNodes});

  @override
  List<Object> get props => [cardNodes];

  @override
  String toString() => 'Loaded { items: ${cardNodes.length} }}';
}

class TopNodesLoaded extends DiscoverState {
  final List<TopNode> topNodes;

  const TopNodesLoaded({@required this.topNodes});

  @override
  List<Object> get props => [topNodes];

  @override
  String toString() => 'Loaded { items: ${topNodes.length}, }}';
}

class BookmarkFailure extends DiscoverState {}

class RevisionCardsFailure extends DiscoverState {}

class TopNodesFailure extends DiscoverState {}

class CardNodesFailure extends DiscoverState {}

