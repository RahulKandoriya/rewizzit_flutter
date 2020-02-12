import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RevisionEvent extends Equatable {
  const RevisionEvent();

  @override
  List<Object> get props => [];
}

class FetchRevisionControls extends RevisionEvent {}

class PostRevisionControls extends RevisionEvent {

  final int cardsPerDay;
  final int timesPerCard;
  final int days;

  const PostRevisionControls({@required this.cardsPerDay, @required this.timesPerCard, @required this.days});

  @override
  List<Object> get props => [cardsPerDay];

  @override
  String toString() => 'Delete { id: $cardsPerDay }';

}
