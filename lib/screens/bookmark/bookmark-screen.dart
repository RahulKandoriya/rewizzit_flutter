import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/bookmark/bloc/bloc.dart';
import 'package:rewizzit/screens/bookmark/bookmark.dart';

class BookmarkScreen extends StatelessWidget {

  final Repository _repository = Repository();

  BookmarkScreen({Key key, @required Repository repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<BookmarkBloc>(
        create: (context) => BookmarkBloc(repository: _repository)..add(Fetch()),
        child: BookmarkPage(repository: _repository),
      ),
    );
  }
}