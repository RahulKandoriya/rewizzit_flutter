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

      yield Loading();
      try{
        final exploreResponseData = await _repository.fetchExploreDataList();
        yield Loaded(bookmarkCards: exploreResponseData.bookmarkedCards, revisionCards: exploreResponseData.revisions, cardNodes: exploreResponseData.cardNodeList, topNodes: exploreResponseData.topNodes, recentCards: exploreResponseData.recentCards);
      } catch (_){
        yield Failure();
      }
    }

  }

}