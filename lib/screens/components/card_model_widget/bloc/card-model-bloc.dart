import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class CardModelBloc extends Bloc<CardModelEvent, CardModelState> {
  Repository _repository;

  CardModelBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<CardModelState> transformEvents(
      Stream<CardModelEvent> events,
      Stream<CardModelState> Function(CardModelEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  CardModelState get initialState => Loading();

  @override
  Stream<CardModelState> mapEventToState(
      CardModelEvent event,
      ) async* {

    if (event is Bookmark) {
      yield BookmarkLoading();
      try {
        final response = await _repository.addCardToBookmark(event.cardId);
        yield Bookmarked(bookmarkResponse: response);
      } catch (_) {
        yield BookmarkFailure();
      }
    }

    if (event is Revise) {
      yield ReviseLoading();
      try {
        final response = await _repository.addCardToRevision(event.cardId);
        yield Revised(revisionResponse: response);
      } catch (_) {
        yield ReviseFailure();
      }
    }
  }

}