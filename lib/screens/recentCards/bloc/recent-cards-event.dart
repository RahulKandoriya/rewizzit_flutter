import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RecentCardsEvent extends Equatable {
  const RecentCardsEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends RecentCardsEvent {}



