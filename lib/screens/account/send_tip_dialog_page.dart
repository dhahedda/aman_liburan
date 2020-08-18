import 'package:flutter/material.dart';
import 'package:aman_liburan/models/response/notification/notification_response.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';
import 'package:aman_liburan/utilities/widgets/custom_image_button.dart';

class SendTipDialogPage extends StatefulWidget {
  final NotificationResponse notificationResponse;
  final VoidCallback onSubmitTrustCoin;
  final Function(bool) onIsGoldChange;

  SendTipDialogPage({Key key, this.notificationResponse, this.onSubmitTrustCoin, this.onIsGoldChange}) : super(key: key);

  @override
  _SendTipDialogPageState createState() => _SendTipDialogPageState(notificationResponse, onSubmitTrustCoin, onIsGoldChange);
}

class _SendTipDialogPageState extends State<SendTipDialogPage> {
  final NotificationResponse notificationResponse;
  final VoidCallback onSubmitTrustCoin;
  final Function(bool) onIsGoldChange;

  bool isGoldCoin = true;

  _SendTipDialogPageState(this.notificationResponse, this.onSubmitTrustCoin, this.onIsGoldChange);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16.0),
            _buildTrustCoinDetailProduct(notificationResponse),
            SizedBox(height: 16.0),
            Container(
              width: 200,
              child: Text(
                "How is transaction experience with ${notificationResponse.product.sellerName}?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageButton(
                  backgroundColor: colorSoftYellow,
                  assetImage: AssetImage('assets/images/gold_coin.png'),
                  active: (isGoldCoin) ? true : false,
                  text: "It was Great!!",
                  onTap: () {
                    setState(() {
                      isGoldCoin = true;
                      onIsGoldChange(isGoldCoin);
                    });
                  },
                ),
                SizedBox(width: 16.0),
                CustomImageButton(
                  backgroundColor: colorSoftDark,
                  assetImage: AssetImage('assets/images/silver_coin.png'),
                  active: (isGoldCoin) ? false : true,
                  text: "It was Ok!!",
                  onTap: () {
                    setState(() {
                      isGoldCoin = false;
                      onIsGoldChange(isGoldCoin);
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                elevation: 3.0,
                onPressed:onSubmitTrustCoin,
                padding: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: colorSecondary,
                child: Text(
                  "Send Trust Coin",
                  style: TextStyle(
                    height: 1.4,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustCoinDetailProduct(
      NotificationResponse notificationResponse) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: colorSoftDark,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 4.0,
                bottom: 4.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child:
                        (notificationResponse.notificationUser.avatarUrl == "")
                            ? Container(
                                width: 32,
                                height: 32.0,
                                decoration: BoxDecoration(
                                  color: colorDarkBackground,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : Container(
                                width: 32,
                                height: 32.0,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(notificationResponse
                                        .notificationUser.avatarUrl),
                                  ),
                                ),
                              ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    flex: 8,
                    child: Text(
                      notificationResponse.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Nunito",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: 60,
                    height: 60,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      fit: StackFit.expand,
                      children: [
                        Align(
                          alignment: Alignment(0.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            child: Image.network(
                              notificationResponse.product.imgUrl,
                              fit: BoxFit.cover,
                              width: 60.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        notificationResponse.product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: colorDarkBackground,
                          letterSpacing: 1,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Nunito",
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "¥ ${notificationResponse.product.price}",
                        style: TextStyle(
                          color: colorSecondary,
                          letterSpacing: 1,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Nunito",
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
    );
  }

}
