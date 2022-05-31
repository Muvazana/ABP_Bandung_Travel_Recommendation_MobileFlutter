import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';

enum SnackbarCustomEnum { INFO, DONE, ERROR }

class SnackbarCustomModel {
  String title;
  String message;
  SnackbarCustomEnum status;
  SnackbarCustomModel({
    required this.title,
    required this.message,
    this.status = SnackbarCustomEnum.INFO,
  });
}

class SnackbarCustom {
  static void show(BuildContext context,
      {required SnackbarCustomModel snackbarCustomModel}) {
    ScaffoldMessenger.of(context).showSnackBar(
      _flushbarCustomLayout(context, snackbarCustomModel: snackbarCustomModel),
    );
  }

  static SnackBar _flushbarCustomLayout(BuildContext context,
      {required SnackbarCustomModel snackbarCustomModel}) {
    var size = MediaQuery.of(context).size;
    var textStyle = TextStyle(color: MyColors.semiDarkColor);
    styleStatus(SnackbarCustomEnum snackbarCustomEnum) {
      switch (snackbarCustomEnum) {
        case SnackbarCustomEnum.DONE:
          return {
            "icon": Icons.check,
            "color": Colors.green,
          };
        case SnackbarCustomEnum.INFO:
          return {
            "icon": Icons.info_outline,
            "color": Colors.lightBlue,
          };
        case SnackbarCustomEnum.ERROR:
          return {
            "icon": Icons.error_outline,
            "color": MyColors.errorColor,
          };
      }
    }

    ;
    return SnackBar(
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      behavior: SnackBarBehavior.floating,
      elevation: 1,
      content: Container(
        decoration: BoxDecoration(
          color: MyColors.darkColor,
          borderRadius: BorderRadius.circular(5),
          gradient: new LinearGradient(
            stops: [0.02, 0.02],
            colors: [
              styleStatus(snackbarCustomModel.status)["color"] as Color,
              Colors.white
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Container(
            child: Row(
              children: <Widget>[
                Icon(
                  styleStatus(snackbarCustomModel.status)["icon"] as IconData,
                  color:
                      styleStatus(snackbarCustomModel.status)["color"] as Color,
                  size: 28,
                ),
                SizedBox(width: 8.0),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snackbarCustomModel.title,
                        style: textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        snackbarCustomModel.message,
                        textAlign: TextAlign.justify,
                        
                        softWrap: true,
                        style: textStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
