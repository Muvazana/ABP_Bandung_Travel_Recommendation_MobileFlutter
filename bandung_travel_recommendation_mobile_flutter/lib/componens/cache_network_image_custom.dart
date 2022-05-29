import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheNetworkImageCustom extends StatelessWidget {
  const CacheNetworkImageCustom(
    this.imageUrl, {
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);
  final String imageUrl;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => _imageBG(image: imageProvider),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => _imageBG(),
    );
  }

  Widget _imageBG({ImageProvider<Object>? image}) {
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black38,
        image: image == null
            ? null
            : DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: image != null
          ? null
          : Center(
              child: Icon(
                Icons.image_not_supported_sharp,
                size: 32,
                color: MyColors.errorColor,
              ),
            ),
    );
  }
}
