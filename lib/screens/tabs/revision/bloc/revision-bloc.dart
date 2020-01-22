import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:rewizzit/screens/tabs/revision/revision.dart';

class RevisionBloc extends Bloc<RevisionEvent, RevisionState> {
  Repository _repository;

  RevisionBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<RevisionState> transformEvents(
      Stream<RevisionEvent> events,
      Stream<RevisionState> Function(RevisionEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  RevisionState get initialState => Loading();

  @override
  Stream<RevisionState> mapEventToState(
      RevisionEvent event,
      ) async* {
    if (event is FetchRevisionControls) {
      try {
        yield Loaded();
      } catch (_) {
        yield Failure();
      }
    }
  }

}