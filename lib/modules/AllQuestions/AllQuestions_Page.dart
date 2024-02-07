import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Questions extends StatelessWidget {
  Questions({super.key});
  List<Map<String, dynamic>> contacts = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 1; i <= 10; i++) {
      contacts.add({
        'image': 'assets/images/logo.png', // Dummy image filename
        'name': 'User $i Name', // Dummy description
        'role': (i%2==0)?'Teacher':"Doctor" // Calculate time ago
      });
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
             "Ready for any questions",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 1,),
          Container(
            height: 1.0,
            color: HexColor("039FA2"),
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
