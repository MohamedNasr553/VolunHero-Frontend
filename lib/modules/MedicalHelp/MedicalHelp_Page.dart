import 'package:flutter/material.dart';
import 'package:flutter_code/shared/components/components.dart';

class MedicalHelp extends StatelessWidget {
  MedicalHelp({super.key});

  List<Map<String, dynamic>> contacts = [];

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    for (int i = 1; i <= 5; i++) {
      contacts.add({
        'image': 'assets/images/logo.png', // Dummy image filename
        'name': 'User $i Name', // Dummy description
        'role': "Doctor" // Calculate time ago
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Medical Help",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth / 25,
                  top: screenHeight / 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Request an online doctor",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.5),
                        fontFamily: "Roboto",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 1.0,
                color: Colors.white,
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildContactItem(index, context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 0.1,
                  color: Colors.white,
                ),
              ),
              itemCount: contacts.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContactItem(index, context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(screenHeight / 70),
                      child: Row(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 40.0,
                                backgroundImage:
                                    AssetImage(contacts[index]['image']),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  bottom: screenHeight / 100,
                                  end: screenWidth / 80,
                                ),
                                child: const CircleAvatar(
                                  radius: 5.0,
                                  backgroundColor: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: screenWidth / 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contacts[index]['name'],
                                maxLines: 2,
                              ),
                              const SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                contacts[index]['role'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.call_outlined),
              ),
            ],
          ),
          separator(),
        ],
      ),
    );
  }
}
