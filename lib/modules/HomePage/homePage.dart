import 'package:flutter/material.dart';
import 'package:flutter_code/modules/HomePage/drawer.dart';
import 'package:flutter_code/shared/components/components.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  // Sample
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 50.0,
                  height: 50.0,
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
            child: Container(
              width: screenWidth / 1.46,
              height: screenHeight / 25,
              child: defaultTextFormField(
                radius: 7.0,
                borderColor: Colors.white,
                validate: (value) {
                  return null;
                },
                controller: searchController,
                type: TextInputType.text,
                hintText: 'Search...',
                hintSize: 12.0,
                prefix: Icons.search,
                iconColor: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: screenHeight / 300,
              start: screenWidth / 80,
              end: screenWidth / 80,
            ),
            child: IconButton(
              onPressed: () {
                // navigateToPage(context, chatsScreen());
              },
              icon: const Icon(
                Icons.chat_outlined,
              ),
            ),
          ),
        ],
      ),
      drawer: const SidePage(),
    );
  }
}
