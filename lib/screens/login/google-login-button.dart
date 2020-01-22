import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/screens/login/login.dart';

class GoogleLoginButton extends StatefulWidget {



  @override
  State<StatefulWidget> createState() => _GoogleLoginButtonState();

}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(

      builder: (context, state) {
       return RaisedButton(
         color: Colors.white,
         onPressed: () {
           BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed());
         },
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
         child: Padding(
           padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
           child: Row(
             mainAxisSize: MainAxisSize.min,
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0),
               Padding(
                 padding: const EdgeInsets.only(left: 10),
                 child: state.isLoading || state.isSuccess
                     ?  Center(
                   child: CircularProgressIndicator(),
                 )
                 : Text(
                   'Tap to Enter',
                   style: GoogleFonts.josefinSans(
                     textStyle: TextStyle(fontSize: 25, color: Colors.black87, fontWeight: FontWeight.bold, height: 1.3),
                   ),
                 ),
               )
             ],
           ),
         ),
       );
      }
      );
  }
}