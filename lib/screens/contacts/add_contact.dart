import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';

import '../../global/custom_class.dart';
import 'contact_fetch_page.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage(this.contact);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController contactNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  FocusNode contactNameFCNode = FocusNode();
  FocusNode phoneNumberFCNode = FocusNode();
  FocusNode amountFCNode = FocusNode();
  FocusNode buildingNumberFCNode = FocusNode();
  FocusNode landmarkFCNode = FocusNode();
  FocusNode countryFCNode = FocusNode();
  FocusNode cityFCNode = FocusNode();
  FocusNode stateFCNode = FocusNode();
  FocusNode postalCodeFCNode = FocusNode();
  FocusNode saveFCNode = FocusNode();
  Color buttonBack1 = const Color(0xff3633A8);
  Color buttonBack2 = const Color(0xffC6DEFC);
  Color textColor1 = Colors.white;
  Color textColor2 = const Color(0xff3633A8);
  var photo = "";
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contactNameController.text = widget.contact.name.first;
    phoneNumberController.text = widget.contact.phones.isNotEmpty
        ? widget.contact.phones.first.number
        : '(none)';
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
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
            'Add Contacts',
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
                const SizedBox(
                  height: 12,
                ),
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
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ContactFetchPage()));
                    },
                    controller: contactNameController,
                    focusNode: contactNameFCNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(phoneNumberFCNode);
                    },
                    decoration: TextFieldDecoration.defUnderLine(context,
                        hintTextStr: "Contact Name"),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(9)),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                    onTap: () {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                    controller: phoneNumberController,
                    focusNode: phoneNumberFCNode,
                    decoration: TextFieldDecoration.defaultStyle(context,
                        hintTextStr: "Phone No"),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height /
                      15, //height of button
                  width: MediaQuery.of(context).size.width / 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height /
                            20, //height of button
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: textColor1,
                              backgroundColor: buttonBack1),
                          onPressed: () {
                            setState(() {
                              buttonBack1 = const Color(0xff3633A8);
                              buttonBack2 = const Color(0xffC6DEFC);
                              textColor1 = Colors.white;
                              textColor2 = const Color(0xff3633A8);
                              // buttonIndex = 1;
                            });
                            // ('Pprintressed');
                          },
                          child: const Text(
                            'Owes You',
                            style: TextStyle(
                                //    color: textColor1
                                ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height /
                            20, //height of button
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: textColor2,
                              backgroundColor: buttonBack2),
                          onPressed: () {
                            setState(() {
                              buttonBack2 = const Color(0xff3633A8);
                              buttonBack1 = const Color(0xffC6DEFC);
                              textColor2 = Colors.white;
                              textColor1 = const Color(0xff3633A8);
                              // buttonIndex = 2;
                            });
                          },
                          child: const Text(
                            'You Owe',
                            style: TextStyle(//color: textColor2
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(9)),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                    onTap: () {},
                    keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,8}')),
                    ],
                    controller: amountController,
                    focusNode: amountFCNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter amount';
                      }
                      return null;
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(buildingNumberFCNode);
                    },
                    decoration: TextFieldDecoration.defaultStyle(context,
                        hintTextStr: "Amount"),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "Address",
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(9)),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                    onTap: () {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter building no/name';
                      }
                      return null;
                    },
                    controller: buildingNumberController,
                    focusNode: buildingNumberFCNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(landmarkFCNode);
                    },
                    decoration: TextFieldDecoration.defaultStyle(context,
                        hintTextStr: "Building No/Name"),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(9)),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                    onTap: () {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter landmark';
                      }
                      return null;
                    },
                    controller: landmarkController,
                    focusNode: landmarkFCNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(countryFCNode);
                    },
                    decoration: TextFieldDecoration.defaultStyle(context,
                        hintTextStr: "Land mark"),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(9)),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                    onTap: () {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter country name';
                      }
                      return null;
                    },
                    controller: countryController,
                    focusNode: countryFCNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(stateFCNode);
                    },
                    decoration: TextFieldDecoration.defaultStyle(context,
                        hintTextStr: "Country"),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(9)),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                    onTap: () {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter state name';
                      }
                      return null;
                    },
                    controller: stateController,
                    focusNode: stateFCNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(postalCodeFCNode);
                    },
                    decoration: TextFieldDecoration.defaultStyle(context,
                        hintTextStr: "State/Province"),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(9)),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                    onTap: () {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter postal no';
                      }
                      return null;
                    },
                    controller: postalCodeController,
                    focusNode: postalCodeFCNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(saveFCNode);
                    },
                    decoration: TextFieldDecoration.defaultStyle(context,
                        hintTextStr: "Postal code"),
                  ),
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
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text("Enter something here to display on snack-bar")));
            } else {
              //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactListPage()));
            }
          },
        ),
      );
}
