import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:rewizzit/screens/addCard/bloc/bloc.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  Repository _repository;

  AddCardBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<AddCardState> transformEvents(
      Stream<AddCardEvent> events,
      Stream<AddCardState> Function(AddCardEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  AddCardState get initialState => Loading();

  @override
  Stream<AddCardState> mapEventToState(
      AddCardEvent event,
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