import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:aman_liburan/models/carousel_model.dart';
import 'package:carousel_slider/carousel_slider.dart';


class AddProductFullScreenCarouselPage extends StatefulWidget {
  final List<CarouselModel> listItem;
  final int carouselPosition;

  const AddProductFullScreenCarouselPage({Key key, this.listItem, this.carouselPosition}) : super(key: key);

  @override
  _AddProductFullScreenCarouselPageState createState() => _AddProductFullScreenCarouselPageState(listItem, carouselPosition);
}

class _AddProductFullScreenCarouselPageState extends State<AddProductFullScreenCarouselPage> {
  final List<CarouselModel> listItem;
  int carouselPosition;

  _AddProductFullScreenCarouselPageState(this.listItem, this.carouselPosition);

  CarouselSlider getFullScreenCarousel(BuildContext mediaContext, List<CarouselModel> listItem) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        autoPlay: false,
        reverse: false,
        enableInfiniteScroll: false,
        viewportFraction: 1.0,
        aspectRatio: MediaQuery.of(mediaContext).size.aspectRatio,
        scrollDirection: Axis.horizontal,
        initialPage: carouselPosition,
        onPageChanged: (index, reason){
          setState(() {
            carouselPosition = index;
          });
        },
      ),
      itemCount: listItem.length,
      itemBuilder: (BuildContext context, int itemIndex) =>
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
            child: Image.network(
              listItem.elementAt(itemIndex).imageUrl,
              fit: BoxFit.cover,
              width: 1000.0,
            ),
          ),
        )
    );
  }

  List<T> mapingCarousel<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Widget _buildCarouselData(BuildContext context, List<CarouselModel> listItem) {
    return Container(
      color: Colors.white10,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: getFullScreenCarousel(context, listItem)
          ),
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
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: carouselPosition == index ? Colors.green : Colors.white70,
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: EdgeInsets.only(left: 4),
          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              print('Click Close');

              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: _buildCarouselData(context, listItem),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 60.0,
        child: BottomAppBar(
          elevation: 8.0,
          shape: CircularNotchedRectangle(),
          color: Colors.black,
          child: Container(
            height: 100,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: SizedBox.expand(
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: (){
                    print("Button Add Favorite Pressed");
                  },
                  padding: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: Colors.green[600],
                  child: Text(
                    'Add Image',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}