import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';

class SidebarViewModel extends ChangeNotifier {
  AppBar? _appBarTitle = null;

  SidebarViewModel(){
    setOnSidebarItemClicked(2);
  }

  AppBar? get appBarTitle => _appBarTitle;

  setOnSidebarItemClicked(int idx) {
    var title = null;
    switch (idx) {
      case 0:
        title = null;
        break;
      case 1:
        title = "Dashboard";
        break;
      case 2:
        title = "Favorite";
        break;
      case 3:
        title = "Profile";
        break;
      default:
        title = "Error";
        break;
    }
    _appBarTitle = title != null
        ? AppBar(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: MyColors.primaryColor,
          )
        : null;
    notifyListeners();
  }
}
