import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class EditCardEvent extends Equatable {
  const EditCardEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends EditCardEvent {}

class Delete extends EditCardEvent {
  final String id;

  const Delete({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Delete { id: $id }';
}

class Deleted extends EditCardEvent {
  final String id;

  const Deleted({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Deleted { id: $id }';
}

