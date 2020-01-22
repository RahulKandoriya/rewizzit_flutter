import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RevisionEvent extends Equatable {
  const RevisionEvent();

  @override
  List<Object> get props => [];
}

class FetchRevisionControls extends RevisionEvent {}
