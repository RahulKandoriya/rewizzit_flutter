import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/authentication_bloc/bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/home/home-screen.dart';
import 'package:rewizzit/screens/login/login.dart';
import 'package:rewizzit/screens/splash_screen/splash-screen.dart';
import 'package:rewizzit/simple-bloc-delegate.dart';
import 'package:rewizzit/theme/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.grey[200], // status bar color
  ));

  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final Repository repository = Repository();


  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        repository: repository,
      )..add(AppStarted()),
      child: App(repository: repository),
    ),
  );
}

class App extends StatelessWidget {
  final Repository _repository;

  App({Key key, @required Repository repository})
      : assert(repository != null),
        _repository = repository,
        super(key: key);

  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    Future<void> sharedPreference() async {
      prefs = await SharedPreferences.getInstance();

    }
    sharedPreference();

    FirebaseAnalytics analytics = FirebaseAnalytics();



    return MaterialApp(
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics),],
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {


          if (state is Unauthenticated) {
            return LoginScreen(repository: _repository);
          }
          if (state is Authenticated) {
            return HomeScreen(preferences: prefs, observer: FirebaseAnalyticsObserver(analytics: analytics),);
          }
          if (state is Uninitialized) {
            return SplashScreen();          }
          return SplashScreen();
        },
      ),
    );
  }
}