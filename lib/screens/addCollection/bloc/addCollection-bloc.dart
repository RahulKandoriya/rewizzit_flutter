import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class AddCollectionBloc extends Bloc<AddCollectionEvent, AddCollectionState> {
  Repository _repository;

  AddCollectionBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<AddCollectionState> transformEvents(
      Stream<AddCollectionEvent> events,
      Stream<AddCollectionState> Function(AddCollectionEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  AddCollectionState get initialState => Loading();

  @override
  Stream<AddCollectionState> mapEventToState(
      AddCollectionEvent event,
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