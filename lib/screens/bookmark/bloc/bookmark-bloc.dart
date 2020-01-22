import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/bookmark/bloc/bookmark-event.dart';
import 'package:rewizzit/screens/bookmark/bloc/bookmark-state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:rewizzit/screens/bookmark/bloc/bloc.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  Repository _repository;

  BookmarkBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<BookmarkState> transformEvents(
      Stream<BookmarkEvent> events,
      Stream<BookmarkState> Function(BookmarkEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  BookmarkState get initialState => Loading();

  @override
  Stream<BookmarkState> mapEventToState(
      BookmarkEvent event,
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