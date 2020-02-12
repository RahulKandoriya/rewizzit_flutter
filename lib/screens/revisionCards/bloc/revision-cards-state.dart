import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/api_response/api-response.dart';

abstract class RevisionCardsState extends Equatable {
  const RevisionCardsState();

  @override
  List<Object> get props => [];
}

class Loading extends RevisionCardsState {}

class Loaded extends RevisionCardsState {
  final List<Revisions> revisionCards;

  const Loaded({@required this.revisionCards});

  @override
  List<Object> get props => [revisionCards];

  @override
  String toString() => 'Loaded { items: ${revisionCards.length} }';
}

class Failure extends RevisionCardsState {}



