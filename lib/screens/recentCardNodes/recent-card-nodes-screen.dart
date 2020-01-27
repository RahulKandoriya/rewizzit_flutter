import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import './recent-card-nodes.dart';

class RecentCardNodesScreen extends StatelessWidget {

  final Repository _repository = Repository();

  RecentCardNodesScreen({Key key, @required Repository repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RecentCardNodesBloc>(
        create: (context) => RecentCardNodesBloc(repository: _repository)..add(Fetch()),
        child: RecentCardNodesPage(repository: _repository),
      ),
    );
  }
}