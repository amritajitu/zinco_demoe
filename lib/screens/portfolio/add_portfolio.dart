import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:intl/intl.dart';
import 'package:untitled3/screens/portfolio/reminder/list_reminder.dart';

import '../../global/custom_class.dart';
import '../../test.dart';
import 'detail/add_more.dart';
import 'detail/income_expense.dart';
import 'detail/selectType.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';

class AddPortfolio extends StatefulWidget {
  @override
  State<AddPortfolio> createState() => _AddPortfolioState();
}

class _AddPortfolioState extends State<AddPortfolio> {
  TextEditingController searchController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController assetNameController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  TextEditingController share1Controller = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController fieldNameController = TextEditingController();
  TextEditingController value1Controller = TextEditingController();

  Color buttonBack1 = const Color(0xff3633A8);
  Color buttonBack2 = const Color(0xffF1F1F1);
  Color textColor1 = Colors.white;
  Color textColor2 = const Color(0xff3633A8);
  Color borderColor1 = Colors.black;
  Color borderColor2 = Colors.transparent;
  DateTime selectedDateAndTime = DateTime.now();
  String _date = "DD/MM/YYYY";
  String dateFormat = "2022-01-01";
  var fromDate;
  var toDate;
  int buttonIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime dt = DateTime.now();
    TimeOfDay td = TimeOfDay.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(dt);
    _date = '$formatted';
    calenderController..text = _date;
    fromDate = _date;
    toDate = _date;
  }

  final _formKey = GlobalKey<FormState>();

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
  List<Widget> _cardList = [];
  void _addCardWidget() {
    setState(() {
      _cardList.add(_card());
    });
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
          'Add Asset',
          style: TextStyle(
              color: Color(0xff13213A),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ReminderList()));
                },
                child: const Text(
                  "Reminder",
                  style: TextStyle(color: Color(0xff8265DE)),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 4,
          ),
          const Icon(
            Icons.edit,
            color: Colors.black,
          ),
          const SizedBox(
            width: 4,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9)),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: textColor1,
                              backgroundColor: buttonBack1),
                          onPressed: () {
                            setState(() {
                              buttonBack1 = const Color(0xff3633A8);
                              buttonBack2 = const Color(0xffF1F1F1);
                              textColor1 = Colors.white;
                              textColor2 = const Color(0xff3633A8);
                              buttonIndex = 1;
                            });
                            // ('Pprintressed');
                          },
                          child: const Text(
                            'Details',
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9)),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: textColor2,
                              backgroundColor: buttonBack2),
                          onPressed: () {
                            Data.isEdit == true
                                ? setState(() {
                                    buttonBack2 = const Color(0xff3633A8);
                                    buttonBack1 = const Color(0xffF1F1F1);
                                    textColor2 = Colors.white;
                                    textColor1 = const Color(0xff3633A8);
                                    buttonIndex = 2;
                                  })
                                : setState(() {
                                    buttonBack1 = const Color(0xff3633A8);
                                    buttonBack2 = const Color(0xffF1F1F1);
                                    textColor1 = Colors.white;
                                    textColor2 = const Color(0xff3633A8);
                                    buttonIndex = 1;
                                  });
                          },
                          child: const Text(
                            'Finance',
                            style: TextStyle(//color: textColor2
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                buttonIndex == 1
                    ? Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.height / 1.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF3F7FC),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height:
                                        MediaQuery.of(context).size.height / 7,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
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
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF3F7FC),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height:
                                        MediaQuery.of(context).size.height / 7,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
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
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              // height: MediaQuery.of(context).size.height / 18,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter name';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  controller: assetNameController,
                                  decoration: TextFieldDecoration.defaultStyle(
                                      context,
                                      hintTextStr: "Asset name"))),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              // height: MediaQuery.of(context).size.height / 20,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                  onTap: () async {
                                    var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SelectType()),
                                    );

                                    print(result);

                                    if (result != null) {
                                      setState(() {
                                        typeController.text = result;
                                      });
                                    } else {}
                                  },
                                  controller: typeController,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                      contentPadding: EdgeInsets.all(7),
                                      // labelText: labelText,
                                      //labelStyle: TextStyleDecoration.red(context),
                                      hintText: "Type",
                                      hintStyle:
                                          TextStyle(color: Color(0xff778EB8)),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Color(0xffF3F7FC)))),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  width: 20,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffF3F7FC),
                                      shape: BoxShape.circle),
                                  child: const Center(child: Text("1"))),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.2,
                                //    height: MediaQuery.of(context).size.height / 20,
                                child: TextFormField(
                                  controller: calenderController,
                                  readOnly: true,
                                  style:
                                      const TextStyle(color: Color(0xff878787)),
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      border: const OutlineInputBorder(),
                                      labelText: "",
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                            "assets/svg/calender.svg"),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xffF3F7FC)),
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          ///

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  //  height: MediaQuery.of(context).size.height / 20,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter name';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      controller: share1Controller,
                                      decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffF3F7FC)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffF3F7FC)),
                                          ),
                                          contentPadding: EdgeInsets.all(7),
                                          hintText: "Share %",
                                          hintStyle: TextStyle(
                                              color: Color(0xff000000)),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: Color(0xffF3F7FC)))),
                              SizedBox(
                                  //   height: MediaQuery.of(context).size.height / 20,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a value';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      controller: valueController,
                                      decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffF3F7FC)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xffF3F7FC)),
                                          ),
                                          contentPadding: EdgeInsets.all(7),
                                          hintText: "Value",
                                          hintStyle: TextStyle(
                                              color: Color(0xff000000)),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: Color(0xffF3F7FC)))),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // demoData(),
                          Data.isEdit == true
                              ? Column(
                                  children: [
                                    ///limitedbox
                                    ConstrainedBox(
                                      constraints: const BoxConstraints.expand(
                                        height: 200,
                                      ),
                                      child: ListView.builder(
                                          itemCount: 13,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            20,
                                                        width: 20,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Color(
                                                                    0xffF3F7FC),
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: Center(
                                                            child: Text(
                                                                "$index"))),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.3,
                                                      // height:  MediaQuery.of(context).size.height /20,
                                                      child: TextField(
                                                        controller:
                                                            calenderController,
                                                        readOnly: true,
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xff878787)),
                                                        decoration:
                                                            InputDecoration(
                                                                focusedBorder:
                                                                    const OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              3)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xffF3F7FC)),
                                                                ),
                                                                enabledBorder:
                                                                    const OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              3)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xffF3F7FC)),
                                                                ),
                                                                border:
                                                                    const OutlineInputBorder(),
                                                                labelText: "",
                                                                prefixIcon:
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: SvgPicture
                                                                      .asset(
                                                                          "assets/svg/calender.svg"),
                                                                ),
                                                                filled: true,
                                                                fillColor:
                                                                    const Color(
                                                                        0xffF3F7FC)),
                                                        onTap: () {
                                                          _selectDate(context);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                        //height: MediaQuery.of(context)      .size .height / 20,
                                                        width:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2.3,
                                                        child: TextFormField(
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return 'Please enter name';
                                                              }
                                                              return null;
                                                            },
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            controller:
                                                                share1Controller,
                                                            decoration:
                                                                const InputDecoration(
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(4)),
                                                                      borderSide: BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xffF3F7FC)),
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(4)),
                                                                      borderSide: BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xffF3F7FC)),
                                                                    ),
                                                                    contentPadding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                7),
                                                                    hintText:
                                                                        "Share %",
                                                                    hintStyle: TextStyle(
                                                                        color: Color(
                                                                            0xff000000)),
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Color(
                                                                            0xffF3F7FC)))),
                                                    SizedBox(
                                                        //height: MediaQuery.of(context).size.height /20,
                                                        width:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2.3,
                                                        child: TextFormField(
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return 'Please enter a value';
                                                              }
                                                              return null;
                                                            },
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            controller:
                                                                valueController,
                                                            decoration:
                                                                const InputDecoration(
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(4)),
                                                                      borderSide: BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xffF3F7FC)),
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(4)),
                                                                      borderSide: BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xffF3F7FC)),
                                                                    ),
                                                                    contentPadding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                7),
                                                                    hintText:
                                                                        "Value",
                                                                    hintStyle: TextStyle(
                                                                        color: Color(
                                                                            0xff000000)),
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Color(
                                                                            0xffF3F7FC)))),
                                                  ],
                                                ),
                                              ],
                                            );
                                          }),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20, //height of button
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9)),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            foregroundColor:
                                                const Color(0xffC6DEFC),
                                            backgroundColor:
                                                const Color(0xff3633A8)),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddMorePage()));
                                        },
                                        child: const Text(
                                          'Invest More',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )
                              : Container(),

                          ListTile(
                            tileColor: const Color(0xffF3F7FC),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Total Share %",
                                      style: TextStyle(
                                          color: Color(0xff778EB8),
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "100 %",
                                      style: TextStyle(fontSize: 13),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Total Spend",
                                      style: TextStyle(
                                          color: Color(0xff778EB8),
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "138.989",
                                      style: TextStyle(fontSize: 13),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text("Address"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                              //   height: MediaQuery.of(context).size.height / 20,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                  controller: buildingController,

                                  // style: TextStyle(
                                  //     color: Repository.textColor(context),fontSize: 13),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      contentPadding: EdgeInsets.all(7),
                                      // labelText: labelText,
                                      //labelStyle: TextStyleDecoration.red(context),
                                      hintText: "Building No/Name",
                                      hintStyle:
                                          TextStyle(color: Color(0xff778EB8)),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Color(0xffF3F7FC)))),
                          const SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                              //   height: MediaQuery.of(context).size.height / 20,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                  controller: landMarkController,

                                  // style: TextStyle(
                                  //     color: Repository.textColor(context),fontSize: 13),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      contentPadding: EdgeInsets.all(7),
                                      // labelText: labelText,
                                      //labelStyle: TextStyleDecoration.red(context),
                                      hintText: "Landmark",
                                      hintStyle:
                                          TextStyle(color: Color(0xff778EB8)),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Color(0xffF3F7FC)))),
                          const SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                              //   height: MediaQuery.of(context).size.height / 20,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                  controller: countryController,

                                  // style: TextStyle(
                                  //     color: Repository.textColor(context),fontSize: 13),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      contentPadding: EdgeInsets.all(7),
                                      // labelText: labelText,
                                      //labelStyle: TextStyleDecoration.red(context),
                                      hintText: "Country",
                                      hintStyle:
                                          TextStyle(color: Color(0xff778EB8)),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Color(0xffF3F7FC)))),
                          const SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                              //   height: MediaQuery.of(context).size.height / 20,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                  controller: cityController,

                                  // style: TextStyle(
                                  //     color: Repository.textColor(context),fontSize: 13),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      contentPadding: EdgeInsets.all(7),
                                      // labelText: labelText,
                                      //labelStyle: TextStyleDecoration.red(context),
                                      hintText: "City",
                                      hintStyle:
                                          TextStyle(color: Color(0xff778EB8)),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Color(0xffF3F7FC)))),
                          const SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                              //   height: MediaQuery.of(context).size.height / 20,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                  controller: stateController,

                                  // style: TextStyle(
                                  //     color: Repository.textColor(context),fontSize: 13),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      contentPadding: EdgeInsets.all(7),
                                      // labelText: labelText,
                                      //labelStyle: TextStyleDecoration.red(context),
                                      hintText: "State/Province",
                                      hintStyle:
                                          TextStyle(color: Color(0xff778EB8)),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Color(0xffF3F7FC)))),
                          const SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                              //   height: MediaQuery.of(context).size.height / 20,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                  controller: postalCodeController,

                                  // style: TextStyle(
                                  //     color: Repository.textColor(context),fontSize: 13),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xffF3F7FC)),
                                      ),
                                      contentPadding: EdgeInsets.all(7),
                                      // labelText: labelText,
                                      //labelStyle: TextStyleDecoration.red(context),
                                      hintText: "Postal Code",
                                      hintStyle:
                                          TextStyle(color: Color(0xff778EB8)),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Color(0xffF3F7FC)))),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                const Text(
                                  "Custom Properties",
                                  style: TextStyle(fontSize: 16),
                                ),
                                GestureDetector(
                                    onTap: _addCardWidget,

                                    child: const Text(
                                      "Add Field",
                                      style: TextStyle(
                                          color: Color(0xff8265DE), fontSize: 13),
                                    ),
                                )

                              ],
                            ),
                          )
                          ,
                          const SizedBox(height: 10,),
                          ///constraint box
                          Container(
                            width: MediaQuery.of(context).size.width/1.1,
                            height: MediaQuery.of(context).size.height/7,

                               color: Color(0xffF1F1F1),
                          child:_cardList.isEmpty?Container(
                            width: MediaQuery.of(context).size.width/1.1,
                            height: MediaQuery.of(context).size.height/7,

                            color: Color(0xffF1F1F1),
                            child: Column(
                              children:  [
                                const SizedBox(height: 10,),

                                Container(
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width/1.2,

                                  height: MediaQuery.of(context).size.height/20,
                                  child: TextFormField(

                                      controller: fieldNameController,
                                      decoration: TextFieldDecoration.defaultStyle(context,hintTextStr: "Field name")),
                                ),
                                const SizedBox(height: 11,),
                                Container(
                                  height: MediaQuery.of(context).size.height/20,
                                  width: MediaQuery.of(context).size.width/1.2,
                                  color: Colors.white,

                                  child: TextFormField(

                                      controller: value1Controller,
                                      decoration: TextFieldDecoration.defaultStyle(context,hintTextStr: "Value")),
                                ),
                                const SizedBox(height: 8,),

                              ],
                            ),
                          ): ListView.builder(
                                itemCount: _cardList.length,
                                itemBuilder: (context,index){
                                  return _cardList[index];
                                }),
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                const Text(
                                  "Documents",
                                  style: TextStyle(fontSize: 16),
                                ),
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: const Text(
                                    "Upload Documents",
                                    style: TextStyle(
                                        color: Color(0xff8265DE), fontSize: 13),
                                  ),
                                )

                              ],
                            ),
                          )
                          ,
                          const SizedBox(height: 30,),

                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffDEDEDE), width: 1),
                              ),
                            ),
                            height: MediaQuery.of(context).size.height /
                                17, //height of button
                            width: MediaQuery.of(context).size.width / 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      borderColor1 = Colors.black;
                                      borderColor2 = Colors.transparent;
                                      Data.isChoose = false;
                                    });
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: borderColor1, width: 3),
                                      ),
                                    ),
                                    child: const Center(child: Text("Income")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      borderColor1 = Colors.transparent;
                                      borderColor2 = Colors.black;
                                      Data.isChoose = true;
                                    });
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: borderColor2, width: 3),
                                      ),
                                    ),
                                    child:
                                        const Center(child: Text("Expenses")),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Data.isChoose == true
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Transactions",
                                          style: TextStyle(
                                              color: Color(0xff13213A),
                                              fontSize: 18),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              20,
                                          // width: MediaQuery.of(context).size.width/2.3,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff040404),
                                              borderRadius:
                                                  BorderRadius.circular(23)),
                                          child: Row(
                                            children: [
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        Colors.transparent),
                                                onPressed: () {
                                                  _selectDate(context);
                                                },
                                                child: Text(
                                                  fromDate,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              const Text(
                                                "-",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        Colors.transparent),
                                                onPressed: () {
                                                  _selectDate(context);
                                                },
                                                child: Text(
                                                  toDate,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: ListView.builder(
                                          itemCount: 2,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ListTile(
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Color(0xffDEDEDE),
                                                      width: .5),
                                                  borderRadius:
                                                      BorderRadius.circular(1)),
                                              tileColor:
                                                  const Color(0xffFFFFFF),
                                              title: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    "21 Feb 2023, 10:00 AM",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff8D8D8D)),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  )
                                                ],
                                              ),
                                              subtitle: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            14,
                                                        child: const Text(
                                                          "From:",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff3633A8),
                                                              fontSize: 11),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 6),
                                                        child: Text(
                                                          "Cash in Hand",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff000000),
                                                              fontSize: 11),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                14,
                                                            child: const Text(
                                                              "To:",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff3633A8),
                                                                  fontSize: 11),
                                                            ),
                                                          ),
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 6),
                                                            child: Text(
                                                              "Food",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontSize: 11),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const Text(
                                                        "Rs. 1000.00",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              trailing: SvgPicture.asset(
                                                  "assets/svg/options.svg"),
                                            );
                                          }),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Transactions",
                                          style: TextStyle(
                                              color: Color(0xff13213A),
                                              fontSize: 18),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              20,
                                          // width: MediaQuery.of(context).size.width/2.3,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff040404),
                                              borderRadius:
                                                  BorderRadius.circular(23)),
                                          child: Row(
                                            children: [
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        Colors.transparent),
                                                onPressed: () {
                                                  _selectDate(context);
                                                },
                                                child: Text(
                                                  fromDate,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              const Text(
                                                "-",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        Colors.transparent),
                                                onPressed: () {
                                                  _selectDate(context);
                                                },
                                                child: Text(
                                                  toDate,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: ListView.builder(
                                          itemCount: 2,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ListTile(
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Color(0xffDEDEDE),
                                                      width: .5),
                                                  borderRadius:
                                                      BorderRadius.circular(1)),
                                              tileColor:
                                                  const Color(0xffFFFFFF),
                                              title: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    "21 Feb 2023, 10:00 AM",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff8D8D8D)),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  )
                                                ],
                                              ),
                                              subtitle: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            14,
                                                        child: const Text(
                                                          "From:",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff3633A8),
                                                              fontSize: 11),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 6),
                                                        child: Text(
                                                          "Cash in Hand",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff000000),
                                                              fontSize: 11),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                14,
                                                            child: const Text(
                                                              "To:",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff3633A8),
                                                                  fontSize: 11),
                                                            ),
                                                          ),
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 6),
                                                            child: Text(
                                                              "Food",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontSize: 11),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const Text(
                                                        "Rs. 1000.00",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              trailing: SvgPicture.asset(
                                                  "assets/svg/options.svg"),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: buttonIndex == 1
          ? GestureDetector(
              child: SvgPicture.asset('assets/svg/save.svg'),

        onTap: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Enter mandatory fields")));
                }
              },
            )
          : Container(
              color: const Color(0xffF3F7FC),
              height: MediaQuery.of(context).size.height / 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/svg/export.svg"),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          "Export",
                          style: TextStyle(color: Color(0xff000000)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    height: 33.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.0),
                        color: const Color(0xff3633A8)),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IncomeAddPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          Text('Add'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),


    );


  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.grey,
              splashColor: Colors.black,
              textTheme: const TextTheme(
                titleMedium: TextStyle(color: Colors.black),
                labelLarge: TextStyle(color: Colors.black),
              ),
              colorScheme: const ColorScheme.light(
                  primary: Color(0xff3633A8),
                  onSecondary: Colors.black,
                  onPrimary: Colors.white,
                  surface: Colors.black,
                  onSurface: Colors.black,
                  secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
            ),
            child: child ?? const Text(""),
          );
        },
        initialDate: selectedDateAndTime,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateAndTime) {
      setState(() {
        selectedDateAndTime = picked;
        print("picked time ${selectedDateAndTime}");
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        final DateFormat formatter1 = DateFormat('yyyy-MM-dd');

        var formattedDate = formatter.format(selectedDateAndTime);
        _date = "$formattedDate";
        dateFormat = formatter1.format(selectedDateAndTime);
        calenderController.text = _date;
        fromDate = _date;
        toDate = _date;
      });
    }
  }
  Widget _card() {
    return Container(
      width: MediaQuery.of(context).size.width/1.1,
      height: MediaQuery.of(context).size.height/7,

      color: Color(0xffF1F1F1),
      child: Column(
        children:  [
          const SizedBox(height: 10,),

          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width/1.2,

            height: MediaQuery.of(context).size.height/20,
            child: TextFormField(

                controller: fieldNameController,
                decoration: TextFieldDecoration.defaultStyle(context,hintTextStr: "Field name")),
          ),
          const SizedBox(height: 11,),
          Container(
            height: MediaQuery.of(context).size.height/20,
            width: MediaQuery.of(context).size.width/1.2,
            color: Colors.white,

            child: TextFormField(

                controller: value1Controller,
                decoration: TextFieldDecoration.defaultStyle(context,hintTextStr: "Value")),
          ),
          const SizedBox(height: 8,),

        ],
      ),
    );
  }
}

class Data {
  static bool isEdit = false;
  static bool isChoose = false;
}
