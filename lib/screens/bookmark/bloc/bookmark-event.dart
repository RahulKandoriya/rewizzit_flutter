import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends BookmarkEvent {}


