import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class EditNodeEvent extends Equatable {
  const EditNodeEvent();

  @override
  List<Object> get props => [];
}

class TitleChanged extends EditNodeEvent {
  final String title;

  const TitleChanged({@required this.title});

  @override
  List<Object> get props => [title];

  @override
  String toString() => 'TitleChanged { title :$title }';
}

class Submitted extends EditNodeEvent {
  final String title;
  final bool isCardNode;

  const Submitted({
    @required this.title,
    @required this.isCardNode,
  });

  @override
  List<Object> get props => [title, isCardNode];

  @override
  String toString() {
    return 'Submitted { title: $title, isCardNode: $isCardNode }';
  }
}

class SubmitPressed extends EditNodeEvent {
  final String title;
  final String parentNodeId;

  const SubmitPressed({
    @required this.title,
    @required this.parentNodeId,
  });

  @override
  List<Object> get props => [title, parentNodeId];

  @override
  String toString() {
    return 'SubmitPressed { title: $title, parentNodeId: $parentNodeId }';
  }
}