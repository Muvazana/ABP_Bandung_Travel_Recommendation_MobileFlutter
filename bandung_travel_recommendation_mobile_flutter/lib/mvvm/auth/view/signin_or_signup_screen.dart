import 'package:bandung_travel_recommendation_mobile_flutter/componens/text_button_custom_v1.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view/signin_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view/signup_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view_model/auth_viewmodel.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInOrSignUpScreen extends StatefulWidget {
  static const routeName = '/Auth';
  const SignInOrSignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignInOrSignUpScreen> createState() => _SignInOrSignUpScreenState();
}

class _SignInOrSignUpScreenState extends State<SignInOrSignUpScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthViewModel>().checkUserTokenExist(context);
    });
  }

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
              height: size.height * 1 / 3.5,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Column(children: <Widget>[
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  alignment: Alignment.center,
                  width: size.width,
                ),
                Spacer(flex: 1),
                Text(
                  "We discover The Best Tour and Best Place in \nBandung City",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Spacer(flex: 2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButtonCustomV1(
                      text: "Sign In",
                      backgroundColor: MyColorsConst.whiteColor,
                      textColor: MyColorsConst.semiDarkColor,
                      elevation: 0,
                      onPressed: () =>
                          Navigator.pushNamed(context, SignInScreen.routeName),
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: MyColorsConst.whiteColor,
                            thickness: 1,
                            endIndent: 6,
                          ),
                        ),
                        Text("OR"),
                        Expanded(
                          child: Divider(
                            color: MyColorsConst.whiteColor,
                            thickness: 1,
                            indent: 6,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    TextButtonCustomV1(
                      text: "Sign Up",
                      backgroundColor: Colors.transparent,
                      textColor: MyColorsConst.whiteColor,
                      isOutlineType: true,
                      onPressed: () =>
                          Navigator.pushNamed(context, SignUpScreen.routeName),
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

// class BtnSignInOrSignUp extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final String text;

//   const BtnSignInOrSignUp({
//     Key? key,
//     this.onPressed,
//     required this.text,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       onPressed: this.onPressed,
//       style: OutlinedButton.styleFrom(
//         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 32),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         side: BorderSide(width: 1.0, color: Colors.white),
//       ),
//       child: Text(
//         this.text,
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
