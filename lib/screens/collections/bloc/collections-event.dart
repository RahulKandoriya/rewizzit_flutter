import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CollectionsEvent extends Equatable {
  const CollectionsEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends CollectionsEvent {}

class Delete extends CollectionsEvent {
  final String id;

  const Delete({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Delete { id: $id }';
}

class Deleted extends CollectionsEvent {
  final String id;

  const Deleted({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Deleted { id: $id }';
}

