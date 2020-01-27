import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rewizzit/screens/addNode/addNode.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addNode/validators.dart';

class AddNodeBloc extends Bloc<AddNodeEvent, AddNodeState> {
  Repository _repository;


  AddNodeBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;

  @override
  AddNodeState get initialState => AddNodeState.empty();

  @override
  Stream<AddNodeState> transformEvents(
      Stream<AddNodeEvent> events,
      Stream<AddNodeState> Function(AddNodeEvent event) next,
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
  Stream<AddNodeState> mapEventToState(AddNodeEvent event) async* {
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

  Stream<AddNodeState> _mapTitleChangedToState(String title) async* {
    yield state.update(
      isTitleValid: Validators.isValidTitle(title),
    );
  }


  Stream<AddNodeState> _mapSubmitPressedToState({
    String title,
    bool isCardNode,
    String parentNodeId,
  }) async* {
    yield AddNodeState.loading();
    try {
      await _repository.addNode(title, isCardNode, parentNodeId);
      yield AddNodeState.success();
    } catch (_) {
      yield AddNodeState.failure();
    }
  }
}