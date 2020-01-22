import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DiscoverEvent extends Equatable {
  const DiscoverEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends DiscoverEvent {}
