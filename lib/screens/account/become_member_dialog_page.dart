import 'package:flutter/material.dart';
import 'package:aman_liburan/models/response/global_response.dart';
import 'package:aman_liburan/models/subscription_model.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';

class BecomeMemberDialogPage extends StatefulWidget {
  final GlobalResponse globalResponseParam;
  final VoidCallback onSubmitSubscription;
  final Function(SubscriptionModel) onStateSubscriptionChange;

  BecomeMemberDialogPage({
    Key key,
    this.globalResponseParam,
    this.onSubmitSubscription,
    this.onStateSubscriptionChange,
  }) : super(key: key);

  @override
  _BecomeMemberDialogPageState createState() => _BecomeMemberDialogPageState(
        globalResponseParam,
        onSubmitSubscription,
        onStateSubscriptionChange,
      );
}

class _BecomeMemberDialogPageState extends State<BecomeMemberDialogPage> {
  List<SubscriptionModel> dataSubscription = List<SubscriptionModel>();

  final GlobalResponse globalResponseParam;
  final VoidCallback onSubmitSubscription;
  final Function(SubscriptionModel) onStateSubscriptionChange;

  _BecomeMemberDialogPageState(
    this.globalResponseParam,
    this.onSubmitSubscription,
    this.onStateSubscriptionChange,
  );

  @override
  void initState() {
    super.initState();
    dataSubscription.add(SubscriptionModel(
        title: "1 month", price: "100", discount: "", isSelected: false));
    dataSubscription.add(SubscriptionModel(
        title: "3 month", price: "300", discount: "", isSelected: false));
    dataSubscription.add(SubscriptionModel(
        title: "5 month", price: "500", discount: "", isSelected: false));
    dataSubscription.add(SubscriptionModel(
        title: "7 month", price: "700", discount: "", isSelected: false));
    dataSubscription.add(SubscriptionModel(
        title: "12 month", price: "1200", discount: "", isSelected: true));
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        color: Color(0xFF737373),
        height: SizeConfig.getHeight(context),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                right: 8,
                top: 8,
                child: IconButton(
                  icon: Icon(Icons.close, color: colorDarkBackground),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        width: 170,
                        fit: BoxFit.fill,
                        image:
                            AssetImage('assets/images/choose_subcription.png'),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        width: 250,
                        child: Text(
                          "Choose a subscription plan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 220,
                        child: Text(
                          "...and start selling your worthy-unused items today!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colorDarkBackground,
                            letterSpacing: 1,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Nunito",
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorGreyGaijin,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0),
                            bottomLeft: const Radius.circular(10.0),
                            bottomRight: const Radius.circular(10.0),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              splashColor: Colors.blueAccent,
                              onTap: () {
                                setState(() {
                                  dataSubscription.forEach(
                                    (element) => element.isSelected = false,
                                  );
                                  dataSubscription[0].isSelected = true;
                                  onStateSubscriptionChange(dataSubscription[0]);
                                });
                              },
                              child: SubscriptionItem(dataSubscription[0]),
                            ),
                            InkWell(
                              splashColor: Colors.blueAccent,
                              onTap: () {
                                setState(() {
                                  dataSubscription.forEach(
                                    (element) => element.isSelected = false,
                                  );
                                  dataSubscription[1].isSelected = true;
                                  onStateSubscriptionChange(dataSubscription[1]);
                                });
                              },
                              child: SubscriptionItem(dataSubscription[1]),
                            ),
                            InkWell(
                              splashColor: Colors.blueAccent,
                              onTap: () {
                                setState(() {
                                  dataSubscription.forEach(
                                    (element) => element.isSelected = false,
                                  );
                                  dataSubscription[2].isSelected = true;
                                  onStateSubscriptionChange(dataSubscription[2]);
                                });
                              },
                              child: SubscriptionItem(dataSubscription[2]),
                            ),
                            InkWell(
                              splashColor: Colors.blueAccent,
                              onTap: () {
                                setState(() {
                                  dataSubscription.forEach(
                                    (element) => element.isSelected = false,
                                  );
                                  dataSubscription[3].isSelected = true;
                                  onStateSubscriptionChange(dataSubscription[3]);
                                });
                              },
                              child: SubscriptionItem(dataSubscription[3]),
                            ),
                            InkWell(
                              splashColor: Colors.blueAccent,
                              onTap: () {
                                setState(() {
                                  dataSubscription.forEach(
                                    (element) => element.isSelected = false,
                                  );
                                  dataSubscription[4].isSelected = true;
                                  onStateSubscriptionChange(dataSubscription[4]);
                                });
                              },
                              child: SubscriptionItem(dataSubscription[4]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: onSubmitSubscription,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  elevation: 3.0,
                                  onPressed: onSubmitSubscription,
                                  padding: EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  color: colorPrimary,
                                  child: Text(
                                    "Subscribe, and start selling",
                                    style: TextStyle(
                                      height: 1.4,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionItem extends StatelessWidget {
  final SubscriptionModel _item;
  SubscriptionItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: _item.isSelected ? colorSecondary : Colors.transparent,
        border: Border.all(
          width: 2,
          color: _item.isSelected ? colorSecondary : Colors.transparent,
        ),
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                height: 30.0,
                width: 30.0,
                child: _item.isSelected
                    ? Icon(
                        Icons.check,
                        color: colorSecondary,
                        size: 20,
                      )
                    : Container(),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 2,
                    color: colorSecondary,
                  ),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(360.0)),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.only(left: 8.0),
              child: Text(
                _item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _item.isSelected ? Colors.white : colorDarkBackground,
                  letterSpacing: 1,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Nunito",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "¥" + _item.price,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color:
                          _item.isSelected ? Colors.white : colorDarkBackground,
                      letterSpacing: 1,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: "Nunito",
                    ),
                  ),
                  Text(
                    "Total",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color:
                          _item.isSelected ? Colors.white : colorDarkBackground,
                      letterSpacing: 1,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Nunito",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: (_item.discount == "")
                ? Container()
                : Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: _item.isSelected
                          ? Text(
                              _item.discount,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _item.isSelected
                                    ? Colors.white
                                    : colorDarkBackground,
                                letterSpacing: 1,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Nunito",
                              ),
                            )
                          : Text(
                              _item.discount,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colorDarkBackground,
                                letterSpacing: 1,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Nunito",
                              ),
                            ),
                      decoration: BoxDecoration(
                        color: _item.isSelected
                            ? colorPrimary
                            : colorSoftBlueBold.withOpacity(0.6),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(10.0)),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
