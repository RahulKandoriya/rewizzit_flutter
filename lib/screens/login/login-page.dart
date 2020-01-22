import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/authentication_bloc/bloc.dart';
import 'package:rewizzit/screens/login/login.dart';

class LoginPage extends StatefulWidget {
  final Repository _repository;

  LoginPage({Key key, @required Repository repository})
      : assert(repository != null),
        _repository = repository, super(key: key);

  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginBloc _loginBloc;

  Repository get _repository => widget._repository;


  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Successfully Logged in'),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
                body: PageView(
                  scrollDirection: Axis.vertical,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(image: AssetImage("assets/images/read.png")),
                            SizedBox(height: 70),
                            Text("Easy Reading",
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold, height: 1.3),
                              ),
                            ),
                            SizedBox(height: 70),
                            Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.deepPurple,
                              size: 50,
                            ),
                            Text("Swipe Up",
                              style:GoogleFonts.josefinSans(
                                textStyle: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold, height: 1.3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(image: AssetImage("assets/images/organise.png")),
                            SizedBox(height: 70),
                            Text("Well Organised",
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold, height: 1.3),
                              ),
                            ),
                            SizedBox(height: 70),
                            Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.deepPurple,
                              size: 50,
                            ),
                            Text("Swipe Up",
                              style:GoogleFonts.josefinSans(
                                textStyle: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold, height: 1.3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(image: AssetImage("assets/images/revision.png")),
                            SizedBox(height: 70),
                            Text("Customized\n   Revision!",
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold, height: 1.3),
                              ),
                            ),
                            SizedBox(height: 70),
                            Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.deepPurple,
                              size: 50,
                            ),
                            Text("Swipe Up",
                              style:GoogleFonts.josefinSans(
                                textStyle: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold, height: 1.3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(image: AssetImage("assets/images/avatar.png")),
                            SizedBox(height: 50),
                            GoogleLoginButton(),
                          ],
                        ),
                      ),
                    ),
                  ],
                )

            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}