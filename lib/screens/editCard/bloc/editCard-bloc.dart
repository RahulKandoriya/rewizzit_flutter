import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class EditCardBloc extends Bloc<EditCardEvent, EditCardState> {
  Repository _repository;

  EditCardBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<EditCardState> transformEvents(
      Stream<EditCardEvent> events,
      Stream<EditCardState> Function(EditCardEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  EditCardState get initialState => Loading();

  @override
  Stream<EditCardState> mapEventToState(
      EditCardEvent event,
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