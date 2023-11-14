import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

bool _sos = false;

class Messenger extends StatefulWidget {
  const Messenger({Key? key}) : super(key: key);

  @override
  State<Messenger> createState() => _MessengerState();
}
class _MessengerState extends State<Messenger> {
  TextEditingController reportController = TextEditingController();
  TextEditingController attachmentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

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
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),

                SizedBox(height: 10.0),

                Text(
                  ' 신고내용',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: reportController,
                  decoration: InputDecoration(
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
                SizedBox(height: 5.0),
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
                    Text('음성통화 곤란 시 체크 (청각장애인,위험상황 등)'),
                  ],
                ),
                SizedBox(height: 10.0),

                Divider(
                  color: Colors.black,
                  height: 1.0,
                  thickness: 1.0,
                ),
                SizedBox(height: 20.0),
                Text(
                  ' 첨부파일',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10.0),
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


                SizedBox(height: 10.0),

                Row(
                  children: [
                    Text("  "),
                    Container(
                      width: 70.0,
                      height: 38.0,
                      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        shape: BoxShape.rectangle,
                        color: Colors.blue,
                      ),
                      child: PopupMenuButton<String>(
                        icon: Icon(
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
                          PopupMenuItem<String>(
                            value: '사진 찍기',
                            child: Text('사진 찍기', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold)),
                          ),
                          PopupMenuItem<String>(
                            value: '사진 갤러리',
                            child: Text('사진 갤러리', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),


                SizedBox(height: 15.0),

                Divider(
                  color: Colors.black,
                  height: 1.0,
                  thickness: 1.0,
                ),

                SizedBox(height: 20.0),

                Text(
                  ' 재난위치 확인',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 15.0),

                Row(
                  children: [
                    Text("  "),
                    ElevatedButton(
                      onPressed: () {
                        // 현재 위치 주소 확인 버튼이 클릭될 때 수행할 작업
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
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
                    SizedBox(width: 10.0),
                    Text("    "),
                    Text(
                      '현재 위치 주소',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),

                Divider(
                  color: Colors.black,
                  height: 1.0,
                  thickness: 1.0,
                ),

                SizedBox(height: 20.0),

                Text(
                  ' 신고자 정보',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 15.0),

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

                SizedBox(height: 15.0),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          submitReport(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
          Container(
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

    String smsMessage = '''
    신고 내용: $reportContent
    첨부 파일: $attachment
    이름: $name
    전화번호: $phoneNumber
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
}
