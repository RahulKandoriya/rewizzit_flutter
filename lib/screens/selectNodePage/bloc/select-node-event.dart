import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SelectNodeEvent extends Equatable {
  const SelectNodeEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends SelectNodeEvent {

  final String parentNodeId;

  const Fetch({@required this.parentNodeId});

  @override
  List<Object> get props => [parentNodeId];

  @override
  String toString() => 'Delete { id: $parentNodeId }';

}
