import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';

class TextFormCustomV1 extends StatefulWidget {
  final String hintText;
  final double? width, height;
  final EdgeInsetsGeometry? margin;
  final Icon? icon;
  final double? textSize;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  const TextFormCustomV1({
    Key? key,
    required this.hintText,
    this.width,
    this.height,
    this.margin,
    this.icon,
    this.textSize = 16,
    this.keyboardType,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  @override
  State<TextFormCustomV1> createState() => _TextFormCustomV1State();
}

class _TextFormCustomV1State extends State<TextFormCustomV1> {
  bool _isPasswordShowed = false;

  @override
  void initState() {
    this._isPasswordShowed = this.widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.widget.height,
      width: this.widget.width,
      margin: this.widget.margin,
      child: TextFormField(
        keyboardType: this.widget.keyboardType,
        obscureText: this._isPasswordShowed,
        style: TextStyle(fontSize: 16),
        validator: this.widget.validator,
        decoration: InputDecoration(
          hintText: this.widget.hintText,
          isDense: true,
          prefixIcon: this.widget.icon != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: this.widget.icon)
              : null,
          prefixIconConstraints: this.widget.icon != null
              ? BoxConstraints(minWidth: 0, minHeight: 0)
              : null,
          suffixIcon: this.widget.isPassword
              ? InkWell(
                onTap: () {
                  setState(() {
                    _isPasswordShowed = !_isPasswordShowed;
                  });
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.remove_red_eye_sharp,
                      color: MyColors.whiteColor,
                      size: 24,
                    ),
                  ),
              )
              : null,
          suffixIconConstraints: this.widget.isPassword
              ? BoxConstraints(minWidth: 0, minHeight: 0)
              : null,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor),
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
  }
}
