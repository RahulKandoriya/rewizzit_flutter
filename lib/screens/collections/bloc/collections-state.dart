import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/models/card-model.dart';
import 'package:rewizzit/data/models/models/models.dart';

abstract class CollectionsState extends Equatable {
  const CollectionsState();

  @override
  List<Object> get props => [];
}

class Loading extends CollectionsState {}

class Loaded extends CollectionsState {
  final List<TopNode> topNodes;

  const Loaded({@required this.topNodes});

  @override
  List<Object> get props => [topNodes];

  @override
  String toString() => 'Loaded { items: ${topNodes.length} }';
}

class Failure extends CollectionsState {}