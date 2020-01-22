import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/nodeCards/node-cards.dart';

class NodeCardsScreen extends StatelessWidget {

  final Repository _repository = Repository();

  NodeCardsScreen({Key key, @required Repository repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NodeCardsBloc>(
        create: (context) => NodeCardsBloc(repository: _repository)..add(Fetch()),
        child: NodeCardsPage(repository: _repository),
      ),
    );
  }
}