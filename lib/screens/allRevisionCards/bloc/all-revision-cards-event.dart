import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AllRevisionCardsEvent extends Equatable {
  const AllRevisionCardsEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends AllRevisionCardsEvent {}

