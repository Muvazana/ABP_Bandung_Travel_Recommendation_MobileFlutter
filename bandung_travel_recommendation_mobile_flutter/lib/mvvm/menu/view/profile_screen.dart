import 'package:bandung_travel_recommendation_mobile_flutter/componens/text_button_custom_v1.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/text_form_custom_v1.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/model/user_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/menu_viewmodel.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/profile_viewmodel.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailontroller = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var user = context.read<MenuViewModel>().getUserLogged!;
      _nameController.text = user.name!;
      _emailontroller.text = user.email!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final watchProfileViewModel = context.watch<ProfileViewModel>();
    watchProfileViewModel.isEdit
        ? _passwordController.text = ''
        : _passwordController.text = ".....";
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        width: double.infinity,
        child: Form(
          key: _formKey,
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
                  color: MyColorsConst.semiDarkColor,
                  size: 24,
                ),
                enable: watchProfileViewModel.isEdit,
                controller: _nameController,
              ),
              SizedBox(height: 6),
              TextFormCustomV1(
                hintText: "Enter your email",
                icon: Icon(
                  Icons.email,
                  color: MyColorsConst.semiDarkColor,
                  size: 24,
                ),
                enable: false,
                controller: _emailontroller,
              ),
              SizedBox(height: 6),
              TextFormCustomV1(
                hintText: "Enter your password",
                icon: Icon(
                  Icons.lock_rounded,
                  color: MyColorsConst.semiDarkColor,
                  size: 24,
                ),
                isPassword: true,
                enable: watchProfileViewModel.isEdit,
                controller: _passwordController,
                // validator: RequiredValidator(errorText: "* Required!"),
              ),
              SizedBox(height: 12),
              TextButtonCustomV1(
                text: watchProfileViewModel.isEdit
                    ? "Save Profile"
                    : "Edit Profile",
                backgroundColor: MyColorsConst.primaryColor,
                textColor: MyColorsConst.whiteColor,
                onPressed: () {
                  var user = UserModel(
                    name: _nameController.text,
                    password: _passwordController.text,
                  );
                  watchProfileViewModel.changeEditorSave(
                    context,
                    newUserModel: user,
                    isFormValid: this._formKey.currentState!.validate(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
