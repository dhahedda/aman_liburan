import 'dart:collection';
import 'dart:ui';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:aman_liburan/models/carousel_model.dart';
import 'package:aman_liburan/models/catalog_model.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/screens/detail_product/detail_map_page.dart';
import 'package:aman_liburan/screens/search/search_page.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/circle_button.dart';
import 'package:aman_liburan/utilities/widgets/horizontal_line.dart';
import 'package:aman_liburan/blocs/detail_product/detail_product_bloc.dart';
import 'package:aman_liburan/screens/detail_product/full_screen_carousel_page.dart';
import 'package:aman_liburan/utilities/widgets/illustration_loading.dart';
import 'dart:math' as math;
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class DetailProductPage extends StatelessWidget {
  final String productId;
  final bool androidFusedLocation;

  const DetailProductPage({Key key, this.productId, this.androidFusedLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<DetailProductBloc>(
        create: (context) => DetailProductBloc()
          ..add(
            PermissionEvent(
              id: productId,
              androidFusedLocation: androidFusedLocation,
            ),
          ),
        child: DetailProductPageScreen(productId, androidFusedLocation),
      );
}

class DetailProductPageScreen extends StatefulWidget {
  final String productId;
  final bool androidFusedLocation;

  DetailProductPageScreen(this.productId, this.androidFusedLocation);

  @override
  _DetailProductPageScreenState createState() =>
      _DetailProductPageScreenState(productId, androidFusedLocation);
}

class _DetailProductPageScreenState extends State<DetailProductPageScreen> {
  final String productId;
  final bool androidFusedLocation;

  _DetailProductPageScreenState(this.productId, this.androidFusedLocation);

  void makeAppointmentPressed(
    GlobalResponse response,
    BuildContext context,
  ) {
    // Navigator.of(context).pop();
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => CreateAppointmentPage(response: response),
    //   ),
    // );
  }

  void onButtonAppointmentPressed(
    GlobalResponse response,
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFF737373),
          height: 200,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Make Appointment"),
                ),
                HorizontalLine(
                  width: double.infinity,
                  color: Colors.grey.withOpacity(.6),
                  padding: 0.0,
                ),
                // Make Appointment
                GestureDetector(
                  onTap: () {
                    makeAppointmentPressed(response, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.supervised_user_circle,
                            size: 32.0,
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Create Appointment",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              Text(
                                "Set a schedule to meet with owner",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void goToChatPage({
    @required BuildContext context,
    @required ChatLobbyResponse chatLobby,
    @required String userId,
  }) {
    // Navigator.of(context).pop();
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ChatMessagesPage(
    //       chatLobby: chatLobby,
    //       signedInAccountUserId: userId,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailProductBloc, DetailProductState>(
      listener: (context, state) {
        if (state is InitiateChatResponse) {
          String status = state.response.status;
          if (status == "Success") {
            goToChatPage(
              context: context,
              chatLobby: state.response.data.room,
              userId: state.receiverid,
            );
          }
        }
      },
      builder: (context, state) {
        final stateCarousel = state.carouselPosition;

        CarouselSlider getFullScreenCarousel(
          BuildContext mediaContext,
          List<CarouselModel> listItem,
          GlobalResponse response,
        ) {
          return CarouselSlider.builder(
            options: CarouselOptions(
              autoPlay: false,
              reverse: false,
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              aspectRatio: MediaQuery.of(mediaContext).size.aspectRatio,
              scrollDirection: Axis.horizontal,
              initialPage: stateCarousel,
              onPageChanged: (index, reason) {
                BlocProvider.of<DetailProductBloc>(context)
                    .add(CarouselEvent(position: index));
              },
            ),
            itemCount: listItem.length,
            itemBuilder: (BuildContext context, int itemIndex) => Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenCarouselPage(
                          listItem: listItem,
                          carouselPosition: stateCarousel,
                          response: response,
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        listItem.elementAt(itemIndex).imageUrl,
                        fit: BoxFit.cover,
                        width: 1000.0,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                        colors: [
                          Colors.black45,
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.5],
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        tileMode: TileMode.mirror,
                      ))),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        List<T> mapingCarousel<T>(List list, Function handler) {
          List<T> result = [];
          for (var i = 0; i < list.length; i++) {
            result.add(handler(i, list[i]));
          }
          return result;
        }

        Widget _buildCarouselData(
          BuildContext context,
          List<CarouselModel> listItem,
          GlobalResponse response,
        ) {
          return Container(
            color: Colors.white10,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Positioned.fill(
                  child: getFullScreenCarousel(context, listItem, response),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 20.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: mapingCarousel<Widget>(
                      listItem,
                      (index, url) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 150),
                          width: stateCarousel == index ? 30.0 : 8.0,
                          height: stateCarousel == index ? 8.0 : 8.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            color: stateCarousel == index
                                ? Theme.Colors.turqoiseNormal
                                : Colors.white70,
                            borderRadius: stateCarousel == index
                                ? BorderRadius.all(Radius.circular(4.0))
                                : BorderRadius.all(Radius.circular(20)),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        }

        Widget _buildCarouselBaner(GlobalResponse response) {
          List<CarouselModel> listItem = [];
          List<ImagesResponse> listBanner = response.data.item.images;

          for (var i = 0; i < listBanner.length; i++) {
            listItem.add(
              CarouselModel(
                "_title",
                "_content",
                listBanner[i].imgUrl,
                'action',
              ),
            );
          }

          return _buildCarouselData(context, listItem, response);
        }

        Widget _buildDetailProduct(GlobalResponse response) {
          ItemResponse detailItem = response.data.item;
          DetailItemResponse detailItemResponse = response.data.details;

          String productId = detailItem.id;
          String productName = "${detailItem.name}";
          String productDescription = "${detailItem.description}";
          String brandDescription = detailItemResponse.brand;
          String conditionDescription = detailItemResponse.condition;
          String yearsOwnedDescription = detailItemResponse.yearsOwned;
          String modelNameDescription = detailItemResponse.modelName;
          String mainAddress = "Unknown Location";
          String detailAddress = "Unknown Location";

          if (state.placemarks[0].name != "unknown_location") {
            mainAddress =
                "${state.placemarks[0].name}, ${state.placemarks[0].locality}";
            detailAddress =
                "${state.placemarks[0].subLocality}, ${state.placemarks[0].administrativeArea}, ${state.placemarks[0].subAdministrativeArea} ${state.placemarks[0].postalCode}, ${state.placemarks[0].country}";
          }
          double latitude = detailItem.location.latitude;
          double longitude = detailItem.location.longitude;

          // Membuat marker
          Set<Marker> _markers = HashSet<Marker>();

          void _onMapCreated(GoogleMapController controller) {
            setState(() {
              _markers.add(
                Marker(
                  markerId: MarkerId(productId),
                  position: LatLng(latitude, longitude),
                  infoWindow:
                      InfoWindow(title: productName, snippet: productName),
                ),
              );
            });
          }

          return SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Product Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: (detailItem.availability == "sold")
                            ? Container(
                                height: 40,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  shape: BoxShape.rectangle,
                                  color: colorSecondary,
                                  gradient: RadialGradient(
                                    colors: [
                                      colorWhite,
                                      colorSecondary,
                                      colorSecondary,
                                      colorSecondary,
                                    ],
                                    center: Alignment(0.85, -0.6),
                                    radius: 0.2,
                                    tileMode: TileMode.clamp,
                                    stops: [0.3, 0.5, 0.6, 0.7],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'SOLD OUT',
                                    maxLines: 2,
                                    style: TextStyle(
                                      height: 1.4,
                                      color: colorWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  child: CircleButton(
                                    onTap: () {
                                      print("Wishlist Clicked");
                                    },
                                    iconData: Icons.map,
                                    iconSize: 20,
                                    color: Colors.white,
                                    backgrounColor: Theme.Colors.turqoiseNormal,
                                    padding: 2,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: IconTheme(
                                  data: IconThemeData(
                                    color: colorDarkBackground,
                                    opacity: 0.5,
                                  ),
                                  child: Image.asset(
                                    "assets/images/brand.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: "Brand",
                                style: TextStyle(
                                  color: colorDarkBackground,
                                  letterSpacing: 1,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          brandDescription,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: IconTheme(
                                  data: IconThemeData(
                                    color: colorDarkBackground,
                                    opacity: 0.5,
                                  ),
                                  child: Image.asset(
                                    "assets/images/condition.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: "Condition",
                                style: TextStyle(
                                  color: colorDarkBackground,
                                  letterSpacing: 1,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          conditionDescription,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: IconTheme(
                                  data: IconThemeData(
                                    color: colorDarkBackground,
                                    opacity: 0.5,
                                  ),
                                  child: Image.asset(
                                    "assets/images/years_owned.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: "Years Owned",
                                style: TextStyle(
                                  color: colorDarkBackground,
                                  letterSpacing: 1,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          yearsOwnedDescription,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: IconTheme(
                                  data: IconThemeData(
                                    color: colorDarkBackground,
                                    opacity: 0.5,
                                  ),
                                  child: Image.asset(
                                    "assets/images/model_name.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: "Model Name",
                                style: TextStyle(
                                  color: colorDarkBackground,
                                  letterSpacing: 1,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          modelNameDescription,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  // Description
                  Text(
                    "Description",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Html(
                      data: """
                          $productDescription
                        """,
                      style: {
                        "html": Style(
                          backgroundColor: Colors.white,
                          color: Colors.black,
                          fontSize: FontSize.medium,
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.all(0),
                        ),
                        "h3": Style(
                          textAlign: TextAlign.start,
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.all(0),
                        ),
                        "p": Style(
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                        ),
                        "ul": Style(
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                        ),
                        "li": Style(
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                        ),
                        "var": Style(fontFamily: 'Poppins'),
                      },
                      customRender: {
                        "flutter": (RenderContext context, Widget child,
                            attributes, _) {
                          return FlutterLogo(
                            style: (attributes['horizontal'] != null)
                                ? FlutterLogoStyle.horizontal
                                : FlutterLogoStyle.markOnly,
                            textColor: context.style.color,
                            size: context.style.fontSize.size * 5,
                          );
                        },
                      },
                      onLinkTap: (url) {
                        print("Opening $url...");
                      },
                      onImageTap: (src) {
                        print(src);
                      },
                      onImageError: (exception, stackTrace) {
                        print(exception);
                      },
                    ),
                  ),
                  // Maps Location
                  Container(
                    width: SizeConfig.getWidth(context),
                    height: 120.0,
                    margin: EdgeInsets.only(top: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: GoogleMap(
                        mapType: MapType.terrain,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(latitude, longitude),
                          zoom: 10,
                        ),
                        zoomGesturesEnabled: true,
                        markers: _markers,
                      ),
                    ),
                  ),
                  // Location
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mainAddress,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: colorDarkBackground,
                                  letterSpacing: 1,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                detailAddress,
                                // "Kita-ku, Sapporo, Hokkaido 001-0020, Japan",
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: TextStyle(
                                  color: colorDarkBackground,
                                  letterSpacing: 1,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Transform.rotate(
                            angle: 45,
                            child: InkResponse(
                              onTap: () {
                                print(
                                    "Map Clicked with ID Product => $productId");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailMapPage(
                                      detailItem: detailItem,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                    color: colorSecondary,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: colorSecondary,
                                        blurRadius: 5.0,
                                        spreadRadius: 1.0,
                                        offset: Offset(2, 0),
                                      )
                                    ]),
                                child: Center(
                                  child: Icon(
                                    Icons.navigation,
                                    size: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        Widget _buildErrorBody(String message) {
          return Container(
            width: SizeConfig.getWidth(context),
            height: SizeConfig.getHeight(context),
            color: Colors.white,
            child: Center(
              child: Text(
                message,
                style: TextStyle(
                  height: 1.4,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                ),
              ),
            ),
          );
        }

        Widget _buildBody(GlobalResponse response) {
          // String sellerUserId = response.data.seller.id;
          String sellerName = response.data.seller.firstName +
              " " +
              response.data.seller.lastName;
          String goldCoin =
              " " + response.data.seller.goldCoin.toString() + " gold";
          String silverCoin =
              " " + response.data.seller.silverCoin.toString() + " silver";
          String avatarSeller = response.data.seller.avatarUrl;
          String categoryProduct = response.data.item.category.name;

          String administrativeArea = "Unknown Location";
          if (state.placemarks[0].name != "unknown_location") {
            administrativeArea = state.placemarks[0].administrativeArea;
          }

          return Scaffold(
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                // Header AppBar
                SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: CustomSliverAppBar(
                    maxHeight: 300,
                    minHeight:
                        kToolbarHeight + MediaQuery.of(context).padding.top,
                    carousel: _buildCarouselBaner(response),
                    response: response,
                    productId: productId,
                  ),
                ),
                // Content
                _buildDetailProduct(response),
                // Header Related Items
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      // Box Bellow Profile
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.getHeight(context) * 0.15),
                        decoration: BoxDecoration(
                          color: colorSoftBlue,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(15.0),
                            topRight: const Radius.circular(15.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: SizeConfig.getHeight(context) * 0.15,
                          ),
                          child: Column(children: [
                            SizedBox(height: 30.0),
                            // Other Items
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Other items from owner",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: colorDarkBackground,
                                    letterSpacing: 1,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("View all pressed!");

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => AccountSellerPage(
                                    //       userId: sellerUserId,
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  child: Text(
                                    "View all",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: colorBlueGaijin,
                                      letterSpacing: 1,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              height: 225.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: response.data.selleritems.length,
                                itemBuilder: (context, index) {
                                  return CreateProductItemDetail(
                                    itemsResponse:
                                        response.data.selleritems[index],
                                  );
                                },
                              ),
                            ),

                            SizedBox(height: 30.0),
                            // Related items
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Related items you might like",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: colorDarkBackground,
                                    letterSpacing: 1,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("View all Related items pressed!");

                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                SearchPage(
                                                    category: categoryProduct),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "View all",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: colorBlueGaijin,
                                      letterSpacing: 1,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              height: 225.0,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: response.data.relateditems.length,
                                itemBuilder: (context, index) {
                                  return CreateProductItemDetail(
                                    itemsResponse:
                                        response.data.relateditems[index],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 30.0),
                          ]),
                        ),
                      ),
                      // Profile User
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: SizeConfig.getWidth(context),
                          height: SizeConfig.getHeight(context) * 0.30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colorSoftBlue,
                                  blurRadius: 20.0,
                                  spreadRadius: 5.0,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              key: Key("column main"),
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          Align(
                                            alignment: Alignment(0.0, 0.0),
                                            child: Container(
                                              width: 70,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: colorPrimary,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment(0.0, 0.0),
                                            child: (avatarSeller == "")
                                                ? Container(
                                                    width: 65.0,
                                                    height: 65.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          colorDarkBackground,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                        360.0,
                                                      ),
                                                    ),
                                                    child: Image.network(
                                                      avatarSeller,
                                                      fit: BoxFit.cover,
                                                      width: 65.0,
                                                      height: 65.0,
                                                    ),
                                                  ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            // "Gilang Pradipta",
                                            sellerName,
                                            style: TextStyle(
                                              color: colorDarkBackground,
                                              letterSpacing: 1,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: "Poppins",
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: IconTheme(
                                                    data: IconThemeData(
                                                        color:
                                                            colorDarkBackground,
                                                        opacity: 0.5),
                                                    child: Icon(
                                                      Icons.location_on,
                                                      size: 14,
                                                    ),
                                                  ),
                                                ),
                                                TextSpan(
                                                  // text: "Hokkaido",
                                                  text: administrativeArea,
                                                  style: TextStyle(
                                                    color: colorDarkBackground,
                                                    letterSpacing: 1,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16.0, bottom: 4.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                // Gold Point
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                        child: IconTheme(
                                                          data: IconThemeData(
                                                            color:
                                                                colorDarkBackground,
                                                            opacity: 0.5,
                                                          ),
                                                          child: Image.asset(
                                                            "assets/images/gold_coin.png",
                                                            width: 20,
                                                            height: 20,
                                                          ),
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: goldCoin,
                                                        style: TextStyle(
                                                          color:
                                                              colorDarkBackground,
                                                          letterSpacing: 1,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: "Poppins",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10.0),
                                                // Silver Point
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                        child: IconTheme(
                                                          data: IconThemeData(
                                                            color:
                                                                colorDarkBackground,
                                                            opacity: 0.5,
                                                          ),
                                                          child: Image.asset(
                                                            "assets/images/silver_coin.png",
                                                            width: 20,
                                                            height: 20,
                                                          ),
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: silverCoin,
                                                        style: TextStyle(
                                                          color:
                                                              colorDarkBackground,
                                                          letterSpacing: 1,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: "Poppins",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 10,
                                        child: RaisedButton(
                                            elevation: 5.0,
                                            onPressed: () {
                                              print("View Profile Pressed");

                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         AccountSellerPage(
                                              //       userId: sellerUserId,
                                              //     ),
                                              //   ),
                                              // );
                                            },
                                            padding: const EdgeInsets.all(10.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            color: colorSoftDark,
                                            child: Text(
                                              'View Profile',
                                              style: TextStyle(
                                                color: colorDarkBackground,
                                                letterSpacing: 1,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins',
                                              ),
                                            )),
                                      ),
                                      // SizedBox(width: 10.0),
                                      // Expanded(
                                      //   flex: 4,
                                      //   child: RaisedButton(
                                      //     elevation: 5.0,
                                      //     onPressed: () {
                                      //       print("Follow Button Pressed");
                                      //     },
                                      //     padding: const EdgeInsets.all(10.0),
                                      //     shape: RoundedRectangleBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(8.0)),
                                      //     color: colorSecondary,
                                      //     child: Text(
                                      //       'Follow',
                                      //       style: TextStyle(
                                      //         color: Colors.white,
                                      //         letterSpacing: 1,
                                      //         fontSize: 10.0,
                                      //         fontWeight: FontWeight.bold,
                                      //         fontFamily: 'Poppins',
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        if (state is DetailProductInitial) {
          return IllustrationLoading();
        } else if (state is DetailProductPermissionResponse) {
          if (state.geolocationStatus == GeolocationStatus.denied) {
            return Container(
              width: SizeConfig.getWidth(context),
              height: SizeConfig.getHeight(context),
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Access location needed!',
                      maxLines: 2,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      'Allow access to the location services for this App using the device settings..',
                      maxLines: 2,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ButtonTheme(
                      minWidth: 180,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () {
                          print("Refresh Page Button Pressed");

                          Navigator.of(context).pop();
                          return Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailProductPage(
                                productId: productId,
                                androidFusedLocation: true,
                              ),
                            ),
                          );
                        },
                        padding: const EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: colorSoftDark,
                        child: Text(
                          'Refresh Page',
                          style: TextStyle(
                            color: colorPrimary,
                            letterSpacing: 1,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        } else if (state is DetailProductResponse) {
          if (state.response != null) {
            if (state.response.status == "Success") {
              return _buildBody(state.response);
            } else {
              return _buildErrorBody("Error => ${state.response.message}");
            }
          }
        } else if (state is DetailProductError) {
          print("Error => ${state.message}");
          return _buildErrorBody("Error => ${state.message}");
        }
        return IllustrationLoading();
      },
    );
  }
}

class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final GlobalResponse response;
  final double minHeight;
  final double maxHeight;
  final Widget carousel;
  final String productId;

  CustomSliverAppBar({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.response,
    @required this.carousel,
    @required this.productId,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Container(
          color: colorDarkBackground,
          child: carousel,
        ),
        Visibility(
          visible: (shrinkOffset / maxHeight) > 0.5 ? true : false,
          child: Opacity(
            opacity: shrinkOffset / maxHeight,
            child: Container(
              color: Colors.white,
            ),
          ),
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / maxHeight,
            child: Text(
              "Detail Product",
              style: TextStyle(
                color: colorDarkBackground,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: -2.0,
          child: Container(
            height: 20,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(30.0),
                topRight: const Radius.circular(30.0),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          left: 10.0,
          child: SafeArea(
            child: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: (shrinkOffset / maxHeight) > 0.5
                      ? colorDarkBackground
                      : Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(CustomSliverAppBar oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        carousel != oldDelegate.carousel;
  }
}

class GenerateProductItem extends StatelessWidget {
  final CatalogModel _model;

  GenerateProductItem(this._model);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: GestureDetector(
      onTap: () {
        print("Detail Clicked with ID => ${_model.id}");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProductPage(
              productId: _model.id,
              androidFusedLocation: true,
            ),
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          // Content Images and Description Product
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _model.imageUrl == null
                  ? Container(
                      height: 180.0,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
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
                  : Container(
                      height: 180.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(_model.imageUrl)),
                      )),
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
                        '${_model.title}',
                        maxLines: 2,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 5.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        '¥ ${_model.price}',
                        maxLines: 1,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0),
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
          // Button icon favorite
          Positioned(
            top: 8,
            right: 8,
            child: CircleButton(
              onTap: null,
              iconData: Icons.favorite,
              iconSize: 20,
              color: _model.isWishlist ? Colors.pink : Colors.grey,
              backgrounColor: Colors.white,
              padding: 4,
            ),
          ),
        ],
      ),
    )));
  }
}

class BottomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);

    Offset firstEndPoint = Offset(10, 20);
    Offset firstControlPoint = Offset(5, 25);

    path.lineTo(firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CreateProductItemDetail extends StatefulWidget {
  final ItemsResponse itemsResponse;

  CreateProductItemDetail({this.itemsResponse});

  @override
  _CreateProductItemDetailState createState() =>
      _CreateProductItemDetailState(itemsResponse);
}

class _CreateProductItemDetailState extends State<CreateProductItemDetail> {
  final ItemsResponse itemsResponse;

  _CreateProductItemDetailState(this.itemsResponse);

  @override
  void initState() {
    super.initState();
  }

  Future<double> getDistance(endLatitude, endLongitude) async {
    Position lastPosition = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    if (lastPosition == null) {
      lastPosition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
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
    double endLatitude = itemsResponse.location.latitude;
    double endLongitude = itemsResponse.location.longitude;

    return FutureBuilder(
      future: getDistance(endLatitude, endLongitude),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        String distanceRadius = "- km away";
        if (snapshot.data != null) {
          distanceRadius =
              num.parse(snapshot.data.toStringAsExponential(1)).toString() +
                  " km away";
        }

        return Container(
          width: 150,
          child: Card(
            child: GestureDetector(
              onTap: () {
                print("Detail Clicked with ID => ${widget.itemsResponse.id}");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailProductPage(
                      productId: widget.itemsResponse.id,
                      androidFusedLocation: true,
                    ),
                  ),
                );
              },
              child: Stack(
                children: <Widget>[
                  // Content Images and Description Product
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      widget.itemsResponse.imgUrl == null
                          ? Container(
                              height: 130.0,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0)),
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
                          : Container(
                              height: 130.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0)),
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    widget.itemsResponse.imgUrl,
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Text(
                                '${widget.itemsResponse.name}',
                                maxLines: 2,
                                style: TextStyle(
                                    height: 1.4,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.0),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 5.0,
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                '¥ ${widget.itemsResponse.price}',
                                maxLines: 1,
                                style: TextStyle(
                                  height: 1.4,
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 2.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: IconTheme(
                                  data: IconThemeData(
                                      color: colorDarkBackground, opacity: 0.5),
                                  child: Icon(
                                    Icons.location_on,
                                    size: 12,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: distanceRadius,
                                style: TextStyle(
                                  color: colorDarkBackground,
                                  letterSpacing: 1,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                    ],
                  ),
                  // Button icon favorite
                  Positioned(
                      top: 8,
                      right: 8,
                      child: (itemsResponse.availability == "sold")
                          ? Container(
                              height: 40,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                shape: BoxShape.rectangle,
                                color: colorSecondary,
                                gradient: RadialGradient(
                                  colors: [
                                    colorWhite,
                                    colorSecondary,
                                    colorSecondary,
                                    colorSecondary,
                                  ],
                                  center: Alignment(0.85, -0.6),
                                  radius: 0.2,
                                  tileMode: TileMode.clamp,
                                  stops: [0.3, 0.5, 0.6, 0.7],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'SOLD OUT',
                                  maxLines: 2,
                                  style: TextStyle(
                                    height: 1.4,
                                    color: colorWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.0,
                                  ),
                                ),
                              ),
                            )
                          : Container()
                      // : CircleButton(
                      //     onTap: null,
                      //     iconData: Icons.favorite,
                      //     iconSize: 20,
                      //     color: Colors.grey,
                      //     backgrounColor: Colors.white,
                      //     padding: 4,
                      //   ),
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
