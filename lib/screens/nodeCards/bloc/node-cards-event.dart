import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NodeCardsEvent extends Equatable {
  const NodeCardsEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends NodeCardsEvent {}
