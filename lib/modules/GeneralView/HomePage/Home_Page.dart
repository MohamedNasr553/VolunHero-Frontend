import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/cubit.dart';
import 'package:flutter_code/bloc/UserLayout_bloc/states.dart';
import 'package:flutter_code/models/HomePagePostsModel.dart';
import 'package:flutter_code/modules/GeneralView/Chats/chatPage.dart';
import 'package:flutter_code/modules/UserView/UserDrawer/drawer.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/components/constants.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  var searchController = TextEditingController();
  final CarouselController carouselController = CarouselController();
  int _currentImageIndex = 0;
  bool load = false;

  @override
  void initState() {
    super.initState();
    if (userToken != null && userToken!.isNotEmpty) {
      print("Token is not null and not empty: $userToken");
      UserLoginCubit.get(context).getLoggedInUserData(token: userToken ?? "");
      HomeLayoutCubit.get(context).getAllPosts(token: userToken ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<HomeLayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Builder(builder: (context) {
              return Padding(
                padding: EdgeInsetsDirectional.only(
                  start: screenWidth / 40,
                ),
                child: GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: Image.asset('assets/images/logo.png'),
                      // child: (HomeLayoutCubit.get(context).modifiedPost!.createdBy.profilePic == null)?
                      //  Image.asset('assets/images/nullProfile.png'):
                      // Image.asset('assets/images/${HomeLayoutCubit.get(context).modifiedPost!.createdBy.profilePic}'),
                    ),
                  ),
                ),
              );
            }),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: screenHeight / 300,
                ),
                child: SizedBox(
                  width: screenWidth / 1.42,
                  height: screenHeight / 25,
                  child: TextFormField(
                    controller: searchController,
                    validator: (value) {
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey.shade500,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: screenHeight / 300,
                  start: screenWidth / 80,
                  end: screenWidth / 60,
                ),
                child: IconButton(
                    onPressed: () {
                      UserLoginCubit.get(context)
                          .getLoggedInChats()
                          .then((value) {
                        navigateToPage(context, const ChatsPage());
                      });
                    },
                    icon:
                        SvgPicture.asset("assets/images/messagesIcon.svg")),
              ),
            ],
          ),
          drawer: const UserSidePage(),
          body: (state is! HomePagePostsLoadingState)?
            buildPostsList(context): buildLoadingWidget(context)
        );
      },
    );
  }

  Widget buildLoadingWidget(context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: HomeLayoutCubit.get(context)
              .homePagePostsModel
              ?.modifiedPosts
              .length ??
          0,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          period: const Duration(milliseconds: 1000),
          baseColor: Colors.grey,
          highlightColor: Colors.white30,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                    ),
                    SizedBox(
                      width: screenWidth / 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight / 75,
                          width: screenWidth / 4,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: screenHeight / 75,
                          width: screenWidth / 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight / 100,
                ),
                Center(
                  child: SizedBox(
                    height: screenHeight / 4,
                    width: screenWidth,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPostsList(context) {
    var cubit = HomeLayoutCubit.get(context);

    if (cubit.homePagePostsModel != null) {
      if (cubit.homePagePostsModel!.modifiedPosts.isNotEmpty) {
        return Column(
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      reverse: true,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final homePagePostsModel = cubit.homePagePostsModel;
                        if (homePagePostsModel != null) {
                          if (index < homePagePostsModel.modifiedPosts.length) {
                            return buildPostItem(
                                homePagePostsModel.modifiedPosts[index], context);
                          }
                        }
                        return const Text("No Posts Available");
                      },
                      separatorBuilder: (context, index) => Padding(
                        padding:
                            const EdgeInsetsDirectional.symmetric(horizontal: 16),
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                      itemCount: cubit.homePagePostsModel!.modifiedPosts.length,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      } else {
        return const Center(child: Text('No posts available'));
      }
    } else {
      return buildLoadingWidget(context);
    }
  }

  Widget buildPostItem(ModifiedPost? postDetails, BuildContext context) {
    if (postDetails == null) {
      return const SizedBox();
    }

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // Handling Post Duration
    DateTime? createdAt = postDetails.createdAt;
    String? durationText;

    DateTime createdTime = createdAt;
    DateTime timeNow = DateTime.now();
    Duration difference = timeNow.difference(createdTime);

    if (difference.inMinutes > 59) {
      durationText = '${difference.inHours}h .';
    } else if (difference.inMinutes < 1) {
      durationText = '${difference.inSeconds}s .';
    } else {
      durationText = '${difference.inMinutes.remainder(60)}m .';
    }
    // In Days
    if (difference.inHours >= 24) {
      durationText = '${difference.inDays}d .';
    }

    return Padding(
      padding: EdgeInsets.all(screenWidth / 50),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: -5.0,
              offset: const Offset(10.0, 10.0), // Right and bottom shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth / 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: (postDetails.createdBy.profilePic != null)
                        ? AssetImage(postDetails.createdBy.profilePic!)
                        : const AssetImage("assets/images/nullProfile.png"),
                  ),
                  SizedBox(width: screenWidth / 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        postDetails.createdBy.userName,
                        style: const TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 0.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            durationText,
                            style: TextStyle(
                              color: HexColor("B8B9BA"),
                              fontSize: 10.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 2),
                          SvgPicture.asset(
                            'assets/images/earthIcon.svg',
                          ),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => _showHomePageBottomSheet(),
                    icon: SvgPicture.asset(
                      'assets/images/postSettings.svg',
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/images/closePost.svg',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 1.0),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: screenHeight / 100,
                  start: screenWidth / 50,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Post Content
                    postDetails.content != null
                        ? Text(
                            postDetails.content,
                            maxLines:
                                (postDetails.attachments) != null ? 6 : 10,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: "Robot",
                              fontSize: 13.0,
                            ),
                          )
                        : const SizedBox(height: 0),

                    SizedBox(height: screenHeight / 100),

                    /// Post Attachments
                    if (postDetails.attachments.isNotEmpty)
                      // check if there's more than one
                      if (postDetails.attachments.length > 1)
                        CarouselSlider(
                          carouselController: carouselController,
                          items: postDetails.attachments.map((attachment) {
                            return Image(
                              image: NetworkImage(attachment.secure_url),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: 200,
                            viewportFraction: 1.0,
                            enableInfiniteScroll: true,
                            autoPlayCurve: Curves.easeIn,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentImageIndex = index;
                              });
                            },
                          ),
                        )
                      else
                        Image(
                          image: NetworkImage(
                            postDetails.attachments[0].secure_url,
                          ),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          postDetails.attachments.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              carouselController.animateToPage(entry.key),
                          child: Container(
                            width: 7.0,
                            height: 7.0,
                            margin: EdgeInsets.symmetric(
                              vertical: screenHeight / 90,
                              horizontal: screenWidth / 100,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentImageIndex == entry.key
                                  ? defaultColor
                                  : Colors.grey,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: screenHeight / 100,
                  start: screenWidth / 500,
                ),
                child: Row(
                  children: [
                    /// Post Likes
                    (postDetails.likesCount) > 0
                        ? IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'assets/images/NewLikeColor.svg',
                              width: 22.0,
                              height: 22.0,
                            ),
                          )
                        : Container(),
                    (postDetails.likesCount > 0)
                        ? Text(
                            '${postDetails.likesCount}',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          )
                        : Container(),
                    const Spacer(),

                    /// Post Comments
                    // postDetails.commentsCount > 0
                    //     ? IconButton(
                    //   padding: EdgeInsets.zero,
                    //   onPressed: () {},
                    //   icon: SvgPicture.asset(
                    //     'assets/images/comment.svg',
                    //   ),
                    // )
                    //     : Container(),
                    // (postDetails.commentsCount > 0) ?
                    // Text(
                    //   '${postDetails.commentsCount}',
                    //   style: TextStyle(
                    //     fontFamily: "Roboto",
                    //     fontSize: 12,
                    //     color: HexColor("575757"),
                    //   ),
                    // ): Container(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: screenWidth / 100,
                  end: screenWidth / 100,
                ),
                child: Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: screenWidth / 30,
                    end: screenWidth / 30,
                    top: screenHeight / 200,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (postDetails.likesCount > 0)
                          ? postSubComponent(
                        "assets/images/NewLikeColor.svg",
                        " Like",
                        color: HexColor("4267B2"),
                        fontWeight: FontWeight.w600,
                        onTap: (){
                          HomeLayoutCubit.get(context).likePost(postId: postDetails.id, token: userToken ?? "");
                        },
                      )
                          : postSubComponent(
                        "assets/images/like.svg",
                        "Like",
                        onTap: (){
                          HomeLayoutCubit.get(context).likePost(postId: postDetails.id, token: userToken ?? "");
                        },
                      ),
                      const Spacer(),
                      postSubComponent(
                        "assets/images/comment.svg",
                        "Comment",
                      ),
                      const Spacer(),
                      postSubComponent(
                        "assets/images/share.svg",
                        "Share",
                      ),
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

  Widget postSubComponent(String assetIcon, String action, {GestureTapCallback? onTap,
      Color color = const Color(0xFF575757),
      FontWeight fontWeight = FontWeight.w300}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            assetIcon,
            color: color,
          ),
          const SizedBox(width: 1),
          Text(
            action,
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Roboto",
              color: color,
              fontWeight: fontWeight,
            ),
          )
        ],
      ),
    );
  }

  void _showHomePageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;

        return Container(
          height: screenHeight / 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListTile(
                leading: const Icon(Icons.save, size: 25,),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        'Save Post',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight / 130),
                    const Text(
                      'Add this to your saved items.',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Logic to save the post
                },
              ),
              ListTile(
                leading: const Icon(Icons.close, size: 25,),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hide Post',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight / 130),
                    const Text(
                      'See fewer posts like this.',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Logic to save the post
                },
              ),
              ListTile(
                leading: const Icon(Icons.copy, size: 25,),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Copy link',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight / 130),
                    const Text(
                      'Copy post URL.',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Logic to save the post
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
