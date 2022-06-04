import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view_model/auth_viewmodel.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view/favorite_screen/favorite_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view/home_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view/profile_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/menu_viewmodel.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:provider/provider.dart';

class SidebarLayout extends StatelessWidget {
  static const routeName = '/Menu';
  SidebarLayout({Key? key}) : super(key: key);

  // final _controller = SidebarXController(selectedIndex: 2, extended: true);

  final _textStyle = const TextStyle(
      color: MyColorsConst.whiteColor,
      fontSize: 16,
      fontWeight: FontWeight.normal);
  final _divider =
      const Divider(color: MyColorsConst.whiteColor, indent: 8, endIndent: 8);
  final _itemPadding = const EdgeInsets.only(left: 24);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var providerWatch = context.watch<MenuViewModel>();
    return Scaffold(
      appBar: providerWatch.getAppBarTitle,
      drawer: SidebarX(
        controller: providerWatch.getSidebarXController!,
        theme: SidebarXTheme(
          // decoration: BoxDecoration(
          //   color: MyColors.darkColor,
          // ),
          textStyle: this._textStyle,
          selectedTextStyle: this._textStyle,
          selectedIconTheme: IconThemeData(color: MyColorsConst.whiteColor),
          itemTextPadding: this._itemPadding,
          selectedItemTextPadding: this._itemPadding,
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: MyColorsConst.primaryLightColor,
            ),
            gradient: const LinearGradient(
              colors: [
                MyColorsConst.primaryLightColor,
                MyColorsConst.primaryColor
              ],
            ),
          ),
          iconTheme: const IconThemeData(
            color: MyColorsConst.whiteColor,
            size: 24,
          ),
        ),
        extendedTheme: SidebarXTheme(
            width: size.width * 2 / 3,
            decoration: BoxDecoration(
              color: MyColorsConst.primaryColor,
            ),
            // margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16)),
        headerBuilder: (context, extended) {
          return SafeArea(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: (size.width * 2 / 3) / 6,
                  backgroundColor: MyColorsConst.lightDarkColor,
                ),
                SizedBox(height: 12),
                Text(
                  providerWatch.getUserLogged?.name ?? "Full Name",
                  style: TextStyle(
                    color: MyColorsConst.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 1,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                Text(
                  providerWatch.getUserLogged?.email ?? "Example@email.com",
                  style: TextStyle(
                    color: MyColorsConst.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
        headerDivider: this._divider,
        footerBuilder: (context, extended) {
          return TextButton(
            onPressed: () =>
                context.read<AuthViewModel>().logoutProcess(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.logout,
                    color: MyColorsConst.whiteColor,
                    size: 24,
                  ),
                  Padding(
                    padding: _itemPadding,
                    child: Text(
                      "Logout",
                      style: _textStyle,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        footerDivider: this._divider,
        showToggleButton: false,
        items: [
          SidebarXItem(
            icon: Icons.home,
            label: 'Home',
            onTap: () => providerWatch.setOnSidebarItemSelected(index: 0),
          ),
          SidebarXItem(
            icon: Icons.favorite,
            label: 'Favorite',
            onTap: () => providerWatch.setOnSidebarItemSelected(index: 1),
          ),
          SidebarXItem(
            icon: Icons.person,
            label: 'Profile',
            onTap: () => providerWatch.setOnSidebarItemSelected(index: 2),
          ),
        ],
      ),
      body: _MenuScreenControll(
        controller: providerWatch.getSidebarXController!,
      ),
    );
  }
}

class _MenuScreenControll extends StatelessWidget {
  const _MenuScreenControll({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return HomeScreen(title: "Home");
          case 1:
            return FavoriteScreen();
          case 2:
            return ProfileScreen();
          default:
            return Center(
              child: Text(
                'Not found page',
                style: TextStyle(color: Colors.black),
              ),
            );
        }
      },
    );
  }
}
