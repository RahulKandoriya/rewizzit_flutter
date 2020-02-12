import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SelectNodeEvent extends Equatable {
  const SelectNodeEvent();

  @override
  List<Object> get props => [];
}

class FetchSubNodes extends SelectNodeEvent {

  final String parentNodeId;

  const FetchSubNodes({@required this.parentNodeId});

  @override
  List<Object> get props => [parentNodeId];

  @override
  String toString() => 'Delete { id: $parentNodeId }';

}
class FetchCardNodes extends SelectNodeEvent {}

