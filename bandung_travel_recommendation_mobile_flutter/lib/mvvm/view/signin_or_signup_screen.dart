import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInOrSignUpScreen extends StatelessWidget {
  static const routeName = '/Auth';
  const SignInOrSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          width: size.width,
          child: Column(children: [
            SvgPicture.asset(
              'assets/images/person.svg',
              alignment: Alignment.center,
              height: size.height * 1 / 3.5,
            ),
            Container(
              width: size.width,
              height: size.height * 1 / 4,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Column(children: <Widget>[
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  alignment: Alignment.center,
                  width: size.width,
                ),
                Spacer(flex: 1),
                Text(
                  "We discover The Best Tour, Best Place in \nBandung City",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
                Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BtnSignInOrSignUp(
                      text: "Sign In",
                      onPressed: () {},
                    ),
                    SizedBox(width: 15),
                    BtnSignInOrSignUp(
                      text: "Sign Up",
                      onPressed: () {},
                    ),
                  ],
                ),
                Spacer(flex: 2),
              ]),
            ),
          ]),
        ),
      ]),
    );
  }
}

class BtnSignInOrSignUp extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const BtnSignInOrSignUp({
    Key? key,
    this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: this.onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        side: BorderSide(width: 1.0, color: Colors.white),
      ),
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
