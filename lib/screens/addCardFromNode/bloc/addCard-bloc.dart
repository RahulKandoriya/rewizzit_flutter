import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addCardFromNode/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:rewizzit/screens/addCardFromNode/bloc/bloc.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  Repository _repository;

  AddCardBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  AddCardState get initialState => AddCardState.empty();

  @override
  Stream<AddCardState> transformEvents(
      Stream<AddCardEvent> events,
      Stream<AddCardState> Function(AddCardEvent event) next,
      ) {
    final nonDebounceStream = events.where((event) {
      return (event is! TitleChanged && event is! ContentChanged);
    });
    final debounceStream = events.where((event) {
      return (event is TitleChanged || event is ContentChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<AddCardState> mapEventToState(AddCardEvent event) async* {
    if (event is TitleChanged) {
      yield* _mapTitleChangedToState(event.title);
    } else if (event is ContentChanged) {
      yield* _mapContentChangedToState(event.content);
    } else if (event is SubmitPressed) {
      yield* _mapSubmitPressedToState(
        title: event.title,
        content: event.content,
        parentNodeId: event.parentNodeId,
      );
    }
  }

  Stream<AddCardState> _mapTitleChangedToState(String title) async* {
    yield state.update(
      isTitleValid: Validators.isValidTitle(title),
    );
  }

  Stream<AddCardState> _mapContentChangedToState(String content) async* {
    yield state.update(
      isContentValid: Validators.isValidContent(content),
    );
  }

  Stream<AddCardState> _mapSubmitPressedToState({
    String title,
    String content,
    String parentNodeId,
  }) async* {
    yield AddCardState.loading();
    try {
      await _repository.addCard(title, content, parentNodeId);

      yield AddCardState.success();
    } catch (_) {
      yield AddCardState.failure();
    }
  }

}