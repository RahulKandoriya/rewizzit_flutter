import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/editCard/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:rewizzit/screens/editCard/bloc/bloc.dart';

class EditCardBloc extends Bloc<EditCardEvent, EditCardState> {
  Repository _repository;

  EditCardBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  EditCardState get initialState => EditCardState.empty();

  @override
  Stream<EditCardState> transformEvents(
      Stream<EditCardEvent> events,
      Stream<EditCardState> Function(EditCardEvent event) next,
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
  Stream<EditCardState> mapEventToState(EditCardEvent event) async* {
    if (event is TitleChanged) {
      yield* _mapTitleChangedToState(event.title);
    } else if (event is ContentChanged) {
      yield* _mapContentChangedToState(event.content);
    } else if (event is SubmitPressed) {
      yield* _mapSubmitPressedToState(
        title: event.title,
        content: event.content,
        parentNodeId: event.parentNodeId,
        cardId: event.cardId
      );
    }
  }

  Stream<EditCardState> _mapTitleChangedToState(String title) async* {
    yield state.update(
      isTitleValid: Validators.isValidTitle(title),
    );
  }

  Stream<EditCardState> _mapContentChangedToState(String content) async* {
    yield state.update(
      isContentValid: Validators.isValidContent(content),
    );
  }

  Stream<EditCardState> _mapSubmitPressedToState({
    String title,
    String content,
    String parentNodeId,
    String cardId
  }) async* {
    yield EditCardState.loading();
    try {
      await _repository.editCard(title, content, parentNodeId, cardId);

      yield EditCardState.success();
    } catch (_) {
      yield EditCardState.failure();
    }
  }

}