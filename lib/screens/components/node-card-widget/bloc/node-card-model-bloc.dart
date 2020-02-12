import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class NodeCardModelBloc extends Bloc<NodeCardModelEvent, NodeCardModelState> {
  Repository _repository;

  NodeCardModelBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<NodeCardModelState> transformEvents(
      Stream<NodeCardModelEvent> events,
      Stream<NodeCardModelState> Function(NodeCardModelEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  NodeCardModelState get initialState => Loading();

  @override
  Stream<NodeCardModelState> mapEventToState(
      NodeCardModelEvent event,
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
  }

}