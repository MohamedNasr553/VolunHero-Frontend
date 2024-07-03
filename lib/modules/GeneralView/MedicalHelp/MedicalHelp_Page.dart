import 'package:flutter/material.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stroke_text/stroke_text.dart';

import '../GetSupport/Support_Page.dart';

class MedicalHelp extends StatelessWidget {
  MedicalHelp({super.key});

  List<Map<String, dynamic>> contacts = [];

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:SvgPicture.asset(
            'assets/images/arrowLeft.svg',
          ),
          color: HexColor("858888"),
          onPressed:(){
            navigateToPage(context, const GetSupport());
          },
        ),
        title:  StrokeText(
         text: "Medical",
          strokeColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
            color: HexColor("296E6F")
          ),
        ),
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: ListView.separated(
          //     physics: const BouncingScrollPhysics(),
          //     itemBuilder: (context, index) => buildContactItem(index, context),
          //     separatorBuilder: (context, index) => Padding(
          //       padding: const EdgeInsetsDirectional.only(start: 10.0),
          //       child: Container(
          //         width: double.infinity,
          //         height: 0.1,
          //         color: Colors.white,
          //       ),
          //     ),
          //     itemCount: contacts.length,
          //   ),
          // ),
        ],
      ),
    );
  }
}
