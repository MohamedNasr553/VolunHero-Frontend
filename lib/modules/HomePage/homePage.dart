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
              child: TextFormField(
                controller: searchController,
                validator: (value){
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
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
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
                  // Add suffix icon conditionally based on isPassword
                ),
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
              icon: Icon(
                Icons.chat,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
      drawer: const SidePage(),
    );
  }
}
