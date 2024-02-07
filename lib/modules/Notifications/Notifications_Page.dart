import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stroke_text/stroke_text.dart';

class NotificationPage extends StatelessWidget {
   NotificationPage({super.key});

   List<Map<String, dynamic>> notifications = [];

   // Fill the list with 10 dummy notifications


  @override
  Widget build(BuildContext context) {
    for (int i = 1; i <= 10; i++) {
      notifications.add({
        'image': 'assets/images/User_circle.svg', // Dummy image filename
        'description': 'Notification $i description', // Dummy description
        'time': '10m' // Calculate time ago
      });
    }
    return Scaffold(
      appBar: AppBar(
         title:Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             StrokeText(
               text: "Notifications",
               textStyle: TextStyle(
                 fontSize: 32.0,
                 fontWeight: FontWeight.w500,
                 color: Colors.black,
               ),
               strokeWidth: 0.5,
               strokeColor: Colors.black,
             ),
           ],
         ),
        actions: [
          IconButton(
              onPressed: (){},
              iconSize: 35.0,
              icon: Icon(
                Icons.settings_outlined,
              )
          )
        ],
      ),
      body: Column(
        children: [
          Container(height: 2.0,color: Colors.grey,),
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildNotificationItem(index,context),
              separatorBuilder: (context, index) =>
                  Padding
                    (
                    padding: const EdgeInsetsDirectional.only(
                        start: 10.0
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 0.1,
                      color: Colors.white,
                    ),
                  ),
              itemCount: (notifications.length),
            ),
          ),
        ],
      )
    );
  }


  Widget buildNotificationItem(int index,context){

    return InkWell(
      onTap: (){


      },
      child: Container(
        color: (index%2!=0) ? HexColor("D7DCDC"):Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundImage: AssetImage(notifications[index]['image']) ,
              ),
              SizedBox(width: 15.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notifications[index]['description'],
                    maxLines: 2,

                  ),
                  SizedBox(height: 1.0,),
                  Text(
                    notifications[index]['time'],
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

