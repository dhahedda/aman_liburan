import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aman_liburan/utilities/widgets/custom_range_slider_thumb_circle.dart';
import 'package:aman_liburan/utilities/widgets/custom_range_slider_value_indicator_circle.dart';
import 'custom_slider_thumb_circle.dart';
import 'package:aman_liburan/utilities/styles/theme.dart' as Theme;

class SliderWidget extends StatefulWidget {
  final double sliderHeight;
  final int min;
  final int max;
  final bool fullWidth;
  final RangeValues values;
  final Function callback;

  SliderWidget({
    this.sliderHeight = 48,
    this.min = 100,
    this.max = 1000000,
    this.fullWidth = false,
    @required this.values,
    @required this.callback,
  });

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  // double _value = 0;
  var _rangeValues = RangeValues(100, 1000000);

  @override
  Widget build(BuildContext context) {
    final thousandsFormatter = NumberFormat('#,###.##', 'ja_JA');
    double paddingFactor = .2;

    if (this.widget.fullWidth) paddingFactor = .3;

    return Container(
      width: this.widget.fullWidth ? double.infinity : (this.widget.sliderHeight) * 5.5,
      height: (this.widget.sliderHeight),
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.all(
          Radius.circular((this.widget.sliderHeight * .3)),
        ),
        gradient: LinearGradient(
          colors: [
            // const Color(0xFF00c6ff),
            // const Color(0xFF0072ff),
            // const Color(0xFFfeb672),
            // const Color(0xFFfe7d02),
            Theme.Colors.turqoiseLight,
            Theme.Colors.turqoiseDark,
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 1.00),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(this.widget.sliderHeight * paddingFactor, 2, this.widget.sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            // Text(
            //   '${this.widget.min}',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: this.widget.sliderHeight * .3,
            //     fontWeight: FontWeight.w700,
            //     color: Colors.white,
            //   ),
            // ),
            // SizedBox(
            //   width: this.widget.sliderHeight * .1,
            // ),
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white.withOpacity(1),
                    inactiveTrackColor: Colors.white.withOpacity(.5),

                    trackHeight: 4.0,
                    // thumbShape: CustomSliderThumbRect(
                    //   thumbRadius: this.widget.sliderHeight * .4,
                    //   min: this.widget.min,
                    //   max: this.widget.max,
                    //   thumbHeight: 50.0,
                    // ),
                    thumbShape: CustomSliderThumbCircle(
                      thumbRadius: this.widget.sliderHeight * .4,
                      min: this.widget.min,
                      max: this.widget.max,
                    ),
                    rangeThumbShape: CustomRangeSliderThumbCircle(
                      thumbRadius: this.widget.sliderHeight * .4,
                      min: this.widget.min,
                      max: this.widget.max,
                    ),
                    rangeValueIndicatorShape: CustomRangeSliderValueIndicatorCircle(
                      thumbRadius: this.widget.sliderHeight * .4,
                      min: this.widget.min,
                      max: this.widget.max,
                    ),
                    overlayColor: Colors.white.withOpacity(.4),
                    //valueIndicatorColor: Colors.white,
                    activeTickMarkColor: Colors.transparent,
                    inactiveTickMarkColor: Colors.red.withOpacity(.7),
                  ),
                  // child: Slider(
                  //     value: _value,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         _value = value;
                  //       });
                  //     }),
                  // child: FlutterSlider(
                  //   values: [this.widget.values.start, this.widget.values.end],
                  //   min: 0,
                  //   max: 1000000,
                  //   step: FlutterSliderStep(
                  //       step: 1, // default
                  //       isPercentRange: true, // ranges are percents, 0% to 20% and so on... . default is true
                  //       rangeList: [
                  //         FlutterSliderRangeStep(from: 0, to: 20, step: 10000),
                  //         FlutterSliderRangeStep(from: 20, to: 100, step: 200000),
                  //       ]),
                  // ),
                  child: RangeSlider(
                      min: 100,
                      max: 1000000,
                      divisions: 1000,
                      // values: _rangeValues,
                      values: this.widget.values,
                      labels: RangeLabels(
                        '¥${thousandsFormatter.format(_rangeValues.start)}',
                        '¥${thousandsFormatter.format(_rangeValues.end)}',
                      ),
                      onChanged: (values) {
                        setState(() {
                          // this.widget.values = values;
                          this.widget.callback(values);
                        });
                        // print(values.start);
                      }),
                ),
              ),
            ),
            // SizedBox(
            //   width: this.widget.sliderHeight * .1,
            // ),
            // Text(
            //   '${this.widget.max}',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: this.widget.sliderHeight * .3,
            //     fontWeight: FontWeight.w700,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
