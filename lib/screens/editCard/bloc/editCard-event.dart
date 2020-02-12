import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class EditCardEvent extends Equatable {
  const EditCardEvent();

  @override
  List<Object> get props => [];
}

class TitleChanged extends EditCardEvent {
  final String title;

  const TitleChanged({@required this.title});

  @override
  List<Object> get props => [title];

  @override
  String toString() => 'TitleChanged { title :$title }';
}

class ContentChanged extends EditCardEvent {
  final String content;

  const ContentChanged({@required this.content});

  @override
  List<Object> get props => [content];

  @override
  String toString() => 'ContentChanged { content: $content }';
}

class Submitted extends EditCardEvent {
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

class SubmitPressed extends EditCardEvent {
  final String title;
  final String content;
  final String parentNodeId;
  final String cardId;

  const SubmitPressed({
    @required this.title,
    @required this.content,
    @required this.parentNodeId,
    @required this.cardId
  });

  @override
  List<Object> get props => [title, content, parentNodeId, cardId];

  @override
  String toString() {
    return 'SubmitPressed { title: $title, content: $content, parentNodeId: $parentNodeId, cardId: $cardId}';
  }
}