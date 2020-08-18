import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:aman_liburan/models/param/search_param.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/slider_widget.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class SearchFilterPage extends StatefulWidget {
  final int priceMin;
  final int priceMax;
  final String category;
  final String status;

  SearchFilterPage({
    Key key,
    this.priceMin,
    this.priceMax,
    this.category,
    this.status,
  }) : super(key: key);

  @override
  _SearchFilterPageState createState() => _SearchFilterPageState();
}

class _SearchFilterPageState extends State<SearchFilterPage> {
  final _maxPrice = 1000000.0;

  final thousandsFormatter = NumberFormat('#,###.##', 'ja_JA');
  RangeValues _rangeValues = RangeValues(100, 1000000);
  final _priceMinController = TextEditingController(text: '100');
  final _priceMaxController = TextEditingController(text: '1,000,000');
  int _categoriesCurrentIndex = -1;
  int _statusCurrentIndex = -1;

  List<String> _categories = [
    'Zona Hijau',
    'Zona Kuning',
    'Zona Merah',
  ];

  List<String> _status = [
    '< 500 orang',
    '500 - 1000 orang',
    '1000 - 2000 orang',
    '> 2000 orang',
  ];

  void callback(RangeValues values) {
    setState(() {
      _rangeValues = values;
      _setPriceMin(_rangeValues.start);
      _setPriceMax(_rangeValues.end);
      // _priceMinController.text = thousandsFormatter.format(_rangeValues.start - _rangeValues.start % 100);
      // _priceMaxController.text = thousandsFormatter.format(_rangeValues.end - _rangeValues.end % 100);
    });
  }

  int _getPriceMin() => int.parse(_priceMinController.text.replaceAll(',', ''));

  int _getPriceMax() => int.parse(_priceMaxController.text.replaceAll(',', ''));

  void _setPriceMin(double priceMin) {
    setState(() {
      _priceMinController.text = thousandsFormatter.format(priceMin - priceMin % 100);
      _rangeValues = RangeValues(priceMin, _rangeValues.end);
    });
  }

  void _setPriceMax(double priceMax) {
    setState(() {
      _priceMaxController.text = thousandsFormatter.format(priceMax - priceMax % 100);
      _rangeValues = RangeValues(_rangeValues.start, priceMax);
    });
  }

  @override
  void dispose() {
    _priceMinController.dispose();
    _priceMaxController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.priceMin != null) {
        _setPriceMin((widget.priceMin.toDouble()));
      }
      if (widget.priceMax != null) {
        _setPriceMax((widget.priceMax.toDouble()));
      }
      if (widget.category != null) {
        for (int i = 0; i < _categories.length; i++) {
          if (widget.category == _categories[i]) {
            _categoriesCurrentIndex = i;
          }
        }
      }
      if (widget.status != null) {
        for (int i = 0; i < _status.length; i++) {
          if (widget.status == _status[i].toLowerCase()) {
            _statusCurrentIndex = i;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildPriceRangeInput() {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Kapasitas Min Orang', style: TextStyle(fontFamily: 'WorkSansSemi')),
              Text('Kapasitas Maks Orang', style: TextStyle(fontFamily: 'WorkSansSemi')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _priceMinController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontFamily: 'WorkSansSemiBold',
                    fontSize: 16.0,
                    color: Theme.Colors.turqoiseNormal,
                  ),
                  inputFormatters: [
                    ThousandsFormatter(formatter: NumberFormat.decimalPattern('ja_JA')),
                    LengthLimitingTextInputFormatter(9),
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email Address',
                    hintStyle: TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                  ),
                  onSubmitted: (value) {
                    double doubleValue = double.parse(value.replaceAll(',', ''));
                    double correctedValue = doubleValue;
                    if (doubleValue > _maxPrice) {
                      correctedValue = _maxPrice;
                    }
                    callback(RangeValues(correctedValue, _rangeValues.end));
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _priceMaxController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontFamily: 'WorkSansSemiBold',
                    fontSize: 16.0,
                    color: Theme.Colors.turqoiseNormal,
                  ),
                  inputFormatters: [
                    ThousandsFormatter(formatter: NumberFormat.decimalPattern('ja_JA')),
                    LengthLimitingTextInputFormatter(9),
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email Address',
                    hintStyle: TextStyle(fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                  ),
                  onSubmitted: (value) {
                    double doubleValue = double.parse(value.replaceAll(',', ''));
                    double correctedValue = doubleValue;
                    if (doubleValue > _maxPrice) {
                      correctedValue = _maxPrice;
                    }
                    if (correctedValue < _rangeValues.start) {
                      callback(RangeValues(correctedValue, correctedValue));
                    } else {
                      callback(RangeValues(_rangeValues.start, correctedValue));
                    }
                  },
                ),
              ),
            ],
          ),
          SliderWidget(
            fullWidth: true,
            values: _rangeValues,
            callback: this.callback,
          ),
        ],
      );
    }

    Widget _buildCategoryInput() {
      Widget _buildCategoryChip(int index) {
        return Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: ChoiceChip(
            label: Text(
              _categories[index],
              style: TextStyle(
                color: (_categoriesCurrentIndex == index) ? Colors.white : Theme.Colors.turqoiseNormal,
                letterSpacing: 1,
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
              maxLines: 2,
            ),
            selected: _categoriesCurrentIndex == index,
            selectedColor: Theme.Colors.turqoiseNormal,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                width: 1,
                color: Theme.Colors.turqoiseNormal,
              ),
            ),
            onSelected: (bool selected) {
              setState(() {
                _categoriesCurrentIndex = selected ? index : -1;
              });
            },
          ),
        );
      }

      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Berdasarkan Zona Wisata', style: TextStyle(fontFamily: 'WorkSansSemi')),
              ],
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.87,
            child: Row(
            children: _categories.asMap().entries.map((entry) => _buildCategoryChip(entry.key)).toList().cast<Widget>(),
            ),
          ),
        ],
      );
    }

    Widget _buildAvailabilityInput() {
      Widget _buildCategoryChip(int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: ChoiceChip(
            label: Text(
              _status[index],
              style: TextStyle(
                color: (_statusCurrentIndex == index) ? Colors.white : Theme.Colors.turqoiseNormal,
                letterSpacing: 1,
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
              maxLines: 2,
            ),
            selected: _statusCurrentIndex == index,
            selectedColor: Theme.Colors.turqoiseNormal,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                width: 1,
                color: Theme.Colors.turqoiseNormal,
              ),
            ),
            onSelected: (bool selected) {
              setState(() {
                _statusCurrentIndex = selected ? index : -1;
              });
            },
          ),
        );
      }

      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Berdasarkan Kapasitas Tempat Wisata', style: TextStyle(fontFamily: 'WorkSansSemi')),
              ],
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.87,
            child: Wrap(
                children: _status.asMap().entries.map((entry) => _buildCategoryChip(entry.key)).toList().cast<Widget>(),
            ),
          ),
        ],
      );
    }

    Widget _buildApplyFilterButton() {
      return FractionallySizedBox(
        widthFactor: 0.9,
        child: ButtonTheme(
          minWidth: double.infinity,
          child: RaisedButton(
            elevation: 10.0,
            onPressed: () {
              Navigator.pop(
                  context,
                  SearchParam(
                    priceMin: _getPriceMin(),
                    priceMax: _getPriceMax(),
                    category: _categoriesCurrentIndex == -1 ? null : _categories[_categoriesCurrentIndex],
                    status: _statusCurrentIndex == -1 ? null : _status[_statusCurrentIndex].toLowerCase(),
                  ));
            },
            padding: const EdgeInsets.all(12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: Theme.Colors.turqoiseNormal,
            child: Text(
              'Apply Filter',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildResetButton() {
      return FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Theme.Colors.turqoiseNormal.withOpacity(0.75),
                blurRadius: 7.5,
                offset: Offset(0, 2.0),
              ),
            ],
          ),
          child: ButtonTheme(
            minWidth: double.infinity,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _categoriesCurrentIndex = -1;
                  _statusCurrentIndex = -1;
                  callback(RangeValues(100, 1000000));
                });
              },
              padding: const EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Colors.white,
              child: Text(
                'Reset',
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
      );
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Filter', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close, color: colorGreyGaijin),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  _buildPriceRangeInput(),
                  _buildCategoryInput(),
                  _buildAvailabilityInput(),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                _buildApplyFilterButton(),
                SizedBox(height: 16.0),
                _buildResetButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
