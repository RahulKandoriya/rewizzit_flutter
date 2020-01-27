import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:rewizzit/screens/tabs/discover/discover.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  Repository _repository;

  DiscoverBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<DiscoverState> transformEvents(
      Stream<DiscoverEvent> events,
      Stream<DiscoverState> Function(DiscoverEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  DiscoverState get initialState => Loading();

  @override
  Stream<DiscoverState> mapEventToState(
      DiscoverEvent event,
      ) async* {
    if(event is Fetch){

      try{
        final bookmarkCards = await _repository.fetchBookmarkCards();
        final revisionCards = await _repository.fetchRevisionCards();
        final cardNodes = await _repository.fetchCardNodesList();
        final topNodes = await _repository.fetchTopNodesList();
        yield Loaded(bookmarkCards: bookmarkCards, revisionCards: revisionCards, cardNodes: cardNodes, topNodes: topNodes);
      } catch (_){
        yield Failure();
      }
    }
    if (event is FetchRevisionCards) {
      try {
        try{
          final revisionCards = await _repository.fetchRevisionCards();
          yield RevisionCardsLoaded(revisionCards: revisionCards);
        } catch (_){
          yield RevisionCardsFailure();
        }
      } catch (_) {
        yield Failure();
      }
    }
    if(event is FetchBookmark){

      try{
        final bookmarkCards = await _repository.fetchBookmarkCards();
        yield BookmarkLoaded(bookmarkCards: bookmarkCards);
      } catch (_){
        yield BookmarkFailure();
      }
    }
    if(event is FetchCardNodes){
      try{
        final cardNodes = await _repository.fetchCardNodesList();
        yield CardNodesLoaded(cardNodes: cardNodes);
      } catch (_){
        yield CardNodesFailure();
      }
    }
    if(event is FetchTopNodes){
      try{
        final topNodes = await _repository.fetchTopNodesList();
        yield TopNodesLoaded(topNodes: topNodes);
      } catch (_){
        yield TopNodesFailure();
      }
    }

  }

}