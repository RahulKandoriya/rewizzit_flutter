import 'package:equatable/equatable.dart';

abstract class DiscoverEvent extends Equatable {
  const DiscoverEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends DiscoverEvent {}
class FetchBookmark extends DiscoverEvent {}
class FetchTopNodes extends DiscoverEvent {}
class FetchCardNodes extends DiscoverEvent {}
class FetchRevisionCards extends DiscoverEvent {}