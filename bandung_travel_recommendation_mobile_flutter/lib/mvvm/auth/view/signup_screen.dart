import 'package:bandung_travel_recommendation_mobile_flutter/componens/loading_cutom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/text_button_custom_v1.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/text_form_custom_v1.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view/layout/signin_or_signup_layout.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view/signin_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/Auth/SignUpScreen';
  SignUpScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SignInOrSignUpLayout(
      formKey: this._formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      contents: <Widget>[
        Text(
          "Create account",
          style: TextStyle(
            color: MyColorsConst.darkColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 12),
        TextFormCustomV1(
          hintText: "Enter your name",
          icon: Icon(
            Icons.person,
            color: MyColorsConst.whiteColor,
            size: 24,
          ),
          validator: RequiredValidator(errorText: "* Required!"),
        ),
        SizedBox(height: 6),
        TextFormCustomV1(
          hintText: "Enter your email",
          icon: Icon(
            Icons.email,
            color: MyColorsConst.whiteColor,
            size: 24,
          ),
          keyboardType: TextInputType.emailAddress,
          validator: MultiValidator([
            RequiredValidator(errorText: "* Required!"),
            EmailValidator(errorText: "Email not Valid!")
          ]),
        ),
        SizedBox(height: 6),
        TextFormCustomV1(
          hintText: "Enter your password",
          icon: Icon(
            Icons.lock_rounded,
            color: MyColorsConst.whiteColor,
            size: 24,
          ),
          isPassword: true,
          validator: RequiredValidator(errorText: "* Required!"),
        ),
        SizedBox(height: 8),
        TextButtonCustomV1(
          text: "Sign Up",
          backgroundColor: MyColorsConst.primaryColor,
          textColor: MyColorsConst.whiteColor,
          elevation: 0,
          onPressed: () {
            if (this._formKey.currentState!.validate()) {
              debugPrint("Valid");
            } else {
              debugPrint("Not Valid");
              LoadingCustom.show(context);
            }
          },
        ),
        SizedBox(height: 6),
        Row(children: [
          Text(
            "Already have an account? ",
            style: TextStyle(
              color: MyColorsConst.semiDarkColor,
              fontSize: 12,
            ),
          ),
          InkWell(
            child: Text(
              "Sign In",
              style: TextStyle(
                color: MyColorsConst.darkColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () =>
                Navigator.pushReplacementNamed(context, SignInScreen.routeName),
          ),
        ]),
      ],
    );
  }
}
