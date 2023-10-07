import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "긴급신고",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "신고 유형을 선택하여 문자로 신고해주세요",
                          style: TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ],

              ),),
              SizedBox(height: 10),

              SizedBox(height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 20),
                  departmentCard(
                    "범죄",
                    "crime",
                    Colors.blueAccent,
                    "🚨",
                  ),
                  departmentCard(
                    "화재",
                    "fire",
                    Colors.orangeAccent,
                    "🔥",
                  ),
                  departmentCard(
                    "구조/구급",
                    "Rescue/First Aid",
                    Colors.redAccent,
                    "🏥",
                  ),
                ],
               ),
              ),
              SizedBox(height: 30),
              Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 1,
                height: 1,
                color: Colors.black38,
               ),
              ),
              SizedBox(height: 20),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  emergencyReport(
                      "그림으로 신고",
                      "assets/picture.png",
                      Colors.blueAccent,
                      "그림으로 간편하고 빠르게 신고"
                  ),
                  emergencyReport(
                      "112 신고",
                      "assets/call.png",
                      Colors.blueAccent,
                      "전화로 신속하게 신고"
                  ),
                  emergencyReport(
                      "119 신고",
                      "assets/call.png",
                      Colors.blueAccent,
                      "전화로 신속하게 신고"
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget emergencyReport(String name, String image, Color color, String Title ){
    return Padding(padding: EdgeInsets.only(bottom: 20),
    child: InkWell(
      onTap: (){
        String _job;
        if(color == Colors.blueAccent){
          _job = "Picture";
        } else if(color == Colors.redAccent){
          _job = "Engineer";
        }
        else{
          _job = "Designer";
        }
        // Navigator.push(context, MaterialPageRoute(
        //     builder: (context) => WorkerDetailsScreen(),
        //  ),
        // );
      },
      child: Container(
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
          color: color.withOpacity(0.07),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: ListTile(
            leading: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(),
                color: Colors.white10,
                image: DecorationImage(
                  image: AssetImage(image),
                  fit:BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              Title,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            trailing: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Center(
                  child: Icon(
                    FontAwesome5Regular.edit,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
     ),
    );
  }


  Widget departmentCard (String name, String title, Color color,
      String emoji)
  {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(emoji,
                  style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(name, style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black12,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
