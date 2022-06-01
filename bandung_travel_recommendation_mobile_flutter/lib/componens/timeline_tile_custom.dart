import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineTileCustom extends StatelessWidget {
  final String title;
  final bool isFirst, isLast;
  final VoidCallback? onTap;
  const TimeLineTileCustom(
    this.title, {
    Key? key,
    this.isFirst = false,
    this.isLast = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: TimelineTile(
        alignment: TimelineAlign.start,
        isFirst: isFirst,
        isLast: isLast,
        indicatorStyle:
            IndicatorStyle(width: 12, height: 12, color: MyColorsConst.primaryColor),
        afterLineStyle: LineStyle(thickness: 3, color: MyColorsConst.primaryColor),
        beforeLineStyle: LineStyle(thickness: 3, color: MyColorsConst.primaryColor),
        endChild: Container(
          margin: const EdgeInsets.only(left: 8),
          alignment: Alignment.centerLeft,
          constraints: const BoxConstraints(
            minHeight: 30,
          ),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: MyColorsConst.semiDarkColor,
              fontSize: 16,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
