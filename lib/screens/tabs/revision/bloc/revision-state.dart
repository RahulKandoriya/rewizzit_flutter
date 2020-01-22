import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class RevisionState extends Equatable {
  const RevisionState();

  @override
  List<Object> get props => [];
}

class Loading extends RevisionState {}

class Loaded extends RevisionState {
}

class Failure extends RevisionState {}