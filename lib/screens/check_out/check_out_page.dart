import 'package:flutter/material.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'OBJEK WISATA CURUG PENGANTIN',
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                  Text(
                    'Check Out Pengunjung',
                    style: TextStyle(
                      letterSpacing: 1.0,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Image.asset("assets/images/illustrations/marginalia-669 1.png"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Theme.Colors.turqoiseNormal),
        fillColor: Colors.white,
        focusColor: Theme.Colors.turqoiseNormal,
        focusedBorder: UnderlineInputBorder(),
      ),
    );
  }

  Widget _buildProccessButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: ButtonTheme(
          minWidth: double.infinity,
          child: RaisedButton(
            elevation: 10.0,
            onPressed: () {},
            padding: const EdgeInsets.all(12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: Theme.Colors.turqoiseNormal,
            child: Text(
              'Proses Check Out',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Theme.Colors.turqoiseNormal,
                blurRadius: 7.5,
                offset: Offset(0, 2.0),
              ),
            ],
          ),
          child: ButtonTheme(
            minWidth: double.infinity,
            child: FlatButton(
              onPressed: () {},
              padding: const EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Colors.white,
              child: Text(
                'Cari Data',
                style: TextStyle(
                  color: Theme.Colors.turqoiseNormal,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0, bottom: 100.0),
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          _buildHeader(),
          _buildTextField(_searchController, 'Masukkan Kode Unik atau Nama Pengunjung'),
          _buildSearchButton(),
          Card(
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lee Donghae',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              'Suhu tubuh: 36,5 °C',
                              style: TextStyle(
                                color: Theme.Colors.turqoiseNormal,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Pengunjung: 5 orang',
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'UX007',
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Asal'),
                              Text(
                                'Banyuwangi Utara',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Usia'),
                              Text(
                                '25 Tahun',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Check In'),
                            Text(
                              '8:00',
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Check Out'),
                            Text(
                              '8:00',
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _buildProccessButton(),
        ],
      ),
    );
  }
}
