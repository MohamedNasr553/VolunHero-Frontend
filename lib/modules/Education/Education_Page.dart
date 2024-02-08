import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Education extends StatelessWidget {
  Education({super.key});
  List<Map<String, dynamic>> contacts = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 1; i <= 5; i++) {
      contacts.add({
        'image': 'assets/images/logo.png', // Dummy image filename
        'name': 'User $i Name', // Dummy description
        'role': "Teacher" // Calculate time ago
      });
    }

    return    Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Education",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto"
                      ),
                    ),
                    Text(
                      "Ask your questions for any online teacher",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto"
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.0,),
              Container(
                height: 1.0,
                color: HexColor("039FA2"),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildContactItem(index, context),
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
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    color:   Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 40.0,
                                backgroundImage: AssetImage(contacts[index]['image']),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  bottom: 3.0,
                                  end: 3.0,
                                ),
                                child: CircleAvatar(
                                  radius: 5.0,
                                  backgroundColor: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contacts[index]['name'],
                                maxLines: 2,
                              ),
                              const SizedBox(
                                height: 1.0,
                              ),
                              Text(
                                contacts[index]['role'],
                                style: TextStyle(
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
              Spacer(),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.call_outlined)
              )
            ],
          ),
          Container(
            height: 1.0,
            color: HexColor("039FA2"),
          )
        ],
      ),
    );
  }
}
