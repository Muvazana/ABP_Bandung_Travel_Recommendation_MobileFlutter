import 'package:bandung_travel_recommendation_mobile_flutter/componens/text_button_custom_v1.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/text_form_custom_v1.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/profile_viewmodel.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final watchProfileViewModel = context.watch<ProfileViewModel>();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        width: double.infinity,
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: size.width / 6,
                backgroundColor: Colors.black45,
              ),
              SizedBox(height: 16),
              TextFormCustomV1(
                hintText: "Enter your name",
                icon: Icon(
                  Icons.person,
                  color: MyColors.semiDarkColor,
                  size: 24,
                ),
                enable: watchProfileViewModel.isEdit,
              ),
              SizedBox(height: 6),
              TextFormCustomV1(
                hintText: "Enter your email",
                icon: Icon(
                  Icons.email,
                  color: MyColors.semiDarkColor,
                  size: 24,
                ),
                enable: false,
              ),
              SizedBox(height: 6),
              TextFormCustomV1(
                hintText: "Enter your password",
                icon: Icon(
                  Icons.lock_rounded,
                  color: MyColors.semiDarkColor,
                  size: 24,
                ),
                isPassword: true,
                enable: watchProfileViewModel.isEdit,
                validator: RequiredValidator(errorText: "* Required!"),
              ),
              SizedBox(height: 12),
              TextButtonCustomV1(
                text: watchProfileViewModel.isEdit ? "Save Profile" : "Edit Profile",
                backgroundColor: MyColors.primaryColor,
                textColor: MyColors.whiteColor,
                onPressed: () {
                  context.read<ProfileViewModel>().changeEditorSave();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
