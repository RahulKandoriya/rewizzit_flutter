import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addCard/addCard.dart';

class AddCardScreen extends StatelessWidget {

  final Repository _repository = Repository();

  AddCardScreen({Key key, @required Repository repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AddCardBloc>(
        create: (context) => AddCardBloc(repository: _repository)..add(Fetch()),
        child: AddCardPage(repository: _repository),
      ),
    );
  }
}