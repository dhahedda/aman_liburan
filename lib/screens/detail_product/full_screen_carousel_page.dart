import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:aman_liburan/models/carousel_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/utilities/widgets/horizontal_line.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class FullScreenCarouselPage extends StatefulWidget {
  final List<CarouselModel> listItem;
  final GlobalResponse response;
  final int carouselPosition;

  const FullScreenCarouselPage(
      {Key key, this.listItem, this.carouselPosition, this.response})
      : super(key: key);

  @override
  _FullScreenCarouselPageState createState() =>
      _FullScreenCarouselPageState(listItem, carouselPosition, response);
}

class _FullScreenCarouselPageState extends State<FullScreenCarouselPage> {
  final List<CarouselModel> listItem;
  final GlobalResponse response;
  int carouselPosition;

  _FullScreenCarouselPageState(
      this.listItem, this.carouselPosition, this.response);

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

  CarouselSlider getFullScreenCarousel(
      BuildContext mediaContext, List<CarouselModel> listItem) {
    return CarouselSlider.builder(
        options: CarouselOptions(
          autoPlay: false,
          reverse: false,
          enableInfiniteScroll: false,
          viewportFraction: 1.0,
          aspectRatio: MediaQuery.of(mediaContext).size.aspectRatio,
          scrollDirection: Axis.horizontal,
          initialPage: carouselPosition,
          onPageChanged: (index, reason) {
            setState(() {
              carouselPosition = index;
            });
          },
        ),
        itemCount: listItem.length,
        itemBuilder: (BuildContext context, int itemIndex) => Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
                child: Image.network(
                  listItem.elementAt(itemIndex).imageUrl,
                  fit: BoxFit.cover,
                  width: 1000.0,
                ),
              ),
            ));
  }

  List<T> mapingCarousel<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Widget _buildCarouselData(
      BuildContext context, List<CarouselModel> listItem) {
    return Container(
      color: Colors.white10,
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: getFullScreenCarousel(context, listItem)),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: mapingCarousel<Widget>(listItem, (index, url) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: carouselPosition == index
                        ? Theme.Colors.turqoiseNormal
                        : Colors.white24,
                  ),
                );
              }),
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(const Radius.circular(30.0)),
                ),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    print('Click Close');

                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCarouselData(context, listItem),
    );
  }
}
