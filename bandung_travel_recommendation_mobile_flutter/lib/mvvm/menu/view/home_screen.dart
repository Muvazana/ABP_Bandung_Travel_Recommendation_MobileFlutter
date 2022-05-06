import 'dart:ffi';

import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/place_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  final _dataDiscover = [
    {"title": "Situs Cagar Budaya", "image_name": "situs_cagar_budaya.jpg"},
    {"title": "Museum", "image_name": "museum.jpg"},
    {"title": "Mall", "image_name": "mall.jpg"},
    {"title": "Outlet", "image_name": "outlet.jpg"},
  ];

  final _dataRecomPlace = List.generate(
    20,
    (index) => Place(
      id: index,
      name: "Place $index",
      typePlaceId: 0,
      rate: 0,
      description: "Place $index Description",
      imageName: "museum.jpg",
      alamat: "",
      latitude: "",
      longitude: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      view: 0,
      placeType: PlaceType.dataDummy(),
    ),
  );

  final _teamsData = [
    {
      "name": "Moch. Nauval Rizaldi N",
      "nim": "1301194482",
      "imageName": "",
      "linkedInUrl": "",
      "githubUrl": ""
    },
    {
      "name": "Arga Melvern",
      "nim": "1301194055",
      "imageName": "",
      "linkedInUrl": "",
      "githubUrl": ""
    },
    {
      "name": "Mohammad Akbar Fauzy",
      "nim": "1301194133",
      "imageName": "",
      "linkedInUrl": "",
      "githubUrl": ""
    },
    {
      "name": "Jane Raihan",
      "nim": "1301194240",
      "imageName": "",
      "linkedInUrl": "",
      "githubUrl": ""
    },
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
        SliverAppBar(
          pinned: _pinned,
          snap: _snap,
          floating: _floating,
          expandedHeight: size.height - AppBar().preferredSize.height,
          backgroundColor: MyColors.primaryColor.withOpacity(0.6),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              alignment: Alignment.topCenter,
              children: _buildHeader(size),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            _buildDiscoverPage(size),
            _buildRecomPage(size),
            Container(
              color: MyColors.whiteColor,
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: <Widget>[
                  _addTitleV1("Meet Our Teams", MyColors.semiDarkColor),
                  SizedBox(height: 24),
                  Container(
                    width: size.width,
                    height: 100,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
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
            color: MyColors.whiteColor,
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
                  color: MyColors.whiteColor,
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
                color: MyColors.whiteColor,
                size: 32,
              ),
              Text(
                "Scroll Down",
                style: TextStyle(
                  color: MyColors.whiteColor,
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
          _addTitleV1("Discover Our Collection", MyColors.semiDarkColor),
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
                  color: MyColors.whiteColor,
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
  Widget _buildRecomPage(Size size) {
    var height = size.height * 4 / 5;
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
          _addTitleV1("Recommended for you", MyColors.whiteColor),
          SizedBox(height: 24),
          _buildRecomPageCarousel(_dataRecomPlace, height, size),
          Spacer(),
          _buildRecomPageCarousel(_dataRecomPlace, height, size,
              isPlace: false),
        ],
      ),
    );
  }

  Widget _buildRecomPageCarousel(List<Place> data, double height, Size size,
      {bool isPlace = true}) {
    recomTitle(String title) => Expanded(
          flex: 1,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: MyColors.whiteColor,
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
              items: _carouselRecomCardItems(height, size, data),
            ),
          ),
        ),
        if (!isPlace) recomTitle("Hotel"),
      ],
    );
  }

  List<Widget> _carouselRecomCardItems(
      double height, Size size, List<Place> data) {
    return data
        .map(
          (e) => InkWell(
            onTap: () {
              debugPrint(e.name);
            },
            child: Container(
              height: height / 3,
              width: size.width * 1 / 3,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: MyColors.whiteColor,
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
                    child: Image(
                      image:
                          AssetImage("assets/images/menu/home/" + e.imageName),
                      fit: BoxFit.fill,
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
                                e.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: MyColors.semiDarkColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                e.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: MyColors.semiDarkColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.visibility,
                                color: MyColors.semiDarkColor,
                                size: 14,
                              ),
                              SizedBox(width: 6),
                              Text(
                                e.view.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: MyColors.semiDarkColor,
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
}
