import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/nodeCards/node-cards.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NodeCardsScreen extends StatelessWidget {

  final Repository _repository = Repository();
  final String parentNodeId;
  final SharedPreferences prefs;
  final bool isFromNodePage;

  NodeCardsScreen({Key key, @required Repository repository, @required this.parentNodeId , @required this.prefs, @required this.isFromNodePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NodeCardsBloc>(
        create: (context) => NodeCardsBloc(repository: _repository)..add(Fetch(parentNodeId: parentNodeId)),
        child: NodeCardsPage(repository: _repository, parentNodeId: parentNodeId, prefs: prefs, isFromNodePage: isFromNodePage,),
      ),
    );
  }
}