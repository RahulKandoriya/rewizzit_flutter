import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rewizzit/screens/editNode/editNode.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addNode/validators.dart';

class EditNodeBloc extends Bloc<EditNodeEvent, EditNodeState> {
  Repository _repository;


  EditNodeBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;

  @override
  EditNodeState get initialState => EditNodeState.empty();

  @override
  Stream<EditNodeState> transformEvents(
      Stream<EditNodeEvent> events,
      Stream<EditNodeState> Function(EditNodeEvent event) next,
      ) {
    final nonDebounceStream = events.where((event) {
      return (event is! TitleChanged );
    });
    final debounceStream = events.where((event) {
      return (event is TitleChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<EditNodeState> mapEventToState(EditNodeEvent event) async* {
    if (event is TitleChanged) {
      yield* _mapTitleChangedToState(event.title);
    } else if (event is SubmitPressed) {
      yield* _mapSubmitPressedToState(
        title: event.title,
        parentNodeId: event.parentNodeId,
      );
    }
  }

  Stream<EditNodeState> _mapTitleChangedToState(String title) async* {
    yield state.update(
      isTitleValid: Validators.isValidTitle(title),
    );
  }


  Stream<EditNodeState> _mapSubmitPressedToState({
    String title,
    String parentNodeId,
  }) async* {
    yield EditNodeState.loading();
    try {
      await _repository.editNode(title, parentNodeId);
      yield EditNodeState.success();
    } catch (_) {
      yield EditNodeState.failure();
    }
  }
}