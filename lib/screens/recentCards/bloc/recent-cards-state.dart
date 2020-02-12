import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/api_response/explore-data-response.dart';
import 'package:rewizzit/data/models/models/card-model.dart';

abstract class RecentCardsState extends Equatable {
  const RecentCardsState();

  @override
  List<Object> get props => [];
}

class Loading extends RecentCardsState {}

class Loaded extends RecentCardsState {
  final List<RecentCards> recentCards;

  const Loaded({@required this.recentCards});

  @override
  List<Object> get props => [recentCards];

  @override
  String toString() => 'Loaded { items: ${recentCards.length} }';
}

class Failure extends RecentCardsState {}