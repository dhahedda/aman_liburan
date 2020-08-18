import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullImage extends StatelessWidget {
  final String url;

  FullImage({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FullImageScreen(url: url),
          Positioned(
            top: 8.0,
            left: 8.0,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FullImageScreen extends StatefulWidget {
  final String url;

  FullImageScreen({Key key, @required this.url}) : super(key: key);

  @override
  State createState() => FullImageScreenState(url: url);
}

class FullImageScreenState extends State<FullImageScreen> {
  final String url;

  FullImageScreenState({Key key, @required this.url});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: PhotoView(imageProvider: NetworkImage(url)));
  }
}
