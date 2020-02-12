import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/api_response/api-response.dart';
import 'package:rewizzit/data/models/api_response/explore-data-response.dart';
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
  final List<RecentCards> recentCards;
  final List<RevisionCards> revisionCards;
  final List<CardNodeList> cardNodes;
  final List<TopNodes> topNodes;


  const Loaded({@required this.bookmarkCards, @required this.revisionCards, @required this.cardNodes, @required this.topNodes, @required this.recentCards});

  @override
  List<Object> get props => [bookmarkCards, revisionCards, cardNodes, topNodes];

  @override
  String toString() => 'Loaded { items: ${bookmarkCards.length}, ${revisionCards.length}, ${cardNodes.length}, ${topNodes.length} }}';

}
