import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aman_liburan/models/login/login_response.dart';

Future<Album> createAlbum(String title) async {
  final http.Response response = await http.post(
    'https://jsonplaceholder.typicode.com/albums',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

Future<LoginResponse> login(String email, String password) async {
  final http.Response response = await http.post(
    'https://rails-api.2gaijin.com/sign_in',
    headers: <String, String>{
      'Accept': '*/*',
      'Content-type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      "user": {"email": email, "password": password}
    }),
  );

  print(response.body.toString());
  print(response.statusCode.toString());
  // print(LoginResponse.fromJson(json.decode(response.body)).status);
  // print(LoginResponse.fromJson(json.decode(response.body)).message);

  if (response.statusCode == 200) {
    return LoginResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to login.');
  }
}

class Album {
  final int id;
  final String title;

  Album({this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _emailController = TextEditingController(text: 'dummytest@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: 'AppDevDummy2020');
  Future<LoginResponse> _futureLoginResponse;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureLoginResponse == null)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: 'Enter Email'),
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(hintText: 'Enter Password'),
                    ),
                    RaisedButton(
                      child: Text('Create Data'),
                      onPressed: () {
                        setState(() {
                          _futureLoginResponse = login(_emailController.text, _passwordController.text);
                        });
                      },
                    ),
                  ],
                )
              : FutureBuilder<LoginResponse>(
                  future: _futureLoginResponse,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data.message);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return CircularProgressIndicator();
                  },
                ),
        ),
      ),
    );
  }
}
