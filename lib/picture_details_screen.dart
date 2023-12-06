import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:firebase_storage/firebase_storage.dart';


class PictureDeatilsScreen extends StatefulWidget {
  final String name;
  final String image;
  final Color color;
  final String title;
  int? selectedRadio;
  bool radioButtonValue = false;
  bool isCheckboxChecked = false;
  bool isSelectedCrime = true;
  bool isSelectedFire = false;
  bool isSelectedEmergency = false;
  bool SelectedCrime = false;
  bool SelectedFire = false;
  bool SelectedEmergency = false;
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
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();


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

  List<String> imageUrls = [

  ];

  List<String> crimes = [
    'images/crime/crime1.jpg',
    'images/crime/crime2.jpg',
    'images/crime/crime3.jpg',
    'images/crime/crime4.jpg',
  ];
  List<String> fires = [
    'images/fire/fire1.jpg',
    'images/fire/fire2.jpg',
    'images/fire/fire3.jpg',
    'images/fire/fire4.jpg',
  ];
  List<String> emergencies = [
    'images/emergency/emer1.jpg',
    'images/emergency/emer2.jpg',
    'images/emergency/emer3.jpg',
    'images/emergency/emer4.jpg',
  ];


  List<String> selectText = [

  ];

  List<String> crimesText = [
    '누가 쫓아와요',
    '납치를 당했어요',
    '도둑이 들었어요',
    '누가 난동을 부려요',
  ];
  List<String> firesText = [
    '집에 불이 났어요',
    '산에 불이 났어요',
    '불이 났어요',
    '차에 불이 났어요',
  ];
  List<String> emergenciesText = [
    '응급환자가 있어요',
    '산에서 길 잃었어요',
    '큰 부상을 입었어요',
    '교통사고가 났어요',
  ];

  @override
  void initState() {
    super.initState();
    // 초기에 '범죄' 이미지를 보여주기 위해 SelectedOption 호출
    SelectedOption("범죄");
    SelectedText("범죄");
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
  void SelectedOption(String optionNum){
    setState(() {
      imageUrls = [];
      if(optionNum == "범죄") {
        imageUrls.addAll(crimes);
      }
      else if(optionNum == "화재"){
        imageUrls.addAll(fires);
      }
      else if(optionNum == "긴급/구조"){
        imageUrls.addAll(emergencies);
      }
    });
  }

  void SelectedText(String optionText){
    setState(() {
      selectText = [];
      if(optionText == "범죄") {
        selectText.addAll(crimesText);
      }
      else if(optionText == "화재"){
        selectText.addAll(firesText);
      }
      else if(optionText == "긴급/구조"){
        selectText.addAll(emergenciesText);
      }
    });
  }





  Widget buildImage(int imageIndex) {
    return FutureBuilder(
      future: FirebaseStorage.instance.ref(imageUrls[0]).getDownloadURL(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            return Image.network(
              snapshot.data!,
              width: 100,
              height: 100,
            );
          } else {
            return const Text("이미지를 찾을 수 없습니다.");
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget buildRadioButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 라디오 버튼 1
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              value: 1,
              groupValue: widget.selectedRadio,
              onChanged: (value) {
                setSelectedRadio(value!);
              },
            ),
            const Text(
              "라디오 버튼 1",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        // 라디오 버튼 2
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              value: 2,
              groupValue: widget.selectedRadio,
              onChanged: (value) {
                setSelectedRadio(value!);
              },
            ),
            const Text(
              "라디오 버튼 2",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPage(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return buildPageOne();
      case 1:
        return buildPageTwo();
    // 필요에 따라 더 많은 페이지를 추가할 수 있습니다.
      default:
        return Container();
    }
  }

  Widget buildPageOne() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: PageView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 페이지 1의 내용을 여기에 추가
              // 선택한 옵션에 따라 다르게 표시될 내용을 추가하세요.

              // 이미지 표시
              buildImage(0),

              // 라디오 버튼 표시
              buildRadioButtons(),
            ],
          );
        },
      ),
    );
  }

  Widget buildPageTwo() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: PageView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 페이지 2의 내용을 여기에 추가
              // 선택한 옵션에 따라 다르게 표시될 내용을 추가하세요.

              // 이미지 표시
              buildImage(1),

              // 라디오 버튼 표시
              buildRadioButtons(),
            ],
          );
        },
      ),
    );
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
                                        SelectedOption("범죄");
                                        SelectedText("범죄");
                                      });
                                      setState(() {
                                        List<String> crimes = [
                                          'images/fire/byo.jpg',
                                          'images/fire/fire3.jpg',
                                          'images/fire/fire.jpg',
                                          'images/fire/fire1.jpg',
                                        ];
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
                                        SelectedOption("화재");
                                        SelectedText("화재");
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
                                        SelectedOption("긴급/구조");
                                        SelectedText("긴급/구조");
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
                                                  FutureBuilder(
                                                    future: FirebaseStorage.instance.ref(imageUrls[0]).getDownloadURL(),
                                                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                      print ("Image URL: ${snapshot.data}");
                                                      if (snapshot.connectionState == ConnectionState.done) {

                                                        if(snapshot.data != null) {
                                                          return Image.network(
                                                            snapshot.data!,
                                                            width: 110,
                                                            height: 110,
                                                          );
                                                        } else {
                                                          return const Text ("이미지를 찾을 수 없습니다.");
                                                        }

                                                      } else {
                                                        return CircularProgressIndicator(); // 로딩 중 표시
                                                      }
                                                    },
                                                  ),

                                                  FutureBuilder(
                                                    future: FirebaseStorage.instance.ref(imageUrls[1]).getDownloadURL(),
                                                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                      if (snapshot.connectionState == ConnectionState.done) {

                                                        if(snapshot.data != null) {
                                                          return Image.network(
                                                            snapshot.data!,
                                                            width: 110,
                                                            height: 110,
                                                          );
                                                        } else {
                                                          return const Text ("이미지를 찾을 수 없습니다.");
                                                        }

                                                      } else {
                                                        return CircularProgressIndicator(); // 로딩 중 표시
                                                      }
                                                    },
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
                                                          Text(
                                                            (selectText?.isNotEmpty ?? false) ? selectText![0] : 'Default Text', // 첫 번째 라디오 버튼 옆에 나타낼 텍스트
                                                            style: TextStyle(fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 5,),
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
                                                          Text(
                                                            (selectText?.isNotEmpty ?? false) ? selectText![1] : 'Default Text', // 두 번째 라디오 버튼 옆에 나타낼 텍스트
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
                                                children: [
                                                  FutureBuilder(
                                                    future: FirebaseStorage.instance.ref(imageUrls[2]).getDownloadURL(),
                                                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                      if (snapshot.connectionState == ConnectionState.done) {

                                                        if(snapshot.data != null) {
                                                          return Image.network(
                                                            snapshot.data!,
                                                            width: 110,
                                                            height: 110,
                                                          );
                                                        } else {
                                                          return const Text ("이미지를 찾을 수 없습니다.");
                                                        }

                                                      } else {
                                                        return CircularProgressIndicator(); // 로딩 중 표시
                                                      }
                                                    },
                                                  ),

                                                  FutureBuilder(
                                                    future: FirebaseStorage.instance.ref(imageUrls[3]).getDownloadURL(),
                                                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                      if (snapshot.connectionState == ConnectionState.done) {

                                                        if(snapshot.data != null) {
                                                          return Image.network(
                                                            snapshot.data!,
                                                            width: 110,
                                                            height: 110,
                                                          );
                                                        } else {
                                                          return const Text ("이미지를 찾을 수 없습니다.");
                                                        }

                                                      } else {
                                                        return CircularProgressIndicator(); // 로딩 중 표시
                                                      }
                                                    },
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

                                                          Text(
                                                            (selectText?.isNotEmpty ?? false) ? selectText![2] : 'Default Text', // 첫 번째 라디오 버튼 옆에 나타낼 텍스트
                                                            style: TextStyle(fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 5,),
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
                                                          Text(
                                                            (selectText?.isNotEmpty ?? false) ? selectText![3] : 'Default Text', // 두 번째 라디오 버튼 옆에 나타낼 텍스트
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
                            Row(
                              children: [
                                Text(
                                  '이름       ',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                                SizedBox(width: 10.0),
                                Flexible(
                                  child: TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      labelText: '이름을 입력해주세요.',
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 15.0),

                            Row(
                              children: [
                                Text(
                                  '전화번호',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                                SizedBox(width: 10.0),
                                Flexible(
                                  child: TextField(
                                    controller: phoneNumberController,
                                    decoration: InputDecoration(
                                      labelText: '전화번호를 입력해주세요.',
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                    ),
                                    keyboardType: TextInputType.phone,
                                  ),
                                ),
                              ],
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