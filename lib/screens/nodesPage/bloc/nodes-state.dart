import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/api_response/api-response.dart';

abstract class NodesState extends Equatable {
  const NodesState();

  @override
  List<Object> get props => [];
}

class Loading extends NodesState {}

class DeleteLoading extends NodesState {}

class Loaded extends NodesState {
  final SubNodesResponse subNodesResponse;

  const Loaded({@required this.subNodesResponse});

  @override
  List<Object> get props => [subNodesResponse];

  @override
  String toString() => 'Loaded { items: ${subNodesResponse.data.nodes.length} }';
}

class Deleted extends NodesState {
  final String deleteResponse;

  const Deleted({@required this.deleteResponse,});

  @override
  List<Object> get props => [deleteResponse,];

  @override
  String toString() => 'Bookmarked { items: $deleteResponse }';
}

class DeleteFailure extends NodesState {}





class Failure extends NodesState {}