import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import './editCard.dart';

class EditCardScreen extends StatelessWidget {

  final Repository _repository = Repository();

  EditCardScreen({Key key, @required Repository repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<EditCardBloc>(
        create: (context) => EditCardBloc(repository: _repository)..add(Fetch()),
        child: EditCardPage(repository: _repository),
      ),
    );
  }
}