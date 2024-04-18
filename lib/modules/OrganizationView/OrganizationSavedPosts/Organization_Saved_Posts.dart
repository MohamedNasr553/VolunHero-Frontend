import 'package:flutter/material.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stroke_text/stroke_text.dart';

class OrganizationSavedPosts extends StatefulWidget {
  const OrganizationSavedPosts({super.key});

  @override
  State<OrganizationSavedPosts> createState() => _UserSavedPostsState();
}

class _UserSavedPostsState extends State<OrganizationSavedPosts> {
  List<Map<String, dynamic>> posts = [];
  bool _showWidget = false;

  @override
  void initState() {
    super.initState();
    // After 3 seconds, set the _showWidget to true
    Future.delayed(const Duration(seconds: 6), () {
      setState(() {
        _showWidget = true;
      });
    });
  }


  @override
  Widget build(BuildContext context) {

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
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading:  IconButton(
          icon:SvgPicture.asset(
            'assets/images/arrowLeft.svg',
          ),
          color: HexColor("858888"),
          onPressed:(){},
        ),
        title:  StrokeText(
          text: "Saved Posts",
          strokeColor: Colors.white,
          textStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color: HexColor("296E6F")
          ),
        ),
      ),
      body:_showWidget==false?ListView.builder(

        itemCount: 10, // Number of posts
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            period: Duration(milliseconds: 1500),
            baseColor: Colors.grey,
            highlightColor: Colors.white30,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                      ),
                      SizedBox(width: screenWidth/40,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight/75,
                            width: screenWidth/4,
                            child: Container(
                              decoration: BoxDecoration(color:Colors.grey ,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          SizedBox(
                            height: screenHeight/75,
                            width: screenWidth/2,
                            child: Container(
                              decoration: BoxDecoration(color:Colors.grey ,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          )
                        ],
                      ),


                    ],
                  ),
                  SizedBox(height: screenHeight/100,),
                  Center(
                    child: SizedBox(
                      height: screenHeight/4,
                      width: screenWidth,
                      child: Container(
                        decoration: BoxDecoration(color:Colors.grey ,
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ): Column(
        children: [

          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildPostItem(index, context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,

                  color: Colors.white,
                ),
              ),
              itemCount: posts.length ,
            ),
          ),
        ],
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
