import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class OfficerHomePage extends StatefulWidget {
  const OfficerHomePage({Key key}) : super(key: key);

  @override
  _OfficerHomePageState createState() => _OfficerHomePageState();
}

class _OfficerHomePageState extends State<OfficerHomePage> {
  Widget _buildHeader() {
    return Stack(
      children: <Widget>[
        Container(
          color: Theme.Colors.turqoiseNormal,
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/svg/Bg-Square.svg',
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Selamat Datang,',
                style: TextStyle(
                  // fontSize: 18.0,
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                'Abang Parkir',
                style: TextStyle(
                  fontSize: 22.0,
                  // color: Theme.Colors.turqoiseNormal,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Objek Wisata Curug Pengantin',
                style: TextStyle(
                  fontSize: 28.0,
                  // color: Theme.Colors.turqoiseNormal,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 24.0),
              RichText(
                text: TextSpan(
                  text: 'Sudah ada ',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                  children: <TextSpan>[
                    TextSpan(text: '100 orang ', style: TextStyle(color: Colors.white)),
                    TextSpan(text: 'di tempat wisata saat ini.'),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Daftar Pengunjung',
                style: TextStyle(
                  fontSize: 18.0,
                  // color: Theme.Colors.turqoiseNormal,
                  // fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                'Rabu, 19 Agustus 2020 15.30',
                style: TextStyle(
                  // fontSize: 24.0,
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 16.0,
          right: 16.0,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: SizedBox(
                // width: 64.0,
                // height: 64.0,
                child: Image.asset(
                  'assets/images/Ellipse 2.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            radius: 30.0,
          ),
        )
      ],
    );
  }

  Widget _buildTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Objek Wisata Curug Pengantin',
            style: TextStyle(
              // fontSize: 24.0,
              // color: Colors.white,
              // fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lee Donghae',
                      style: TextStyle(
                        fontSize: 18.0,
                        // color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      'Suhu tubuh: 36,5 °C',
                      style: TextStyle(
                        // fontSize: 24.0,
                        color: Theme.Colors.turqoiseNormal,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Pengunjung: 5 orang',
                      style: TextStyle(
                        // fontSize: 24.0,
                        color: Theme.Colors.grey3,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Banyuwangi Utara',
                            style: TextStyle(
                              // fontSize: 24.0,
                              // color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'IN',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            '08:30',
                            style: TextStyle(
                              // fontSize: 24.0,
                              color: Theme.Colors.grey3,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
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
          Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          padding: const EdgeInsets.only(bottom: 72.0),
          physics: BouncingScrollPhysics(),
      children: [
        _buildHeader(),
        _buildTile(),
        _buildTile(),
        _buildTile(),
      ],
    ));
  }
}
