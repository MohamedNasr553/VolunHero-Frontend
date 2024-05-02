import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../shared/components/components.dart';

class DetailedPost extends StatelessWidget {
  DetailedPost({super.key});
  List<Map<String, dynamic>> comments = [];

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    for (int i = 0; i <= 10; i++) {
      comments.add({
        'image':"assets/images/OrganizationLogo.png",
        "name":"User Name",
        "text":"this is a text for the comment"
      });
    }
    return Scaffold(
       appBar: AppBar(
         leading:IconButton(
       icon:SvgPicture.asset(
       'assets/images/arrowLeft.svg',
       ),
      color: HexColor("858888"),
      onPressed:(){},
    ),
         title:Row(
           children: [
             CircleAvatar(
               radius: 20,
               child: Image.asset("assets/images/OrganizationLogo.png"),
             ),
             SizedBox(width: screenWidth/20,),
             Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                     "User Name",
                     style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontFamily: "Roboto"),
                 ),
                 Text(
                   "2h",
                   style: TextStyle(fontSize: 12,fontFamily: "Roboto",fontWeight: FontWeight.w400),
                 ),
               ],
             )
           ],
         ),
       ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 1,color: HexColor("9B9B9B"),),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10.0,
                      spreadRadius: -5.0,
                      offset: Offset(10.0, 10.0), // Right and bottom shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            backgroundImage:
                            AssetImage("assets/images/OrganizationLogo.png"),
                          ),
                          SizedBox(width: screenWidth/50,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "User Name",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black
        
                                ),
                              ),
                              SizedBox(height: 0.5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "2h",
                                    style: TextStyle(
                                        color: HexColor("B8B9BA"),
                                        fontSize: 10
                                    ),
                                  ),
                                  SizedBox(width: 2,),
                                  SvgPicture.asset(
                                    'assets/images/earthIcon.svg',
                                  ),
                                ],
                              )
                            ],
                          ),
                          Spacer(),
                          SvgPicture.asset(
                            'assets/images/postSettings.svg',
                          ),
                          IconButton(
                            onPressed: (){},
                            icon: SvgPicture.asset(
                              'assets/images/closePost.svg',
                            ),
                          ),
        
                        ],
                      ),
                      SizedBox(height: 1,),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Join us for voluntering",
                              maxLines:  5,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Robot",
                                fontSize: 12,
                              ),
                            ),
                            Image.asset(
                              "assets/images/Rectangle 4160.png",
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 1,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 4),
                        child: Row(
                          children: [
                            Icon(Icons.add_reaction),
                            SizedBox(width: screenWidth/100,),
                            Text(
                              "Ahmed and 5 others",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 12,
                                  color: HexColor("575757")
                              ),
                            ),
                            Spacer(),
                            Text(
                              "123 comments",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 12,
                                  color: HexColor("575757")
                              ),
                            ),
                          ],),
                      ),
                      SizedBox(height: 1, ),
                      Container(height: 1,color: Colors.grey[200],),
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                postSubComponent("assets/images/like.svg","Like"),
                                Spacer(),
                                postSubComponent("assets/images/comment.svg","Comment"),
                                Spacer(),
                                postSubComponent("assets/images/share.svg","Share"),
                              ],
                            )
        
                        ),
                      )
        
                    ],
                  ),
                ),
              ),
            ),
            Container(height: 1,color: HexColor("9B9B9B"),),
            ListView.separated(
              physics:  NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => buildCommentItem(index, context),
              separatorBuilder: (context, index) => Padding(
                padding:  EdgeInsetsDirectional.symmetric(horizontal: 8),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              itemCount: comments.length ,
            ),
          ],
        ),
      ),
    );
  }
  Widget buildCommentItem(int index,context){
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            child: Image.asset(comments[index]["image"]),
          ),
          SizedBox(width: screenWidth/40,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0,right: 14.0,top: 10.0,bottom: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comments[index]["name"],
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontFamily: "Roboto"),
                  ),
                  Text(
                    comments[index]["text"],
                    style: TextStyle(fontSize: 14,fontFamily: "Roboto"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget postSubComponent(String assetIcon, String action){
    return InkWell(
      onTap: (){
        showToast(text: "$action", state: ToastStates.SUCCESS);
      },
      child: Container(
        child: Row(
          children: [
            SvgPicture.asset(assetIcon),
            SizedBox(width: 1,),
            Text(
              action,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Roboto",
                  color: HexColor("575757")
              ),
            )
          ],
        ),
      ),
    );
  }
}
