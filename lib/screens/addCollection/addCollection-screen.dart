import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import './addCollection.dart';

class AddCollectionScreen extends StatelessWidget {

  final Repository _repository = Repository();

  AddCollectionScreen({Key key, @required Repository repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AddCollectionBloc>(
        create: (context) => AddCollectionBloc(repository: _repository)..add(Fetch()),
        child: AddCollectionPage(repository: _repository),
      ),
    );
  }
}