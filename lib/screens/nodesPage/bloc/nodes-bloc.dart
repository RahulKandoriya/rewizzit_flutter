import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/nodesPage/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class NodesBloc extends Bloc<NodesEvent, NodesState> {
  Repository _repository;

  NodesBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<NodesState> transformEvents(
      Stream<NodesEvent> events,
      Stream<NodesState> Function(NodesEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  NodesState get initialState => Loading();

  @override
  Stream<NodesState> mapEventToState(
      NodesEvent event,
      ) async* {
    if (event is Fetch) {
      yield Loading();
      try {
        final nodes = await _repository.fetchSubNodesList(event.parentNodeId);
        yield Loaded(nodes: nodes);
      } catch (_) {
        yield Failure();
      }
    }
  }

}