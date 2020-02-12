import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/collections/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  Repository _repository;

  CollectionsBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<CollectionsState> transformEvents(
      Stream<CollectionsEvent> events,
      Stream<CollectionsState> Function(CollectionsEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  CollectionsState get initialState => Loading();

  @override
  Stream<CollectionsState> mapEventToState(
      CollectionsEvent event,
      ) async* {
    if (event is Fetch) {
      yield Loading();
      try {
        final topNodes = await _repository.fetchTopNodesList();
        yield Loaded(subNodesResponse: topNodes);
      } catch (_) {
        yield Failure();
      }
    }
  }

}