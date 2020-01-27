import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/models/card-model.dart';
import 'package:rewizzit/data/models/models/node.dart';

abstract class NodesState extends Equatable {
  const NodesState();

  @override
  List<Object> get props => [];
}

class Loading extends NodesState {}

class Loaded extends NodesState {
  final List<Node> nodes;

  const Loaded({@required this.nodes});

  @override
  List<Object> get props => [nodes];

  @override
  String toString() => 'Loaded { items: ${nodes.length} }';
}

class Failure extends NodesState {}