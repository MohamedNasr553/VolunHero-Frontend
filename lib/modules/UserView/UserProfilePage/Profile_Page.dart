import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../layout/VolunHeroUserLayout/layout.dart';
import '../../../shared/components/components.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  List<Map<String, dynamic>> posts = [];
  @override
  Widget build(BuildContext context) {
    String userName = "Mahmoud Nader";
    String userEmail = "mahnader222@gmail.com";
    String phoneNumber = "+201127264619";
    String university = "Faculty of computers and artificial intelligence Cairo University";
    String city = "Cairo";

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var _textEditingController = TextEditingController();


    for (int i = 1; i <= 5; i++) {
      if(i%2==0 ){
        posts.add({
          'photo': 'assets/images/logo.png', // Dummy image filename
          'name': 'User $i Name', // Dummy description
          'text': "Do you know of a shelter that accepts clothing donation or household applications? Your recommendations are much appreciated! ", // Calculate time ago
          'image': 'assets/images/Rectangle 4160.png',
          'duration' : '2h.',
          'mutual': "Anas Ahmed and 3 others",
          'comments': "$i comments"
        });
      }else{
        posts.add({
          'photo': 'assets/images/logo.png', // Dummy image filename
          'name': 'User $i Name', // Dummy description
          'text': "Do you know of a shelter that accepts clothing donation or household applications? Your recommendations are much appreciated! ", // Calculate time ago
          // 'image': 'assets/images/Rectangle 4160.png',
          'duration' : '2h.',
          'mutual': "Anas Ahmed and 3 others",
          'comments': "$i comments"
        });
      }
      if(i==3){
        posts.add({
          'photo': 'assets/images/logo.png', // Dummy image filename
          'name': 'User $i Name', // Dummy description
          //'text': "Do you know of a shelter that accepts clothing donation or household applications? Your recommendations are much appreciated! ", // Calculate time ago
          'image': 'assets/images/Rectangle 4160.png',
          'duration' : '2h.',
          'mutual': "Anas Ahmed and 3 others",
          'comments': "$i comments"
        });
      }
    }
    return  Scaffold(
       appBar: AppBar(
         backgroundColor: HexColor("027E81"),
         leading:  IconButton(
           icon:SvgPicture.asset(
             'assets/images/arrow_left_white.svg',
           ),
           onPressed:(){
             navigateAndFinish(context, VolunHeroUserLayout());
           },
         ),
         actions: [
           IconButton(
               onPressed: (){},
               icon: CircleAvatar(
                 radius: 15.0,
                 backgroundColor: Colors.grey[400],
                 child: Icon(
                   Icons.camera_alt_outlined,
                   size: 18.0,
                   color: Colors.black,
                 ),
               )
           )
         ],

       ),
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: screenHeight / 5,
              color:  HexColor("027E81"),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            userName,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        ),
                        SizedBox(height: screenHeight/80,),
                        Text(
                          userEmail,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(width: screenWidth/40,),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        radius: 40.0,
                        backgroundImage: AssetImage(
                            'assets/images/man_photo.png'),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: (){},
                          child: Container(
                            width: 20, // Adjust as needed
                            height: 20, // Adjust as needed
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: Icon(
                              Icons.edit_outlined,
                              size: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight/100,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(-10, 0), // Left
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),

                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(0, 5), // Bottom
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  color: Colors.white,
                  borderRadius:BorderRadius.circular(10.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                              "PERSONAL DETAILS",
                            style: TextStyle(
                              color:Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: (){},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: HexColor("027E81")
                                )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 4.0,top: 4.0),
                                child: Text(
                                    "EDIT PROFILE",
                                  style: TextStyle(
                                      color:Colors.black,
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                  ),

                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: screenHeight/100,),
                      Row(
                        children: [
                          SvgPicture.string(
                            '<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M4.26 10.147a60.438 60.438 0 0 0-.491 6.347A48.62 48.62 0 0 1 12 20.904a48.62 48.62 0 0 1 8.232-4.41 60.46 60.46 0 0 0-.491-6.347m-15.482 0a50.636 50.636 0 0 0-2.658-.813A59.906 59.906 0 0 1 12 3.493a59.903 59.903 0 0 1 10.399 5.84c-.896.248-1.783.52-2.658.814m-15.482 0A50.717 50.717 0 0 1 12 13.489a50.702 50.702 0 0 1 7.74-3.342M6.75 15a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Zm0 0v-3.675A55.378 55.378 0 0 1 12 8.443m-7.007 11.55A5.981 5.981 0 0 0 6.75 15.75v-1.5" /></svg>',
                          ),
                          SizedBox(width: screenWidth/100,),
                          SizedBox(
                            width: 300, // Adjust width as needed
                            child: Text(
                              university,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: screenHeight/100,),
                      Row(
                        children: [
                          Icon(Icons.location_on_rounded),
                          SizedBox(width: screenWidth/100,),
                          SizedBox(
                            width: 300, // Adjust width as needed
                            child: Text(
                              "Lives in $city",
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: screenHeight/100,),
                      Text("Contact Info",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20
                      ),),
                      SizedBox(height: screenHeight/100,),
                      Row(
                        children: [
                         Icon(Icons.phone),
                          SizedBox(width: screenWidth/100,),
                          SizedBox(
                            width: 300, // Adjust width as needed
                            child: Text(
                              phoneNumber,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(-10, 0), // Left
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),

                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(0, 5), // Bottom
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius:BorderRadius.circular(10.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "YOUR POSTS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                      ),
                      SizedBox(height: screenHeight/100,),
                      Container(height: 1,color: HexColor("9B9B9B"),),
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth / 18),
                        child: TextFormField(
                          controller: _textEditingController,
                          decoration: const InputDecoration(
                            hintText: "What's on your mind ?",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none, // Hide the border line
                          ),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ),
            SizedBox(height: screenHeight/100,), // Add this line for spacing
            ListView.separated(
              physics: NeverScrollableScrollPhysics( ),
              shrinkWrap: true,
              itemBuilder: (context, index) => buildPostItem(index, context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              itemCount: posts.length,
            ),
          ],
        ),
      ),
    );
  }
  Widget buildPostItem(index,context){
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Padding(
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
                    AssetImage(posts[index]['photo']),
                  ),
                  SizedBox(width: screenWidth/50,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        posts[index]['name'],
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
                            posts[index]['duration'],
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
                  children: [
                    posts[index]['text']!=null ? Text(
                      posts[index]['text'],
                      maxLines:  posts[index]['image']!=null ? 2: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "Robot",
                        fontSize: 12,
                      ),
                    ):SizedBox(height: 0,),
                    posts[index]['image']!=null ? SizedBox(height: screenHeight/100,):SizedBox(height: 0,),
                    posts[index]['image']!=null ? Image.asset(
                      posts[index]['image'],
                    ): Container(height: 0.5,)
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
                      posts[index]['mutual'],
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 12,
                          color: HexColor("575757")
                      ),
                    ),
                    Spacer(),
                    Text(
                      posts[index]['comments'],
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
