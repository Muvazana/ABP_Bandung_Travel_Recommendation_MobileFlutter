import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view/favorite_screen/favorite_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view/home_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view/profile_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/sidebar_view_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:provider/provider.dart';

class SidebarLayout extends StatelessWidget {
  static const routeName = '/Menu';
  SidebarLayout({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 2, extended: true);

  final _textStyle = const TextStyle(
      color: MyColors.whiteColor, fontSize: 16, fontWeight: FontWeight.normal);
  final _divider =
      const Divider(color: MyColors.whiteColor, indent: 8, endIndent: 8);
  final _itemPadding = const EdgeInsets.only(left: 24);
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: context.watch<SidebarViewModel>().appBarTitle,
      drawer: SidebarX(
        controller: _controller,
        theme: SidebarXTheme(
          // decoration: BoxDecoration(
          //   color: MyColors.darkColor,
          // ),
          textStyle: this._textStyle,
          selectedTextStyle: this._textStyle,
          itemTextPadding: this._itemPadding,
          selectedItemTextPadding: this._itemPadding,
          // itemDecoration: BoxDecoration(
          //   border: Border.all(color: canvasColor),
          // ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: MyColors.primaryLightColor,
            ),
            gradient: const LinearGradient(
              colors: [MyColors.primaryLightColor, MyColors.primaryColor],
            ),
          ),
          iconTheme: const IconThemeData(
            color: MyColors.whiteColor,
            size: 24,
          ),
        ),
        extendedTheme: SidebarXTheme(
            width: size.width * 2 / 3,
            decoration: BoxDecoration(
              color: MyColors.primaryColor,
            ),
            // margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16)),
        headerBuilder: (context, extended) {
          return SafeArea(
            child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: (size.width * 2 / 3) / 6,
                    backgroundColor: MyColors.lightDarkColor,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Full Name",
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 1,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Example@email.com",
                    style: TextStyle(
                      color: MyColors.whiteColor,
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
            onPressed: () {
              debugPrint("Presss");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.logout,
                    color: MyColors.whiteColor,
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
            onTap: () => context
                .read<SidebarViewModel>()
                .setOnSidebarItemClicked(0),
          ),
          SidebarXItem(
            icon: Icons.dashboard_rounded,
            label: 'Dashboard',
            onTap: () => context
                .read<SidebarViewModel>()
                .setOnSidebarItemClicked(1),
          ),
          SidebarXItem(
            icon: Icons.favorite,
            label: 'Favorite',
            onTap: () => context
                .read<SidebarViewModel>()
                .setOnSidebarItemClicked(2),
          ),
          SidebarXItem(
            icon: Icons.person,
            label: 'Profile',
            onTap: () => context
                .read<SidebarViewModel>()
                .setOnSidebarItemClicked(3),
          ),
        ],
      ),
      body: _MenuScreenControll(
        controller: _controller,
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
            return Center(
              child: Text(
                'Dashboard',
                style: TextStyle(color: Colors.black),
              ),
            );
          case 2:
            return FavoriteScreen();
          case 3:
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
