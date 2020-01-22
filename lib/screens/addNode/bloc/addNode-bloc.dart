import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:rewizzit/screens/addNode/bloc/bloc.dart';

class AddNodeBloc extends Bloc<AddNodeEvent, AddNodeState> {
  Repository _repository;

  AddNodeBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<AddNodeState> transformEvents(
      Stream<AddNodeEvent> events,
      Stream<AddNodeState> Function(AddNodeEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  AddNodeState get initialState => Loading();

  @override
  Stream<AddNodeState> mapEventToState(
      AddNodeEvent event,
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