import 'package:flutter/material.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class CheckInPage extends StatefulWidget {
  const CheckInPage({Key key}) : super(key: key);

  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _domicileController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  String _sex;

  @override
  void initState() {
    super.initState();
    _sex = 'Laki-laki';
  }

  @override
  void dispose() {
    _nameController.dispose();
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
                    'Check In Pengunjung',
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
              child: Image.asset("assets/images/illustrations/marginalia-uploading.png"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioTile(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Radio(
            value: value,
            activeColor: Theme.Colors.turqoiseNormal,
            groupValue: _sex,
            onChanged: (value) {
              setState(() {
                _sex = value;
              });
            },
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _sex = value;
              });
            },
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: [
        _buildHeader(),
        _buildTextField(_nameController, 'Nama Lengkap Pengujung'),
        Row(
          children: [
            Expanded(child: _buildRadioTile('Laki-laki')),
            Expanded(child: _buildRadioTile('Perempuan')),
          ],
        ),
        _buildTextField(_ageController, 'Usia Pengguna'),
        _buildTextField(_domicileController, 'Domisili'),
        _buildTextField(_temperatureController, 'Suhu Tubuh'),
      ],
    );
  }
}
