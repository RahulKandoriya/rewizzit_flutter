import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/recentNodes/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class RecentNodesBloc extends Bloc<RecentNodesEvent, RecentNodesState> {
  Repository _repository;

  RecentNodesBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<RecentNodesState> transformEvents(
      Stream<RecentNodesEvent> events,
      Stream<RecentNodesState> Function(RecentNodesEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  RecentNodesState get initialState => Loading();

  @override
  Stream<RecentNodesState> mapEventToState(
      RecentNodesEvent event,
      ) async* {
    if (event is Fetch) {
      try {
        final bookmarkCards = await _repository.fetchBookmarkCards();
        yield Loaded(bookmarkCards: bookmarkCards);
      } catch (_) {
        yield Failure();
      }
    }
  }

}