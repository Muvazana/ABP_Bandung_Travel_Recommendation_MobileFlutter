import 'package:bandung_travel_recommendation_mobile_flutter/componens/cache_network_image_custom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/modal_bottom_sheet_custom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/text_button_custom_v1.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/place_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/team_profile_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/menu_viewmodel.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  String title;

  HomeScreen({Key? key, required this.title}) : super(key: key);
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  final _dataDiscover = [
    {"title": "Situs Cagar Budaya", "image_name": "situs_cagar_budaya.jpg"},
    {"title": "Museum", "image_name": "museum.jpg"},
    {"title": "Mall", "image_name": "mall.jpg"},
    {"title": "Outlet", "image_name": "outlet.jpg"},
  ];

  _addTitleV1(String title, Color color) => Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );

  _addDecorationImageBG(String src, {double opacity = 0.5}) => DecorationImage(
        colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(opacity), BlendMode.srcOver),
        image: AssetImage(src),
        fit: BoxFit.cover,
      );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: <Widget>[
        SliverLayoutBuilder(
          builder: (context, constraints) {
            var isSliverCollapse = (constraints.scrollOffset >
                (size.height - (AppBar().preferredSize.height * 2)));
            return SliverAppBar(
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              expandedHeight: size.height - AppBar().preferredSize.height,
              backgroundColor: MyColorsConst.primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: isSliverCollapse
                    ? Text(
                        this.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColorsConst.whiteColor),
                      )
                    : null,
                background: Stack(
                  alignment: Alignment.topCenter,
                  children: _buildHeader(size),
                ),
              ),
            );
          },
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            _buildDiscoverPage(size),
            _buildRecomPage(context, size),
            _buildTeamsPage(size),
          ]),
        ),
      ],
    );
  }

  // Header Page
  List<Widget> _buildHeader(Size size) => [
        Container(
          decoration: BoxDecoration(
            image: _addDecorationImageBG('assets/images/bg_main.jpg'),
          ),
        ),
        Positioned(
          top: size.height * 1 / 4,
          child: SvgPicture.asset(
            'assets/images/logo_v2.svg',
            alignment: Alignment.center,
            width: size.width * 2 / 3,
            color: MyColorsConst.whiteColor,
          ),
        ),
        Positioned(
          width: size.width,
          bottom: size.height * 1 / 4,
          child: Container(
            padding: EdgeInsets.only(left: size.width * 1 / 10),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MyColorsConst.whiteColor,
                  height: 0.8,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'DISCOVER THE BEST OF\n',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                    text: 'BANDUNG',
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          child: Column(
            children: [
              Icon(
                Icons.keyboard_double_arrow_down,
                color: MyColorsConst.whiteColor,
                size: 32,
              ),
              Text(
                "Scroll Down",
                style: TextStyle(
                  color: MyColorsConst.whiteColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ];

  // Discover Our Collection Page
  Widget _buildDiscoverPage(Size size) {
    return Container(
      height: size.height * 2 / 5,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: <Widget>[
          _addTitleV1("Discover Our Collection", MyColorsConst.semiDarkColor),
          SizedBox(height: 24),
          Expanded(
            child: Container(
              width: size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 0.4,
                  aspectRatio: 1.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  initialPage: 0,
                  autoPlay: true,
                  disableCenter: true,
                ),
                items: _carouselDiscoverCardItems(size),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _carouselDiscoverCardItems(Size size) {
    return _dataDiscover
        .map(
          (e) => Container(
            width: size.width * 1 / 3,
            height: (size.height * 2 / 5) * 3 / 5,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.40), BlendMode.srcOver),
                image:
                    AssetImage("assets/images/menu/home/" + e["image_name"]!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                e["title"]!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyColorsConst.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                maxLines: 2,
              ),
            ),
          ),
        )
        .toList();
  }

  // Recommended Places Page
  Widget _buildRecomPage(BuildContext context, Size size) {
    var watchProvider = context.watch<MenuViewModel>();
    var height = size.height * 5 / 6;
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        image: _addDecorationImageBG("assets/images/menu/home/bg_rec.png",
            opacity: 0.4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _addTitleV1("Recommended for you", MyColorsConst.whiteColor),
          SizedBox(height: 24),
          _buildRecomPageCarousel(
            context,
            watchProvider.getPlacesDest ?? PlaceModel.dataDummyList(),
            height,
            size,
          ),
          Spacer(),
          _buildRecomPageCarousel(
            context,
            watchProvider.getPlacesHotel ?? PlaceModel.dataDummyList(),
            height,
            size,
            isPlace: false,
          ),
          Spacer(),
          TextButtonCustomV1(
            text: "Schedule Now!",
            margin: const EdgeInsets.symmetric(horizontal: 32),
            backgroundColor: MyColorsConst.primaryColor,
            textColor: MyColorsConst.whiteColor,
            onPressed: () => context
                .read<MenuViewModel>()
                .setOnSidebarItemSelected(index: 2),
          ),
        ],
      ),
    );
  }

  Widget _buildRecomPageCarousel(
      BuildContext context, List<PlaceModel> data, double height, Size size,
      {bool isPlace = true}) {
    recomTitle(String title) => Expanded(
          flex: 1,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: MyColorsConst.whiteColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (isPlace) recomTitle("Place"),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            child: CarouselSlider(
              options: CarouselOptions(
                  height: height / 3,
                  viewportFraction: 0.55,
                  aspectRatio: 1.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  disableCenter: true,
                  padEnds: false,
                  reverse: !isPlace),
              items: _carouselRecomCardItems(context, height, size, data),
            ),
          ),
        ),
        if (!isPlace) recomTitle("Hotel"),
      ],
    );
  }

  List<Widget> _carouselRecomCardItems(
    BuildContext context,
    double parentHeight,
    Size size,
    List<PlaceModel> data,
  ) {
    return data
        .map(
          (e) => InkWell(
            onTap: () => MyModalBottomSheetCustom.showPlaceDetail(
              context,
              place: e,
            ),
            child: Container(
              height: parentHeight / 3,
              width: size.width * 1 / 3,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: MyColorsConst.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: CacheNetworkImageCustom(
                      e.imageName != null
                          ? "${MyGeneralConst.API_IMAGE_URL}/${e.imageName}"
                          : "dummy",
                      width: double.maxFinite,
                      height: double.maxFinite,
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                e.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: MyColorsConst.semiDarkColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                e.description ?? '',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: MyColorsConst.semiDarkColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.visibility,
                                color: MyColorsConst.semiDarkColor,
                                size: 14,
                              ),
                              SizedBox(width: 6),
                              Text(
                                e.view.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: MyColorsConst.semiDarkColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  Widget _buildTeamsPage(Size size) {
    // var height = size.height + size.height * 1 / 4;
    return Container(
      color: MyColorsConst.whiteColor,
      // height: height,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: <Widget>[
          _addTitleV1("Meet Our Teams", MyColorsConst.semiDarkColor),
          SizedBox(height: 16),
          for (var i = 0; i < TeamProfileModel.TeamsProfile.length; i++)
            _teamsCardItem(size, TeamProfileModel.TeamsProfile[i],
                isLeft: i % 2 == 0)
        ],
      ),
    );
  }

  Widget _teamsCardItem(Size size, TeamProfileModel profile,
      {bool isLeft = true}) {
    var width = size.width / 2;
    var height = width - width / 4;
    var widthSide = width / 4;
    var heightSide = height * 2 / 3;

    mText(text, {isSubText = false}) => Text(
          text,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: MyColorsConst.semiDarkColor,
            fontSize: (height / 2) / (isSubText ? 6 : 5),
            fontWeight: isSubText ? FontWeight.normal : FontWeight.bold,
            overflow: TextOverflow.clip,
          ),
        );

    mIcon(src, url) => InkWell(
          child: Container(
            width: widthSide * 2 / 3,
            height: widthSide * 2 / 3,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: MyColorsConst.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(src, color: MyColorsConst.primaryColor),
          ),
          onTap: () async {
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {
              debugPrint('Could not launch $url');
            }
          },
        );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Spacer(flex: isLeft ? 1 : 3),
          Container(
            width: width,
            height: height,
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: MyColorsConst.whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: Offset(15, 15),
                  blurRadius: 35,
                  spreadRadius: -10,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: MyColorsConst.lightDarkColor,
                  backgroundImage: profile.imagePath != null
                      ? NetworkImage(profile.imagePath!)
                      : null,
                  radius: (height / 2) * 1.8 / 3,
                  child: profile.imagePath == null
                      ? Icon(
                          Icons.person,
                          color: MyColorsConst.primaryColor,
                          size: (height / 2) * 1.8 / 3,
                        )
                      : null,
                ),
                Spacer(flex: 4),
                mText(profile.name),
                Spacer(flex: 1),
                mText(profile.nim, isSubText: true),
              ],
            ),
          ),
          Container(
            width: widthSide,
            height: heightSide,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: MyColorsConst.primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: Offset(15, 0),
                  blurRadius: 35,
                  spreadRadius: -10,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                mIcon("assets/icons/linkedin.svg", profile.linkedInUrl),
                mIcon("assets/icons/github.svg", profile.githubUrl),
              ],
            ),
          ),
          Spacer(flex: !isLeft ? 1 : 3),
        ],
      ),
    );
  }
}
