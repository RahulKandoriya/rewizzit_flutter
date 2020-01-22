import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/dailyCards/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class DailyCardsBloc extends Bloc<DailyCardsEvent, DailyCardsState> {
  Repository _repository;

  DailyCardsBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<DailyCardsState> transformEvents(
      Stream<DailyCardsEvent> events,
      Stream<DailyCardsState> Function(DailyCardsEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  DailyCardsState get initialState => Loading();

  @override
  Stream<DailyCardsState> mapEventToState(
      DailyCardsEvent event,
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