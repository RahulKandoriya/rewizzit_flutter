import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CollectionsEvent extends Equatable {
  const CollectionsEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends CollectionsEvent {}
