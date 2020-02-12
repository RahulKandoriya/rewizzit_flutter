import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RevisionCardsEvent extends Equatable {
  const RevisionCardsEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends RevisionCardsEvent {}

