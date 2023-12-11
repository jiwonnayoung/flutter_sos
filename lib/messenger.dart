import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_sos/messenger_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool _sos = false;

class Messenger extends StatefulWidget {
  const Messenger({super.key});

  @override
  State<Messenger> createState() => _MessengerState();
}
class _MessengerState extends State<Messenger> {
  TextEditingController reportController = TextEditingController();
  TextEditingController attachmentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  MapSampleLocation mapSampleLocation = MapSampleLocation();

  String receivedAddress = '';


  LatLng? _currentPosition;

  final String targetPhoneNumber = '112';
  XFile? _image;
  final ImagePicker picker = ImagePicker();

  String selectedOption = '사진 찍기';
  late List<CameraDescription> cameras;
  late CameraController _cameraController;
  XFile? _imageFile;

  bool isCameraActive = false;

  @override
  void getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker. pickImage(source: imageSource);

    if(pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAddressFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 10.0),

                const Text(
                  ' 신고내용',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                TextField(
                  controller: reportController,
                  decoration: const InputDecoration(
                    labelText: '   신고 내용을 입력해주세요.',
                    hintText: '간략히 입력해주세요.',
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
                const SizedBox(height: 5.0),
                Row(
                  children: [
                    Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      value: _sos,
                      onChanged: (value) {
                        setState(() {
                          _sos = value!;
                        });
                      },
                    ),
                    const Text('음성통화 곤란 시 체크 (청각장애인,위험상황 등)'),
                  ],
                ),
                const SizedBox(height: 10.0),

                const Divider(
                  color: Colors.black,
                  height: 1.0,
                  thickness: 1.0,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  ' 첨부파일',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10.0),
                // TextFormField 위에 _buildPhotoArea() 추가
                Stack(
                  children: [
                    if (_image != null)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: _buildPhotoArea(),
                        ),
                      ),
                  ],
                ),


                const SizedBox(height: 10.0),

                Row(
                  children: [
                    const Text("  "),
                    Container(
                      width: 70.0,
                      height: 38.0,
                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        shape: BoxShape.rectangle,
                        color: Colors.blue,
                      ),
                      child: PopupMenuButton<String>(
                        icon: const Icon(
                          Icons.add,
                          size: 15.0,
                          color: Colors.black54,
                        ),
                        onSelected: (String value) {
                          setState(() {
                            selectedOption = value;
                            if (value == '사진 찍기') {
                              getImage(ImageSource.camera);
                            } else if (value == '사진 갤러리') {
                              getImage(ImageSource.gallery);
                            }
                          });
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: '사진 찍기',
                            child: Text('사진 찍기', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold)),
                          ),
                          const PopupMenuItem<String>(
                            value: '사진 갤러리',
                            child: Text('사진 갤러리', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 15.0),

                const Divider(
                  color: Colors.black,
                  height: 1.0,
                  thickness: 1.0,
                ),

                const SizedBox(height: 20.0),

                const Text(
                  ' 재난위치 확인',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15.0),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("  "),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MapSampleLocation()),
                            ); // 현재 위치 주소 확인 버튼이 클릭될 때 수행할 작업
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Text(
                              '+',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Text("    "),
                      ],
                    ),
                    Text(
                      '주소: $receivedAddress',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),




                const SizedBox(height: 15.0),

                const Divider(
                  color: Colors.black,
                  height: 1.0,
                  thickness: 1.0,
                ),

                const SizedBox(height: 20.0),


                const Text(
                  ' 신고자 정보',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15.0),

                Row(
                  children: [
                    const Text(
                      '이름       ',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(width: 10.0),
                    Flexible(
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
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

                const SizedBox(height: 15.0),

                Row(
                  children: [
                    const Text(
                      '전화번호',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(width: 10.0),
                    Flexible(
                      child: TextField(
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
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

                const SizedBox(height: 15.0),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          submitReport(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '신고하기',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoArea() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 70,
          height: 70,
          color: Colors.grey,
        ),
        if (_image != null)
          SizedBox(
            width: 300,
            height: 300,
            child: Image.file(File(_image!.path)),
          ),
      ],
    );
  }



  void submitReport(BuildContext context) {
    String reportContent = reportController.text;
    String attachment = _image != null ? _image!.path : '';
    String name = nameController.text;
    String phoneNumber = phoneNumberController.text;
    String sosMessage = _sos ? '음성통화 곤란' : '음성통화 가능';

    String smsMessage = '''
    신고 내용: $reportContent
    첨부 파일: $attachment
    이름: $name
    전화번호: $phoneNumber
    상황: $sosMessage
    주소: $receivedAddress
    ''';

    launchSMSApp(targetPhoneNumber, smsMessage);
  }

  void launchSMSApp(String phoneNumber, String message) async {
    String uri = 'sms:$phoneNumber?body=$message';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      print('Could not launch SMS app');
    }
  }

  void pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        // 선택된 이미지 파일을 사용하거나 업로드하는 등의 작업을 수행
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAddressFromFirestore() async {
    var result = await FirebaseFirestore.instance.collection('addresses').doc('location').get();

    if (result.exists) {
      dynamic data = result.data();

      // Check if 'address' field exists and is not null
      if (data != null && data.containsKey('address')) {
        String addressRaw = data['address'];

        // Remove the curly braces and whitespace from the addressRaw
        String address = addressRaw.replaceAll(RegExp(r'[{address: } ]'), '');

        // Print or use the 'address' variable as needed
        print("받은 주소: $address");

        // Update the state if necessary
        setState(() {
          receivedAddress = address;


        });
      } else {
        print("Firestore 데이터에서 'address' 필드가 존재하지 않거나 null입니다.");
      }
    } else {
      print("Firestore에 문서가 존재하지 않습니다.");
    }
  }



}