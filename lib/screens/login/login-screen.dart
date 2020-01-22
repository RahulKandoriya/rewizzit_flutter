import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/login/login.dart';

class LoginScreen extends StatelessWidget {
  final Repository _repository;

  LoginScreen({Key key, @required Repository repository})
      : assert(repository != null),
        _repository = repository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(repository: _repository),
        child: LoginPage(repository: _repository),
      ),
    );
  }
}