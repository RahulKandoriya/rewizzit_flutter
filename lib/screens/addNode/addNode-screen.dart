import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addNode/addNode.dart';

class AddNodeScreen extends StatelessWidget {

  final Repository _repository = Repository();

  AddNodeScreen({Key key, @required Repository repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AddNodeBloc>(
        create: (context) => AddNodeBloc(repository: _repository)..add(Fetch()),
        child: AddNodePage(repository: _repository),
      ),
    );
  }
}