import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/nodeCards/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class NodeCardsBloc extends Bloc<NodeCardsEvent, NodeCardsState> {
  Repository _repository;
  String parentNodeId;

  NodeCardsBloc({
    @required Repository repository,
    @required this.parentNodeId
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<NodeCardsState> transformEvents(
      Stream<NodeCardsEvent> events,
      Stream<NodeCardsState> Function(NodeCardsEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  NodeCardsState get initialState => Loading();

  @override
  Stream<NodeCardsState> mapEventToState(
      NodeCardsEvent event,
      ) async* {
    if (event is Fetch) {
      try {
        final nodeCards = await _repository.fetchNodeCardsList(parentNodeId);
        yield Loaded(nodeCards: nodeCards);
      } catch (_) {
        yield Failure();
      }
    }
  }

}