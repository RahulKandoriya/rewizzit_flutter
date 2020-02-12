import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/bookmark/bloc/bloc.dart';
import 'package:rewizzit/screens/bookmark/bookmark.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkScreen extends StatelessWidget {

  final Repository _repository = Repository();
  final SharedPreferences prefs;
  final int cardPosition;

  BookmarkScreen({Key key, @required Repository repository, @required this.prefs, @required this.cardPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<BookmarkBloc>(
        create: (context) => BookmarkBloc(repository: _repository)..add(Fetch()),
        child: BookmarkPage(repository: _repository, prefs: prefs, cardPosition: cardPosition,),
      ),
    );
  }
}