import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class SelectNodeBloc extends Bloc<SelectNodeEvent, SelectNodeState> {
  Repository _repository;

  SelectNodeBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<SelectNodeState> transformEvents(
      Stream<SelectNodeEvent> events,
      Stream<SelectNodeState> Function(SelectNodeEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  SelectNodeState get initialState => Loading();

  @override
  Stream<SelectNodeState> mapEventToState(
      SelectNodeEvent event,
      ) async* {
    if (event is FetchSubNodes) {
      yield NodesLoading();
      try {
        final subNodesResponse = await _repository.fetchSubNodesList(event.parentNodeId);
        final cardNodes = await _repository.fetchCardNodesList();
        yield Loaded(subNodesResponse: subNodesResponse, cardNodes: cardNodes);
      } catch (_) {
        yield Failure();
      }
    }

    if (event is FetchCardNodes) {
      yield Loading();
      try {
        final cardNodes = await _repository.fetchCardNodesList();
        yield CardNodesLoaded(cardNodes: cardNodes);
      } catch (_) {
        yield Failure();
      }
    }
  }

}