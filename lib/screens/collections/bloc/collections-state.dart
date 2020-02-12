import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/api_response/api-response.dart';

abstract class CollectionsState extends Equatable {
  const CollectionsState();

  @override
  List<Object> get props => [];
}

class Loading extends CollectionsState {}

class Loaded extends CollectionsState {
  final SubNodesResponse subNodesResponse;

  const Loaded({@required this.subNodesResponse});

  @override
  List<Object> get props => [subNodesResponse];

  @override
  String toString() => 'Loaded { items: ${subNodesResponse.data.nodes.length} }';
}

class Failure extends CollectionsState {}