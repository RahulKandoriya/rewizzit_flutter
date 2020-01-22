import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/tabs/account/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatelessWidget {

  final Repository repository = Repository();
  final SharedPreferences preferences;

  AccountScreen({Key key,@required this.preferences})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AccountBloc>(
        create: (context) => AccountBloc(repository: repository)..add(FetchRevisionControls()),
        child: AccountPage(repository: repository, preference: preferences),
      ),
    );
  }
}