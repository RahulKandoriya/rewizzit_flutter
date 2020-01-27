import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class RecentCardNodesBloc extends Bloc<RecentCardNodesEvent, RecentCardNodesState> {
  Repository _repository;

  RecentCardNodesBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<RecentCardNodesState> transformEvents(
      Stream<RecentCardNodesEvent> events,
      Stream<RecentCardNodesState> Function(RecentCardNodesEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  RecentCardNodesState get initialState => Loading();

  @override
  Stream<RecentCardNodesState> mapEventToState(
      RecentCardNodesEvent event,
      ) async* {
    if (event is Fetch) {
      try {
        final cardNodes = await _repository.fetchCardNodesList();
        yield Loaded(cardNodes: cardNodes);
      } catch (_) {
        yield Failure();
      }
    }
  }

}