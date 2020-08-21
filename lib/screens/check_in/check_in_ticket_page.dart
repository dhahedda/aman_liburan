import 'package:flutter/material.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class CheckInTicketPage extends StatefulWidget {
  const CheckInTicketPage({Key key}) : super(key: key);

  @override
  _CheckInTicketPageState createState() => _CheckInTicketPageState();
}

class _CheckInTicketPageState extends State<CheckInTicketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 24.0, right: 24.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Terima Kasih',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Theme.Colors.turqoiseNormal,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    'Berikut ini adalah Kode Unik pengunjung dengan data sebagai berikut:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      // color: Theme.Colors.turqoiseNormal,
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Nama Pengunjung: Ikan Arapaima Gigas\nDomisili: Bandung\nJumlah Pengunjung: 5 orang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // fontSize: 24.0,
                      // color: Theme.Colors.turqoiseNormal,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 56.0),
                  Text(
                    'KODE UNIK',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // fontSize: 24.0,
                      // color: Theme.Colors.turqoiseNormal,
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    'UX007',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.0,
                      // color: Theme.Colors.turqoiseNormal,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  // SizedBox(height: 24.0),
                  Text(
                    'Mohon menunjukkan kode unik saat keluar dari objek wisata.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // fontSize: 24.0,
                      // color: Theme.Colors.turqoiseNormal,
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Image.asset("assets/images/illustrations/marginalia-650 1.png"),
          SizedBox(height: 4.0),
        ],
      ),
    );
  }
}
