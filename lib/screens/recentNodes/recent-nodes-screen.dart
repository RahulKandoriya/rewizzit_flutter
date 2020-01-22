import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/recentNodes/recent-nodes.dart';

class RecentNodesScreen extends StatelessWidget {

  final Repository _repository = Repository();

  RecentNodesScreen({Key key, @required Repository repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RecentNodesBloc>(
        create: (context) => RecentNodesBloc(repository: _repository)..add(Fetch()),
        child: RecentNodesPage(repository: _repository),
      ),
    );
  }
}