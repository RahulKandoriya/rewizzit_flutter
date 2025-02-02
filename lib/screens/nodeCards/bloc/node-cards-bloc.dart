import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/nodeCards/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class NodeCardsBloc extends Bloc<NodeCardsEvent, NodeCardsState> {
  Repository _repository;

  NodeCardsBloc({
    @required Repository repository,
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
        final nodeCardsResponse = await _repository.fetchNodeCardsList(event.parentNodeId);
        yield Loaded(nodeCardsResponse: nodeCardsResponse);
      } catch (_) {
        yield Failure();
      }
    }
    if (event is FetchAfterAddingCard) {
      yield Loading();
      try {
        final nodeCardsResponse = await _repository.fetchNodeCardsList(event.parentNodeId);
        yield Loaded(nodeCardsResponse: nodeCardsResponse);
      } catch (_) {
        yield Failure();
      }
    }

    if (event is NodeDelete) {
      yield NodeDeleteLoading();
      try {
        final deleteResponse = await _repository.deleteNode(event.nodeId);
        yield NodeDeleted(deleteResponse: deleteResponse,);
      } catch (_) {
        yield NodeDeleteFailure();
      }
    }
  }

}