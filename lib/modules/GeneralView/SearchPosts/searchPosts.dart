import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code/bloc/Login_bloc/cubit.dart';
import 'package:flutter_code/bloc/Login_bloc/states.dart';
import 'package:flutter_code/bloc/Layout_bloc/cubit.dart';
import 'package:flutter_code/bloc/Layout_bloc/states.dart';
import 'package:flutter_code/layout/VolunHeroLayout/layout.dart';
import 'package:flutter_code/models/LoggedInUserModel.dart';
import 'package:flutter_code/models/SearchPostsModel.dart';
import 'package:flutter_code/modules/GeneralView/DetailedPost/Detailed_Post.dart';
import 'package:flutter_code/shared/components/components.dart';
import 'package:flutter_code/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchPostsPage extends StatefulWidget {
  const SearchPostsPage({super.key});

  @override
  State<SearchPostsPage> createState() => _SearchPostsPageState();
}

class _SearchPostsPageState extends State<SearchPostsPage> {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final CarouselController carouselController = CarouselController();
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<UserLoginCubit, UserLoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<HomeLayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                // leading: IconButton(
                //   icon: SvgPicture.asset('assets/images/arrowLeft.svg'),
                //   color: HexColor("858888"),
                //   onPressed: () => navigateToPage(context, const VolunHeroUserLayout()),
                // ),
                actions: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: screenHeight / 70,
                        end: screenWidth / 25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenWidth / 1.33,
                            height: screenHeight / 23,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: searchController,
                              validator: (value) {
                                return null;
                              },
                              onChanged: (value) {
                                HomeLayoutCubit.get(context).searchPost(
                                  content: value,
                                  token: UserLoginCubit.get(context)
                                          .loginModel!
                                          .refresh_token ??
                                      "",
                                );
                              },
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                  size: 23,
                                ),
                                hintText: 'Search',
                                hintStyle: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: screenHeight / 90,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: screenHeight / 70,
                      end: screenWidth / 20,
                    ),
                    child: InkWell(
                      onTap: () => navigateAndFinish(
                          context, const VolunHeroLayout()),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  SizedBox(height: screenHeight / 80),
                  (searchController.text.isEmpty &&
                          state is! SearchPostLoadingState)
                      ? Padding(
                          padding: EdgeInsetsDirectional.only(
                            top: screenHeight / 130,
                            start: screenWidth / 4.7,
                          ),
                          child: const Text(
                            'Try searching for posts, topics, or keywords',
                            style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        )
                      : const SizedBox(),
                  if (state is SearchPostLoadingState)
                    const LinearProgressIndicator(color: defaultColor),
                  if (state is SearchPostSuccessState)
                    (HomeLayoutCubit.get(context)
                            .searchPostResponse!
                            .searchPost!
                            .isNotEmpty)
                        ? Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                top: screenHeight / 120,
                                start: screenWidth / 45,
                                end: screenWidth / 45,
                              ),
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return buildSearchPostItem(
                                    HomeLayoutCubit.get(context)
                                        .searchPostResponse!
                                        .searchPost![index],
                                    UserLoginCubit.get(context)
                                        .loggedInUserData!
                                        .doc,
                                    context,
                                  );
                                },
                                separatorBuilder: (context, index) => Padding(
                                  padding: EdgeInsetsDirectional.symmetric(
                                      vertical: screenHeight / 200),
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                  ),
                                ),
                                itemCount: HomeLayoutCubit.get(context)
                                    .searchPostResponse!
                                    .searchPost!
                                    .length,
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: screenHeight / 30,
                              start: screenWidth / 20,
                              end: screenWidth / 15,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "No Results for ${searchController.text}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24.0,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: screenHeight / 150),
                                const Text(
                                  "Try Searching for something else, or check settings",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.0,
                                    color: Colors.black38,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            ),
                          ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildSearchPostItem(SearchPostDetails? searchPostDetails,
      LoggedInUser loggedInUser, context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // Handling Post Duration
    DateTime? createdAt = searchPostDetails!.createdAt;
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
      padding: EdgeInsets.symmetric(vertical: screenHeight / 300),
      child: GestureDetector(
        onTap: () {
          final token = UserLoginCubit.get(context).loginModel?.refresh_token;
          final postId = searchPostDetails.id!;
          if (token != null) {
            HomeLayoutCubit.get(context).getPostId(
              token: token,
              postId: postId,
            );
          }
          navigateToPage(context, const DetailedPost());
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 10.0,
                spreadRadius: -5.0,
                offset: const Offset(10.0, 10.0),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(screenHeight / 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (searchPostDetails.sharedFrom != null)
                    ? Column(
                        children: [
                          SizedBox(height: screenHeight / 120),
                          sharedByUserInfo(
                              searchPostDetails, loggedInUser, context),
                        ],
                      )
                    : const SizedBox(),
                SizedBox(height: screenHeight / 120),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// Profile Pic
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: searchPostDetails.createdBy.profilePic !=
                              null
                          ? NetworkImage(searchPostDetails
                              .createdBy.profilePic!.secureUrl) as ImageProvider
                          : const AssetImage("assets/images/nullProfile.png"),
                    ),
                    SizedBox(width: screenWidth / 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Username
                        Text(
                          searchPostDetails.createdBy.userName,
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
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(width: screenWidth / 70),
                            SvgPicture.asset('assets/images/earthIcon.svg'),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),

                    /// Post Settings
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/images/postSettings.svg',
                      ),
                    ),

                    /// Hide Post
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/images/closePost.svg',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
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
                      Text(
                        searchPostDetails.content!,
                        maxLines:
                            (searchPostDetails.attachments!) != null ? 6 : 10,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "Robot",
                          fontSize: 13.0,
                        ),
                      ),
                      SizedBox(height: screenHeight / 100),

                      /// Post Attachments
                      if (searchPostDetails.attachments!.isNotEmpty)
                        // check if there's more than one
                        if (searchPostDetails.attachments!.length > 1)
                          CarouselSlider(
                            carouselController: carouselController,
                            items: searchPostDetails.attachments!
                                .map((attachment) {
                              return Image(
                                image: NetworkImage(attachment.secureUrl),
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
                              searchPostDetails.attachments![0].secureUrl,
                            ),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: searchPostDetails.attachments!
                            .asMap()
                            .entries
                            .map((entry) {
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
                      (searchPostDetails.likesCount) > 0
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
                      (searchPostDetails.likesCount > 0)
                          ? Text(
                              '${searchPostDetails.likesCount}',
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 12,
                                color: HexColor("575757"),
                              ),
                            )
                          : Container(),
                      const Spacer(),

                      /// Post Comments
                      if (searchPostDetails.commentsCount == 1)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                            bottom: screenHeight / 50,
                          ),
                          child: Text(
                            '${searchPostDetails.commentsCount} Comment',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        )
                      else if (searchPostDetails.likesCount > 0 &&
                          searchPostDetails.commentsCount == 1)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                          ),
                          child: Text(
                            '${searchPostDetails.commentsCount} Comment',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        )
                      else if (searchPostDetails.likesCount > 0 &&
                          searchPostDetails.commentsCount > 1)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                          ),
                          child: Text(
                            '${searchPostDetails.commentsCount} Comments',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        )
                      else if (searchPostDetails.commentsCount == 0)
                        Container()
                      else
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: screenWidth / 50,
                            end: screenWidth / 50,
                            bottom: screenHeight / 50,
                          ),
                          child: Text(
                            '${searchPostDetails.commentsCount} Comments',
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: HexColor("575757"),
                            ),
                          ),
                        ),
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
                        postSubComponent(
                          "assets/images/like.svg",
                          "Like",
                          context,
                        ),
                        const Spacer(),
                        postSubComponent(
                          "assets/images/comment.svg",
                          "Comment",
                          context,
                        ),
                        const Spacer(),
                        postSubComponent(
                          "assets/images/share.svg",
                          "Share",
                          context,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sharedByUserInfo(SearchPostDetails? searchPostDetails,
      LoggedInUser loggedInUser, BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: screenWidth / 40,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                "assets/images/share.svg",
                width: 18.0,
                height: 18.0,
              ),
            ),
            SizedBox(width: screenWidth / 80),
            CircleAvatar(
              radius: 10.0,
              backgroundImage: searchPostDetails!.sharedBy!.profilePic != null
                  ? NetworkImage(
                          searchPostDetails.sharedBy!.profilePic!.secureUrl)
                      as ImageProvider
                  : const AssetImage("assets/images/nullProfile.png"),
            ),
            SizedBox(width: screenWidth / 80),
            Text(
              (searchPostDetails.sharedBy!.userName == loggedInUser.userName)
                  ? 'You'
                  : searchPostDetails.sharedBy!.userName,
              style: const TextStyle(
                fontFamily: "Roboto",
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
            SizedBox(width: screenWidth / 150),
            const Text(
              'shared this',
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
