import 'package:bandung_travel_recommendation_mobile_flutter/componens/cache_network_image_custom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';

class SchedulePlaceCard extends StatefulWidget {
  final bool? isSelected;
  final String imageUrl, title, description, view;
  final Function(bool isSelected) onTap;
  final Function()? onLongPress;
  SchedulePlaceCard({
    Key? key,
    this.isSelected = false,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.view,
    required this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  State<SchedulePlaceCard> createState() => _SchedulePlaceCardState();
}

class _SchedulePlaceCardState extends State<SchedulePlaceCard> {
  late bool _isSelected;
  TextStyle textStyle = const TextStyle(
    color: MyColorsConst.semiDarkColor,
    fontSize: 14,
  );
  @override
  void initState() {
    this._isSelected = this.widget.isSelected!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.width / 3;
    return Container(
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: MyColorsConst.whiteColor,
        semanticContainer: true,
        elevation: 3,
        child: InkWell(
          onTap: () {
            setState(() {
              _isSelected = !_isSelected;
            });
            this.widget.onTap(_isSelected);
          },
          onLongPress: this.widget.onLongPress,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: <Widget>[
                CacheNetworkImageCustom(
                  this.widget.imageUrl,
                  width: height,
                  height: height,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          this.widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: textStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                int maxLines = (constraints.maxHeight /
                                        textStyle.fontSize!)
                                    .floor();
                                maxLines = maxLines > 0 ? maxLines : 1;
                                return new Text(
                                  this.widget.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: maxLines,
                                  style: textStyle.copyWith(fontSize: 12),
                                );
                              },
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.visibility,
                              color: MyColorsConst.semiDarkColor,
                              size: 16,
                            ),
                            SizedBox(width: 6),
                            Text(
                              this.widget.view,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isSelected == true)
                  Container(
                    width: 50,
                    height: height,
                    color: MyColorsConst.primaryColor,
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: MyColorsConst.whiteColor,
                        size: 24,
                      ),
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
