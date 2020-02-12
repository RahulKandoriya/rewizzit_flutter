import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddCollectionEvent extends Equatable {
  const AddCollectionEvent();

  @override
  List<Object> get props => [];
}

class TitleChanged extends AddCollectionEvent {
  final String title;

  const TitleChanged({@required this.title});

  @override
  List<Object> get props => [title];

  @override
  String toString() => 'TitleChanged { title :$title }';
}

class Submitted extends AddCollectionEvent {
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

class SubmitPressed extends AddCollectionEvent {
  final String title;
  final bool isCardNode;
  final String parentNodeId;

  const SubmitPressed({
    @required this.title,
    @required this.isCardNode,
    @required this.parentNodeId,
  });

  @override
  List<Object> get props => [title, isCardNode, parentNodeId];

  @override
  String toString() {
    return 'SubmitPressed { title: $title, isCardNode: $isCardNode, parentNodeId: $parentNodeId }';
  }
}

