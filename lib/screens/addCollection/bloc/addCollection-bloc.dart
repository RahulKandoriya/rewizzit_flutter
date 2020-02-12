import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addCollection/validators.dart';
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
  AddCollectionState get initialState => AddCollectionState.empty();

  @override
  Stream<AddCollectionState> transformEvents(
      Stream<AddCollectionEvent> events,
      Stream<AddCollectionState> Function(AddCollectionEvent event) next,
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
  Stream<AddCollectionState> mapEventToState(
      AddCollectionEvent event,
      ) async* {
    if (event is TitleChanged) {
      yield* _mapTitleChangedToState(event.title);
    } else if (event is SubmitPressed) {
      yield* _mapSubmitPressedToState(
        title: event.title,
        isCardNode: event.isCardNode,
        parentNodeId: event.parentNodeId,
      );
    }
  }

  Stream<AddCollectionState> _mapTitleChangedToState(String title) async* {
    yield state.update(
      isTitleValid: Validators.isValidTitle(title),
    );
  }


  Stream<AddCollectionState> _mapSubmitPressedToState({
    String title,
    bool isCardNode,
    String parentNodeId,
  }) async* {
    yield AddCollectionState.loading();
    try {
      await _repository.addNode(title, isCardNode, parentNodeId);
      yield AddCollectionState.success();
    } catch (_) {
      yield AddCollectionState.failure();
    }
  }

}