import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:rewizzit/screens/recentCards/bloc/bloc.dart';

class RecentCardsBloc extends Bloc<RecentCardsEvent, RecentCardsState> {
  Repository _repository;

  RecentCardsBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<RecentCardsState> transformEvents(
      Stream<RecentCardsEvent> events,
      Stream<RecentCardsState> Function(RecentCardsEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  RecentCardsState get initialState => Loading();

  @override
  Stream<RecentCardsState> mapEventToState(
      RecentCardsEvent event,
      ) async* {
    if (event is Fetch) {
      try {
        final recentCards = await _repository.fetchRecentCards();
        yield Loaded(recentCards: recentCards);
      } catch (_) {
        yield Failure();
      }
    }
  }

}