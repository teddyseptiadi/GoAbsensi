import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../shared/common/colors.dart';
import '../../../shared/common/fonts.dart';
import '../../../shared/common/sizes.dart';
import 'check_in_screen.dart';

class CheckOutScreen extends StatelessWidget {
  static String routeName = '/check_out_screen';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: primaryColor,
            ),
            SafeArea(
              child: Stack(
                children: [
                  Container(
                    color: screenColor,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        _HeaderCheckOutComponent(),
                        SizedBox(
                          height: 24,
                        ),
                        _MethodCheckOutComponent(),
                        SizedBox(
                          height: 24,
                        ),
                        _ActivityCheckOutComponent(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCheckOutComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context),
      height: 88,
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 34,
              height: 34,
              child: RaisedButton(
                color: maroonColor,
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                padding: EdgeInsets.zero,
                splashColor: Colors.black.withOpacity(0.3),
                visualDensity: VisualDensity.comfortable,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: whiteColor,
                  size: 18,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Center(
            child: Text(
              "Absen Pulang",
              style: boldWhiteFont.copyWith(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _MethodCheckOutComponent extends StatefulWidget {
  @override
  __MethodCheckOutComponentState createState() => __MethodCheckOutComponentState();
}

class __MethodCheckOutComponentState extends State<_MethodCheckOutComponent> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: defaultMargin),
          child: Text(
            "Pilih Metode Absen",
            style: semiBlackFont.copyWith(fontSize: 14),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        if (isClicked) Padding(
          padding: const EdgeInsets.symmetric(vertical: 53),
          child: SpinKitFadingCircle(
            color: primaryColor,
            size: 70,
          ),
        )
        else Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MethodComponent(
              methodName: "One Click",
              iconPath: 'assets/images/one_click.png',
              onTap: () async {},
            ),
            SizedBox(
              width: defaultMargin
            ),
            MethodComponent(
              methodName: "Scan QR",
              iconPath: 'assets/images/scan_qr.png',
              onTap: () async {},
            ),
          ],
        ),
      ],
    );
  }
}

class _ActivityCheckOutComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: defaultMargin),
          child: Text(
            "Aktivitas Kehadiran Terkini",
            textAlign: TextAlign.left,
            style: semiBlackFont.copyWith(fontSize: 14),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: (5 * 74).toDouble(),
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xFFEEEEEE),
                width: 3,
                style: BorderStyle.solid,
              ),
              left: BorderSide(
                color: Color(0xFFEEEEEE),
                width: 3,
                style: BorderStyle.solid,
              ),
              right: BorderSide(
                color: Color(0xFFEEEEEE),
                width: 3,
                style: BorderStyle.solid,
              ),
            ),
          ),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (context, index) => _UserCheckOutComponent(
              userName: "abuzaio",
              absentTime: DateTime.now().millisecondsSinceEpoch,
              photoURL: "https://cdn.myanimelist.net/images/characters/9/335049.jpg",
            ),
          ),
        ),
      ],
    );
  }
}

class _UserCheckOutComponent extends StatelessWidget {
  final String userName;
  final int absentTime;
  final String photoURL;

  _UserCheckOutComponent({this.userName, this.absentTime, this.photoURL});
  
  @override
  Widget build(BuildContext context) {
    String time =  DateFormat('hh : mm : ss').format(DateTime.fromMillisecondsSinceEpoch(absentTime));

    return Container(
      width: deviceWidth(context),
      height: 74,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEBEBEF),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (photoURL == null) ClipOval(
            child: Image.asset(
              'assets/images/avatar.png',
              width: 46,
              height: 46,
              fit: BoxFit.cover,
            ),
          )
          else ClipOval(
            child: Image.network(
              photoURL,
              width: 46,
              height: 46,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return SpinKitFadingCircle(
                  color: primaryColor,
                );
              },
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName,
                style: semiBlackFont.copyWith(fontSize: 13),
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 42,
                    height: 14,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Center(
                      child: Text(
                        "Masuk",
                        style: boldWhiteFont.copyWith(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "$time WIB",
                    style: semiBlackFont.copyWith(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(
            flex: 1,
          ),
          Image.asset(
            'assets/images/entry.png',
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}