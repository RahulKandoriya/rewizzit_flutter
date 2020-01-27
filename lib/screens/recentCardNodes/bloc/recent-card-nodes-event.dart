import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RecentCardNodesEvent extends Equatable {
  const RecentCardNodesEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends RecentCardNodesEvent {}


