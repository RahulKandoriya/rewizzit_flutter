import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/allRevisionCards/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class AllRevisionCardsBloc extends Bloc<AllRevisionCardsEvent, AllRevisionCardsState> {
  Repository _repository;

  AllRevisionCardsBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<AllRevisionCardsState> transformEvents(
      Stream<AllRevisionCardsEvent> events,
      Stream<AllRevisionCardsState> Function(AllRevisionCardsEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  AllRevisionCardsState get initialState => Loading();

  @override
  Stream<AllRevisionCardsState> mapEventToState(
      AllRevisionCardsEvent event,
      ) async* {
    if (event is Fetch) {
      try {
        final revisionCards = await _repository.fetchRevisionCards();
        yield Loaded(revisionCards: revisionCards);
      } catch (_) {
        yield Failure();
      }
    }
  }

}