import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';

import '../user_role/user_role_list.dart';

class AddNewUser extends StatefulWidget {
  @override
  State<AddNewUser> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddNewUser> {
  TextEditingController contactNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController userRoleController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var photo = "";
  bool _isHidden = false;
  bool imageSelect = false;
  File? imgFile;
  final imgPicker = ImagePicker();

  void openCamera() async {
    var imgCamera = await imgPicker.pickImage(source: ImageSource.camera);
    setState(() {
      imgFile = File(imgCamera!.path);
      imageSelect = true;
    });
  }

  void openGallery() async {
    var imgGallery = await imgPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgFile = File(imgGallery!.path);
      imageSelect = true;
    });
  }

  Widget displayImage() {
    return GestureDetector(
      onTap: () {
        showOptionsDialog(context);
        print(imgFile);
        print('........$imgFile');
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 12,
        width: MediaQuery.of(context).size.width / 20,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: imgFile == null
            ? const Text("No Image Selected!")
            : Image.file(
                imgFile!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: const Text("Camera"),
                    onTap: () {
                      openCamera();
                      Navigator.pop(context);
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: const Text(
                      "Gallery",
                    ),
                    onTap: () {
                      openGallery();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  loadImage(image) async {
    try {
      print('load image');
      final file = await getFileFromNetworkImage(image);
      setState(() {
        imageSelect = true;
        imgFile = file;
        print("Image file load image");
        print(imgFile?.path);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<File> getFileFromNetworkImage(String imageUrl) async {
    print('.........$imageUrl');
    var response = await http.get(Uri.parse(imageUrl));
    final documentDirectory = await getApplicationDocumentsDirectory();
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    File file = File(p.join(documentDirectory.path, '$fileName.png'));
    file.writeAsBytes(response.bodyBytes);
    return file;
  }

  final _formKey = GlobalKey<FormState>();
  var password;

  String generatePassword({
    bool letter = true,
    bool isNumber = true,
    bool isSpecial = true,
  }) {
    final length = 8;
    final letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    final letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final number = '0123456789';
    final special = '@#%^*>\$@?/[]=+';
    String chars = "";

    if (letter) chars += '$letterLowerCase$letterUpperCase';
    if (isNumber) chars += '$number';
    if (isSpecial) chars += '$special';

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff3633A8),
          ),
        ),
        title: const Text(
          'Add User',
          style: TextStyle(
              color: Color(0xff13213A),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffD5D5D5)),
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.width / 20,
                    child: imageSelect == true
                        ? displayImage()
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                showOptionsDialog(context);
                              });
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.grey,
                            ),
                          )),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                      controller: contactNameController,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffF3F7FC)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffF3F7FC)),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                                "assets/svg/phone_contact.svg"),
                          ),
                          contentPadding: const EdgeInsets.all(7),
                          hintText: "Contact name",
                          hintStyle: const TextStyle(color: Color(0xff778EB8)),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: const Color(0xffF3F7FC)))),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter phone no';
                        }
                        return null;
                      },
                      controller: phoneNoController,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffF3F7FC)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffF3F7FC)),
                          ),
                          contentPadding: EdgeInsets.all(7),
                          hintText: "Phone No",
                          hintStyle: TextStyle(color: Color(0xff778EB8)),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xffF3F7FC)))),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter user role';
                        }
                        return null;
                      },
                      onTap: () async {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UsersRoleList()),
                        );

                        if (result != null) {
                          setState(() {
                            userRoleController.text = result;
                          });
                        } else {}
                      },
                      controller: userRoleController,
                      readOnly: true,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffF3F7FC)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffF3F7FC)),
                          ),
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.all(7),
                          hintText: "User Role",
                          hintStyle: TextStyle(color: Color(0xff778EB8)),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xffF3F7FC)))),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffF3F7FC)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffF3F7FC)),
                          ),
                          contentPadding: EdgeInsets.all(7),
                          hintText: "Email Address",
                          hintStyle: TextStyle(color: Color(0xff778EB8)),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xffF3F7FC)))),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffF3F7FC)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffF3F7FC)),
                          ),
                          contentPadding: EdgeInsets.all(7),
                          hintText: "Username",
                          hintStyle: TextStyle(color: Color(0xff778EB8)),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xffF3F7FC)))),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: TextFormField(
                          controller: passwordController,
                          obscureText: _isHidden,
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xffF3F7FC)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xffF3F7FC)),
                              ),
                              contentPadding: const EdgeInsets.all(7),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isHidden = !_isHidden;
                                  });
                                },
                                child: Icon(
                                  _isHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: const Color(0xff5346BD),
                                ),
                              ),
                              hintText: "Password",
                              hintStyle: const TextStyle(color: Color(0xff778EB8)),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color(0xffF3F7FC)))),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                     // color: Color(0xffF3F7FC),
borderRadius: BorderRadius.circular(3)
                    ),
                    child: GestureDetector(
                      onTap: () {
                        password = generatePassword();
                      },
                      child: SvgPicture.asset("assets/svg/reload.svg"),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: GestureDetector(
        child: SvgPicture.asset('assets/svg/save.svg'),
        onTap: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Enter mandatory field")));
          } else {
            //  Navigator.of(context)
            //               .push(MaterialPageRoute(builder: (context) => IncomeList()));
          }
        },
      ),
    );
  }
}
