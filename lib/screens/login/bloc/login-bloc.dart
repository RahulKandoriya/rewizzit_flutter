import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/screens/login/login.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Repository _repository;
  SharedPreferences prefs;


  LoginBloc({
    @required Repository repository,
  })  : assert(repository != null),
        _repository = repository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    prefs = await SharedPreferences.getInstance();
    yield LoginState.loading();
    try {
      prefs.setString("user", json.encode(await _repository.signInWithGoogle()));
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}