import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import './editNode.dart';

class EditNodeScreen extends StatelessWidget {

  final Repository _repository = Repository();

  EditNodeScreen({Key key, @required Repository repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<EditNodeBloc>(
        create: (context) => EditNodeBloc(repository: _repository)..add(Fetch()),
        child: EditNodePage(repository: _repository),
      ),
    );
  }
}