import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/nodesPage/nodes.dart';

class NodesScreen extends StatelessWidget {

  final Repository _repository = Repository();
  final String parentNodeId;

  NodesScreen({Key key, @required Repository repository, @required this.parentNodeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NodesBloc>(
        create: (context) => NodesBloc(repository: _repository)..add(Fetch(parentNodeId: parentNodeId)),
        child: NodesPage(repository: _repository, parentNodeId: parentNodeId,),
      ),
    );
  }
}