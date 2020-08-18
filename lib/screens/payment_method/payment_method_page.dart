import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aman_liburan/models/subscription_model.dart';
import 'package:aman_liburan/blocs/payment_method/payment_method_bloc.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/illustration_loading.dart';

class PaymentMethodPage extends StatefulWidget {
  final SubscriptionModel subscriptionModel;

  PaymentMethodPage({Key key, this.subscriptionModel}) : super(key: key);

  @override
  _PaymentMethodPageState createState() =>
      _PaymentMethodPageState(subscriptionModel);
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  final SubscriptionModel subscriptionModel;

  _PaymentMethodPageState(this.subscriptionModel);

  Widget _showError(String message) {
    return Container(
      width: SizeConfig.getWidth(context),
      height: SizeConfig.getHeight(context),
      child: Center(child: Text(message)),
    );
  }

  Widget _buildWidgetHeader(String title) {
    return Container(
      width: SizeConfig.getWidth(context),
      color: colorSoftBlue,
      padding: EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildCreditCardMethod() {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: colorSoftBlueBold.withOpacity(0.3),
            width: SizeConfig.getWidth(context),
            height: 1,
          ),
          Container(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Credit Card",
                        style: TextStyle(
                          color: colorDarkBackground,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "Pay with your own credit card",
                        style: TextStyle(
                          color: colorDarkBackground,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: colorSoftBlueBold.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: colorSoftBlueBold.withOpacity(0.6),
            width: SizeConfig.getWidth(context),
            height: 1,
          )
        ],
      ),
    );
  }

  Widget _buildBody(PaymentMethodState state) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorDarkBackground),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Pay With",
          style: TextStyle(
            color: colorDarkBackground,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWidgetHeader("Choose payment method"),
            _buildCreditCardMethod(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return PaymentMethodBloc()
          ..add(
            PaymentMethodInitialEvent(),
          );
      },
      child: BlocConsumer<PaymentMethodBloc, PaymentMethodState>(
        listener: (BuildContext context, PaymentMethodState state) async {},
        builder: (context, state) {
          if (state is PaymentLoading) {
            return IllustrationLoading();
          } else if (state is PaymentMethodResponseState) {
            return _buildBody(state);
          } else if (state is PaymentMethodError) {
            return _showError("Error => ${state.message}");
          }
          return IllustrationLoading();
        },
      ),
    );
  }
}
