import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class RevisionCardModelBloc extends Bloc<RevisionCardModelEvent, RevisionCardModelState> {
  Repository _repository;


  RevisionCardModelBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<RevisionCardModelState> transformEvents(
      Stream<RevisionCardModelEvent> events,
      Stream<RevisionCardModelState> Function(RevisionCardModelEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  RevisionCardModelState get initialState => Loading();

  @override
  Stream<RevisionCardModelState> mapEventToState(
      RevisionCardModelEvent event,
      ) async* {

    if (event is Bookmark) {
      yield BookmarkLoading();
      try {
        final bookmarkedResponse = await _repository.addCardToBookmark(event.cardId);
        yield Bookmarked(bookmarkResponse: bookmarkedResponse,);
      } catch (_) {
        yield BookmarkFailure();
      }
    }

    if (event is Revise) {
      yield ReviseLoading();
      try {
        final reviseResponse = await _repository.addCardToRevision(event.cardId);
        yield Revised(revisionResponse: reviseResponse,);
      } catch (_) {
        yield ReviseFailure();
      }
    }

    if (event is Delete) {
      yield DeleteLoading();
      try {
        final deleteResponse = await _repository.deleteCard(event.cardId);
        yield Deleted(deleteResponse: deleteResponse,);
      } catch (_) {
        yield DeleteFailure();
      }
    }

    if (event is UpdateRevision) {
      yield UpdateRevisionLoading();
      try {
        final updateRevisionResponse = await _repository.updateCardToRevision(event.reviId);
        yield RevisionUpdated(updateRevisionResponse: updateRevisionResponse);
      } catch (_) {
        yield UpdateRevisionFailure();
      }
    }
  }

}