import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AddCardEvent extends Equatable {
  const AddCardEvent();

  @override
  List<Object> get props => [];
}

class TitleChanged extends AddCardEvent {
  final String title;

  const TitleChanged({@required this.title});

  @override
  List<Object> get props => [title];

  @override
  String toString() => 'TitleChanged { title :$title }';
}

class ContentChanged extends AddCardEvent {
  final String content;

  const ContentChanged({@required this.content});

  @override
  List<Object> get props => [content];

  @override
  String toString() => 'ContentChanged { content: $content }';
}

class Submitted extends AddCardEvent {
  final String title;
  final String content;
  final String parentNodeId;

  const Submitted({
    @required this.title,
    @required this.content,
    @required this.parentNodeId
  });

  @override
  List<Object> get props => [title, content, parentNodeId];

  @override
  String toString() {
    return 'Submitted { title: $title, content: $content, parentNodeId: $parentNodeId}';
  }
}

class SubmitPressed extends AddCardEvent {
  final String title;
  final String content;
  final String parentNodeId;

  const SubmitPressed({
    @required this.title,
    @required this.content,
    @required this.parentNodeId
  });

  @override
  List<Object> get props => [title, content, parentNodeId];

  @override
  String toString() {
    return 'SubmitPressed { title: $title, content: $content, parentNodeId: $parentNodeId}';
  }
}