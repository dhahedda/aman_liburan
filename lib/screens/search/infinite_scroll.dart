import 'dart:async';

import 'package:flutter/material.dart';

class InfiniteScroll extends StatefulWidget {
  @override
  _InfiniteScrollState createState() => new _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScroll> {
  List<String> _data = [];
  Future<List<String>> _future;
  int _currentPage = 0, _limit = 10;
  ScrollController _controller =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  ///constructor
  _InfiniteScrollState() {
    _controller.addListener(() {
      var isEnd = _controller.offset == _controller.position.maxScrollExtent;
      if (isEnd)
        setState(() {
          _future = loadData();
        });
    });
    _future = loadData();
  }

  ///Mimic load data
  Future<List<String>> loadData() async {
    for (var i = _currentPage; i < _currentPage + _limit; i++) {
      _data.add('Data item - $i');
    }
    _currentPage += _limit;
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Infinite Scrolling'),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<String> loaded = snapshot.data;
            return ListView.builder(
              itemCount: loaded.length,
              controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(loaded[index]),
                  onTap: () {},
                );
              },
            );
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }
}