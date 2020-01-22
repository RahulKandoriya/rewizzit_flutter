import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:rewizzit/screens/tabs/account/account.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  Repository _repository;

  AccountBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;


  @override
  Stream<AccountState> transformEvents(
      Stream<AccountEvent> events,
      Stream<AccountState> Function(AccountEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  AccountState get initialState => Loading();

  @override
  Stream<AccountState> mapEventToState(
      AccountEvent event,
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