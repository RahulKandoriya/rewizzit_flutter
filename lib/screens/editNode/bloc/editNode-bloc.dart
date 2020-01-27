import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class EditNodeBloc extends Bloc<EditNodeEvent, EditNodeState> {
  Repository _repository;

  EditNodeBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<EditNodeState> transformEvents(
      Stream<EditNodeEvent> events,
      Stream<EditNodeState> Function(EditNodeEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  EditNodeState get initialState => Loading();

  @override
  Stream<EditNodeState> mapEventToState(
      EditNodeEvent event,
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