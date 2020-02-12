import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/api_response/api-response.dart';

abstract class AllRevisionCardsState extends Equatable {
  const AllRevisionCardsState();

  @override
  List<Object> get props => [];
}

class Loading extends AllRevisionCardsState {}

class Loaded extends AllRevisionCardsState {
  final List<Revisions> revisionCards;

  const Loaded({@required this.revisionCards});

  @override
  List<Object> get props => [revisionCards];

  @override
  String toString() => 'Loaded { items: ${revisionCards.length} }';
}

class Failure extends AllRevisionCardsState {}



