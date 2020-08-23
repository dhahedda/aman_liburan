import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/full_image.dart';

class CachedImage extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  final bool isAvatar;
  final bool hasFullImageViewer;

  const CachedImage({
    Key key,
    @required this.width,
    @required this.height,
    @required this.imageUrl,
    this.isAvatar = false,
    this.hasFullImageViewer = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double radius = 8.0;
    String defaultImagePath = 'assets/images/img_not_available.jpg';
    if (isAvatar) {
      radius = 50.0;
      defaultImagePath = 'assets/images/profile-placeholder.png';
    }
    return Material(
      child: InkWell(
        onTap: hasFullImageViewer
            ? () => Navigator.push(context, MaterialPageRoute(builder: (context) => FullImage(url: imageUrl)))
            : null,
        child: CachedNetworkImage(
          placeholder: (context, url) => Container(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(colorOrangeGaijin),
            ),
            width: width,
            height: height,
            padding: EdgeInsets.all(70.0),
            decoration: BoxDecoration(
              color: Color(0xFFE8E8E8),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Material(
            child: Image.asset(
              defaultImagePath,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            clipBehavior: Clip.hardEdge,
          ),
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      clipBehavior: Clip.hardEdge,
    );
  }
}
