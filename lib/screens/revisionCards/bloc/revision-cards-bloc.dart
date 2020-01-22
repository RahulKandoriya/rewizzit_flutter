import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/revisionCards/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class RevisionCardsBloc extends Bloc<RevisionCardsEvent, RevisionCardsState> {
  Repository _repository;

  RevisionCardsBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<RevisionCardsState> transformEvents(
      Stream<RevisionCardsEvent> events,
      Stream<RevisionCardsState> Function(RevisionCardsEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  RevisionCardsState get initialState => Loading();

  @override
  Stream<RevisionCardsState> mapEventToState(
      RevisionCardsEvent event,
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