import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';


class PictureDeatilsScreen extends StatefulWidget {
  final String name;
  final String image;
  final Color color;
  final String title;
  int? selectedRadio;
  bool radioButtonValue = false;
  bool isCheckboxChecked = false;
  bool isSelectedCrime = false;
  bool isSelectedFire = false;
  bool isSelectedEmergency = false;

  PageController pageController = PageController(initialPage: 0);

  PictureDeatilsScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  _PictureDeatilsScreenState createState() => _PictureDeatilsScreenState();
}

class _PictureDeatilsScreenState extends State<PictureDeatilsScreen> {
  void setSelectedRadio(int radio) {
    setState(() {
      widget.selectedRadio = radio;
    });

  }

  void setPageView(int index){
    setState(() {
      widget.pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  void toggleSelectedOption(String optionName){
    setState(() {
      if(optionName == "범죄") {
        widget.isSelectedCrime = !widget.isSelectedCrime;
        if(widget.isSelectedCrime){
          widget.isSelectedFire = false;
          widget.isSelectedEmergency = false;
        }
      } else if(optionName == "화재"){
        widget.isSelectedFire = !widget.isSelectedFire;
        if(widget.isSelectedFire){
          widget.isSelectedCrime = false;
          widget.isSelectedEmergency = false;
        }
      } else if(optionName == "긴급/구조"){
        widget.isSelectedEmergency = !widget.isSelectedEmergency;
        if(widget.isSelectedEmergency){
          widget.isSelectedCrime = false;
          widget.isSelectedFire = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: widget.color.withOpacity(0.12),
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      child: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      "그림신고",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                    height: 50,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 30,),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 230),
                              child: const Text(
                                "긴급신고유형",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        toggleSelectedOption("범죄");
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: widget.isSelectedCrime ? Colors.blueAccent.withOpacity(0.40) : Colors.white,
                                          ),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "🚨 범죄",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        toggleSelectedOption("화재");
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: widget.isSelectedFire ? Colors.blueAccent.withOpacity(0.40) : Colors.white,
                                          ),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "🔥 화재",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {

                                      setState(() {
                                        toggleSelectedOption("긴급/구조");
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: widget.isSelectedEmergency ? Colors.blueAccent.withOpacity(0.40) : Colors.white,
                                          ),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "🏥 긴급/구조",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30,),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 20),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: widget.isCheckboxChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        widget.isCheckboxChecked = value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    " 음성통화 곤란 시 체크(청각장애인, 위험상황 등)",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 270),
                              child: const Text(
                                "그림 목록",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 380,
                              child: PageView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10.0),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: Colors.white,
                                    ),

                                    child: PageView.builder(
                                      itemCount: 1, // 대체하실 아이템 개수를 입력해주세요
                                      itemBuilder: (BuildContext context, int index) {
                                        return Container(
                                          margin: const EdgeInsets.all(10.0),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            color: Colors.white,
                                          ),


                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children:[

                                                  Image.network(
                                                  'https://via.placeholder.com/150', // 이미지 URL로 대체해주세요
                                                  width: 150,
                                                  height: 100,
                                                  ),
                                                  Image.network(
                                                  'https://via.placeholder.com/150', // 이미지 URL로 대체해주세요
                                                  width: 150,
                                                  height: 100,
                                                  ),
                                                ],
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [

                                                  Row(
                                                    children:[
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Radio(
                                                            value: 1, // 라디오 버튼의 고유한 값 (1로 설정 예시)
                                                            groupValue: widget.selectedRadio, // 그룹 내에서 선택된 라디오 버튼의 값
                                                            onChanged: (value) {
                                                              // 라디오 버튼 선택을 처리하세요
                                                              setSelectedRadio(value!);

                                                            },
                                                          ),

                                                          const Text(
                                                            "라디오 버튼 1", // 첫 번째 라디오 버튼 옆에 나타낼 텍스트
                                                            style: TextStyle(fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 32,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Radio(
                                                            value: 2,
                                                            groupValue: widget.selectedRadio, // 그룹 값은 상황에 따라 설정해주세요
                                                            onChanged: (value) {
                                                              // 라디오 버튼 선택을 처리하세요
                                                              setSelectedRadio(value!);
                                                            },
                                                          ),
                                                          const Text(
                                                            "라디오 버튼 2", // 두 번째 라디오 버튼 옆에 나타낼 텍스트
                                                            style: TextStyle(fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                    ],

                                                  )
                                                ],

                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children:[

                                                  Image.network(
                                                    'https://via.placeholder.com/150', // 이미지 URL로 대체해주세요
                                                    width: 150,
                                                    height: 100,
                                                  ),
                                                  Image.network(
                                                    'https://via.placeholder.com/150', // 이미지 URL로 대체해주세요
                                                    width: 150,
                                                    height: 100,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [

                                                  Row(
                                                    children:[
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Radio(
                                                            value: 3, // 라디오 버튼의 고유한 값 (1로 설정 예시)
                                                            groupValue: widget.selectedRadio, // 그룹 내에서 선택된 라디오 버튼의 값
                                                            onChanged: (value) {
                                                              // 라디오 버튼 선택을 처리하세요
                                                              setSelectedRadio(value!);

                                                            },
                                                          ),

                                                          const Text(
                                                            "라디오 버튼 3", // 첫 번째 라디오 버튼 옆에 나타낼 텍스트
                                                            style: TextStyle(fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 32,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Radio(
                                                            value: 4,
                                                            groupValue: widget.selectedRadio, // 그룹 값은 상황에 따라 설정해주세요
                                                            onChanged: (value) {
                                                              // 라디오 버튼 선택을 처리하세요
                                                              setSelectedRadio(value!);
                                                            },
                                                          ),
                                                          const Text(
                                                            "라디오 버튼 4", // 두 번째 라디오 버튼 옆에 나타낼 텍스트
                                                            style: TextStyle(fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),


                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10.0),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: const Center(
                                      child: Text('Page 2'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                              height: 20,
                              child: Container(
                                padding: const EdgeInsets.only(left: 10, right: 230),
                                child: const Text(
                                  "재난 위치 확인",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12,),
                            Container(
                              padding: const EdgeInsets.only(left: 15, right: 200),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: RichText(
                                  text: const TextSpan(
                                    children: [
                                      WidgetSpan(child: Icon(MaterialCommunityIcons.map_marker, size: 20),),
                                      TextSpan(
                                        text: "  재난위치  ",
                                      ),
                                      WidgetSpan(child: Icon(Icons.add, size: 20),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 260),
                              child: const Text(
                                "신고자 정보",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12,),
                            const SizedBox(
                              width: 300,
                              child: TextField(
                                obscureText: false,
                                maxLength: 20,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "이름",
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 300,
                              child: TextField(
                                obscureText: true,
                                maxLength: 20,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "전화번호",
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12,),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(250, 50),
                              ),
                              child: const Text(
                                "신고하기",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
