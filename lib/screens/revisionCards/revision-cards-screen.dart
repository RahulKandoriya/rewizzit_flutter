import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/revisionCards/bloc/bloc.dart';
import 'package:rewizzit/screens/revisionCards/revision-cards-page.dart';

class RevisionCardsScreen extends StatelessWidget {

  final Repository repository;
  final int cardPosition;

  RevisionCardsScreen({Key key, @required this.repository, @required this.cardPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RevisionCardsBloc>(
        create: (context) => RevisionCardsBloc(repository: repository)..add(Fetch()),
        child: RevisionCardsPage(repository: repository, cardPosition: cardPosition,),
      ),
    );
  }
}