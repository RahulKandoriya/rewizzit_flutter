import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/models/card-model.dart';

abstract class AddCollectionState extends Equatable {
  const AddCollectionState();

  @override
  List<Object> get props => [];
}

class Loading extends AddCollectionState {}

class Loaded extends AddCollectionState {
  final List<CardModel> bookmarkCards;

  const Loaded({@required this.bookmarkCards});

  @override
  List<Object> get props => [bookmarkCards];

  @override
  String toString() => 'Loaded { items: ${bookmarkCards.length} }';
}

class Failure extends AddCollectionState {}