import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/tabs/discover/bloc/bloc.dart';
import 'package:rewizzit/screens/tabs/discover/dicover-page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscoverScreen extends StatelessWidget {

  final Repository repository = Repository();
  final SharedPreferences preferences;

  DiscoverScreen({Key key,@required this.preferences})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<DiscoverBloc>(
        create: (context) => DiscoverBloc(repository: repository)..add(Fetch()),
        child: DiscoverPage(repository: repository, preference: preferences),
      ),
    );
  }
}