import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddCollectionEvent extends Equatable {
  const AddCollectionEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends AddCollectionEvent {}

class Delete extends AddCollectionEvent {
  final String id;

  const Delete({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Delete { id: $id }';
}

class Deleted extends AddCollectionEvent {
  final String id;

  const Deleted({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Deleted { id: $id }';
}

