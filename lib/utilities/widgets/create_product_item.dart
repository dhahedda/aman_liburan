import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:aman_liburan/models/catalog_model.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class CreateProductItem extends StatelessWidget {
  final GestureTapCallback onTapDetail;
  final GestureTapCallback onTapCircle;
  final TypeProductItem typeProductItem;
  final CatalogModel catalogModel;

  const CreateProductItem({
    Key key,
    @required this.onTapDetail,
    @required this.onTapCircle,
    @required this.catalogModel,
    this.typeProductItem: TypeProductItem.type_medium,
  }) : super(key: key);

  Future<String> getAdministrativeArea(double latitude, double longitude) async {
    List<Placemark> placemarks = [];
    try {
      placemarks = await Geolocator().placemarkFromCoordinates(latitude, longitude);
    } catch (e) {
      // Handle error location not found
      print("placemarks_error =>${e.toString()}");
      placemarks.add(Placemark(name: 'unknown_location'));
    }
    String administrativeArea = "Unknown Location";

    if (placemarks[0].name != "unknown_location") {
      administrativeArea = placemarks[0].administrativeArea;
    }

    return administrativeArea;
  }

  Future<double> getDistance(endLatitude, endLongitude) async {
    Position lastPosition = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    if (lastPosition == null) {
      lastPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }
    double startLatitude = lastPosition.latitude;
    double startLongitude = lastPosition.longitude;

    double distanceInMeters = await Geolocator().distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );

    double distanceInKm = (distanceInMeters / 1000);
    return distanceInKm;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAdministrativeArea(catalogModel.location.latitude, catalogModel.location.longitude),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          String administrativeArea = "Unknown Location";

          if (snapshot.data != null) {
            administrativeArea = snapshot.data;
          }

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: colorSoftBlueBold.withOpacity(0.5),
                  blurRadius: 3.0,
                  offset: const Offset(1.0, 2.0),
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: onTapDetail,
                  behavior: HitTestBehavior.translucent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      catalogModel.imageUrl == null
                          ? Container(
                              height: 180.0,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                shape: BoxShape.rectangle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    EvaIcons.filmOutline,
                                    color: Colors.white,
                                    size: 60.0,
                                  )
                                ],
                              ),
                            )
                          : Stack(
                              children: <Widget>[
                                Container(
                                  height: 180.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(catalogModel.imageUrl),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 10,
                                  bottom: 10,
                                  child: Container(
                                    padding: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16.0),
                                      ),
                                      shape: BoxShape.rectangle,
                                      color: Colors.white38,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(EvaIcons.pin, color: Colors.white, size: 14.0),
                                        SizedBox(width: .0),
                                        Center(
                                          child: Text(
                                            'KARANGANYAR',
                                            maxLines: 2,
                                            style: TextStyle(
                                              height: 1.4,
                                              color: colorWhite,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Text(
                                '${catalogModel.title}',
                                maxLines: 2,
                                style: TextStyle(
                                  height: 1.4,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 5.0,
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                '¥ ${catalogModel.price}',
                                maxLines: 1,
                                style: TextStyle(height: 1.4, color: Theme.Colors.turqoiseNormal, fontWeight: FontWeight.bold, fontSize: 11.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RichText(
                        maxLines: 1,
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: IconTheme(
                                data: IconThemeData(color: colorDarkBackground, opacity: 0.5),
                                child: Icon(
                                  Icons.location_on,
                                  size: 14,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: administrativeArea,
                              style: TextStyle(
                                color: colorDarkBackground,
                                letterSpacing: 1,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Nunito",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
                // Button icon favorite
                // Positioned(
                //   top: 8,
                //   right: 8,
                //   child: CircleButton(
                //     onTap: onTapCircle,
                //     iconData: catalogModel.isWishlist ? CustomIcons.favorite : CustomIcons.favorite_outline_white,
                //     iconSize: 18,
                //     color: catalogModel.isWishlist ? Colors.pink : Colors.white,
                //     backgrounColor: Colors.black45,
                //     padding: 8,
                //   ),
                // ),
              ],
            ),
          );
        });
  }
}

enum TypeProductItem {
  type_small,
  type_medium,
  type_large,
}
