import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled3/screens/contacts/contact_list_page.dart';
import 'package:untitled3/screens/portfolio/add_portfolio.dart';
import 'package:untitled3/screens/settings/account/add_account.dart';
import 'package:untitled3/screens/settings/country/country_list.dart';
import 'package:untitled3/screens/settings/user_role/user_role_list.dart';
import 'package:untitled3/screens/settings/users/users.dart';
import 'package:untitled3/screens/transactions/add_transaction.dart';
import 'package:untitled3/screens/transactions/transaction_list.dart';

import 'contacts/add_contact.dart';
import 'expenses/add_expense.dart';
import 'expenses/list_expenses.dart';
import 'income/add_income.dart';
import 'income/income_list.dart';
import 'loans/add_loans.dart';
import 'loans/loans_list.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {
  int dashIndex = 1;
  Color tabIcon1 = const Color(0xff9974EF);
  Color tabIcon2 = Colors.transparent;
  Color tabIcon3 = Colors.transparent;
  Color tabIcon4 = Colors.transparent;
  Color tabIcon5 = Colors.transparent;
  Color gradient1 = const Color(0xff3633A8);
  Color gradient2 = Colors.transparent;
  Color gradient3 = Colors.transparent;
  Color gradient4 = Colors.transparent;
  Color gradient5 = Colors.transparent;

  Color iconColor1 = Colors.white;
  Color iconColor2 = Colors.grey;
  Color iconColor3 = Colors.grey;
  Color iconColor4 = Colors.grey;
  Color iconColor5 = Colors.grey;
  bool status = false;
  bool intrest = false;
  bool zakath = false;
  bool imageSelect = false;
  File? imgFile;
  final imgPicker = ImagePicker();
  var photo = "";

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
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffD5D5D5)),
            // color: Colors.white,
            //shape: BoxShape.circle,
            borderRadius: const BorderRadius.all(Radius.circular(80))),
        height: MediaQuery.of(context).size.height / 12,
        width: MediaQuery.of(context).size.width / 20,
        child: imgFile == null
            ? const Text("No Image Selected!")
            : Image.file(
                imgFile!,
                fit: BoxFit.cover,
              ),
      ),
    );
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

  Future<File> getFileFromNetworkImage(String imageUrl) async {
    print('.........$imageUrl');
    var response = await http.get(Uri.parse(imageUrl));
    final documentDirectory = await getApplicationDocumentsDirectory();
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    File file = File(p.join(documentDirectory.path, '$fileName.png'));
    file.writeAsBytes(response.bodyBytes);
    return file;
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xffffffff),
      resizeToAvoidBottomInset: false,
      appBar: getAppbar(dashIndex),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: getPageDisplay(dashIndex),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: GestureDetector(
          child: SvgPicture.asset('assets/svg/edit.svg'),
          onTap: () {},
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height / 10,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
          //   border: Border(top: BorderSide(color: Colors.grey, width: 5)),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          // borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [tabIcon1, gradient1],
                    ),
                    shape: BoxShape.circle),
                child: AspectRatio(
                  aspectRatio: .5,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        dashIndex = 1;
                        bottomBarColor(dashIndex);
                        bottomBarIconColor(dashIndex);
                      });
                    },
                    icon: SvgPicture.asset(
                      'assets/svg/dashboard.svg',
                      height: 15,
                      width: 15,
                      color: iconColor1,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [tabIcon2, gradient2],
                    ),
                    shape: BoxShape.circle),
                child: AspectRatio(
                  aspectRatio: .5,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        dashIndex = 2;
                        bottomBarColor(dashIndex);
                        bottomBarIconColor(dashIndex);
                      });
                    },
                    icon: SvgPicture.asset(
                      'assets/svg/menu.svg',
                      height: 15,
                      width: 15,
                      color: iconColor2,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [tabIcon3, gradient3],
                    ),
                    shape: BoxShape.circle),
                child: AspectRatio(
                    aspectRatio: .5,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          dashIndex = 3;
                          bottomBarColor(dashIndex);
                          bottomBarIconColor(dashIndex);
                        });
                      },
                      icon: SvgPicture.asset(
                        'assets/svg/portfolio.svg',
                        height: 15,
                        width: 15,
                        color: iconColor3,
                      ),
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [tabIcon4, gradient4],
                    ),
                    shape: BoxShape.circle),
                child: AspectRatio(
                    aspectRatio: .5,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          dashIndex = 4;
                          bottomBarColor(dashIndex);
                          bottomBarIconColor(dashIndex);
                        });
                      },
                      icon: SvgPicture.asset(
                        'assets/svg/notification.svg',
                        height: 15,
                        width: 15,
                        color: iconColor4,
                      ),
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [tabIcon5, gradient5],
                    ),
                    shape: BoxShape.circle),
                child: AspectRatio(
                    aspectRatio: .5,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          dashIndex = 5;
                          bottomBarColor(dashIndex);
                          bottomBarIconColor(dashIndex);
                        });
                      },
                      icon: SvgPicture.asset(
                        'assets/svg/settings.svg',
                        height: 15,
                        width: 15,
                        color: iconColor5,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  bottomBarColor(int iconColor) {
    if (iconColor == 1) {
      tabIcon1 = const Color(0xff9974EF);
      tabIcon2 = Colors.transparent;
      tabIcon3 = Colors.transparent;
      tabIcon4 = Colors.transparent;
      tabIcon5 = Colors.transparent;
      gradient1 = const Color(0xff3633A8);
      gradient2 = Colors.transparent;
      gradient3 = Colors.transparent;
      gradient4 = Colors.transparent;
      gradient5 = Colors.transparent;
    } else if (iconColor == 2) {
      tabIcon1 = Colors.transparent;
      tabIcon2 = const Color(0xff9974EF);
      tabIcon3 = Colors.transparent;
      tabIcon4 = Colors.transparent;
      tabIcon5 = Colors.transparent;
      gradient2 = const Color(0xff3633A8);
      gradient1 = Colors.transparent;
      gradient3 = Colors.transparent;
      gradient4 = Colors.transparent;
      gradient5 = Colors.transparent;
    } else if (iconColor == 3) {
      tabIcon1 = Colors.transparent;
      tabIcon2 = Colors.transparent;
      tabIcon3 = const Color(0xff9974EF);
      tabIcon4 = Colors.transparent;
      tabIcon5 = Colors.transparent;
      gradient3 = const Color(0xff3633A8);
      gradient2 = Colors.transparent;
      gradient1 = Colors.transparent;
      gradient4 = Colors.transparent;
      gradient5 = Colors.transparent;
    } else if (iconColor == 4) {
      tabIcon1 = Colors.transparent;
      tabIcon2 = Colors.transparent;
      tabIcon3 = Colors.transparent;
      tabIcon4 = const Color(0xff9974EF);
      tabIcon5 = Colors.transparent;
      gradient4 = const Color(0xff3633A8);
      gradient2 = Colors.transparent;
      gradient3 = Colors.transparent;
      gradient1 = Colors.transparent;
      gradient5 = Colors.transparent;
    } else if (iconColor == 5) {
      tabIcon1 = Colors.transparent;
      tabIcon2 = Colors.transparent;
      tabIcon3 = Colors.transparent;
      tabIcon4 = Colors.transparent;
      tabIcon5 = const Color(0xff9974EF);
      gradient5 = const Color(0xff3633A8);
      gradient2 = Colors.transparent;
      gradient3 = Colors.transparent;
      gradient4 = Colors.transparent;
      gradient1 = Colors.transparent;
    }
  }

  bottomBarIconColor(int iconColor) {
    if (iconColor == 1) {
      iconColor1 = Colors.white;
      iconColor2 = Colors.grey;
      iconColor3 = Colors.grey;
      iconColor4 = Colors.grey;
      iconColor5 = Colors.grey;
    } else if (iconColor == 2) {
      iconColor1 = Colors.grey;
      iconColor2 = Colors.white;
      iconColor3 = Colors.grey;
      iconColor4 = Colors.grey;
      iconColor5 = Colors.grey;
    } else if (iconColor == 3) {
      iconColor1 = Colors.grey;
      iconColor2 = Colors.grey;
      iconColor3 = Colors.white;
      iconColor4 = Colors.grey;
      iconColor5 = Colors.grey;
    } else if (iconColor == 4) {
      iconColor1 = Colors.grey;
      iconColor2 = Colors.grey;
      iconColor3 = Colors.grey;
      iconColor4 = Colors.white;
      iconColor5 = Colors.grey;
    } else if (iconColor == 5) {
      iconColor1 = Colors.grey;
      iconColor2 = Colors.grey;
      iconColor3 = Colors.grey;
      iconColor4 = Colors.grey;
      iconColor5 = Colors.white;
    }
  }

  getPageDisplay(int iconColor) {
    if (iconColor == 1) {
      return Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Bank Accounts",
                    style: TextStyle(color: Color(0xff5C4CC3)),
                  ),
                  Text(
                    "Rs. 24355+ ",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 140,
              child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            left: 6, right: 6, top: 15, bottom: 0),
                        child: Container(
                          width: 200,
                          height: 150,
                          //BoxDecoration Widget
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xff3633A8), Color(0xff328DAA)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 5),
                                    child: Text(
                                      "SBI",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 5),
                                    child: Text(
                                      "Balance",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 3),
                                    child: Text(
                                      "Rs. 400000",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 5),
                                    child: Text(
                                      "Zakath",
                                      style:
                                          TextStyle(color: Color(0xff00FF22)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Text(
                                      "Rs. 40000",
                                      style: TextStyle(
                                          color: Colors.blue.shade300),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: .5)),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(""),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 5),
                                    child: Text(
                                      "Usable",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 5),
                                    child: Text(
                                      "Rs. 400000",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 5),
                                    child: Text(
                                      "Intrest",
                                      style: TextStyle(
                                          color: Colors.blue.shade300),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8, bottom: 5),
                                    child: Text(
                                      "Rs. 40000",
                                      style: TextStyle(
                                          color: Colors.blue.shade300),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
                  }),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Cash Accounts",
                    style: TextStyle(color: Color(0xff5C4CC3)),
                  ),
                  Text(
                    "Rs. 24355+ ",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            Container(
              height: 140,
              child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            left: 6, right: 6, top: 15, bottom: 0),
                        child: Container(
                          width: 200,
                          height: 140,
                          //BoxDecoration Widget
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xff246D80), Color(0xff00A18B)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8),
                                child: Text(
                                  "Cash",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 8.0, right: 8, top: 6),
                                child: Text(
                                  "Balance",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 8.0, right: 8, top: 6),
                                child: Text(
                                  "Rs. 400000",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, top: 6),
                                child: Text(
                                  "Zakath",
                                  style:
                                      TextStyle(color: Colors.green.shade300),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, top: 6),
                                child: Text(
                                  "Rs. 40000",
                                  style: TextStyle(color: Colors.blue.shade300),
                                ),
                              ),
                            ],
                          ),
                        ));
                  }),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 6.0, right: 6, top: 8),
              child: ListTile(
                tileColor: Color(0xffF3F7FC),
                title: Text(
                  "Zakath Balance",
                  style: TextStyle(color: Color(0xff00744C)),
                ),
                trailing: Text(
                  "Rs.40000",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 90,
                    //BoxDecoration Widget
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F7FC),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Receivable",
                            style: TextStyle(color: Color(0xff1F7682)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Rs. 40000",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F7FC),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Payable",
                            style: TextStyle(color: Color(0xffC34C4C)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Rs. 40000",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else if (iconColor == 2) {
      return Column(
        children: [
          ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: const Color(0xffEFEFEF),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    "assets/svg/contact.svg",
                  ),
                ),
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ContactListPage()));
                },
                child: const Text(
                  "Contacts",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              trailing: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ContactPage(Contact())));
                },
                child: SvgPicture.asset("assets/svg/plus_circle.svg"),
              )),
          ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: const Color(0xffEFEFEF),
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset("assets/svg/cash-outline.svg"),
              ),
            ),
            title: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ExpenseList()));
              },
              child: const Text(
                "Expenses",
                style: TextStyle(color: Colors.black),
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddExpensePage()));
              },
              child: SvgPicture.asset("assets/svg/plus_circle.svg"),
            ),
          ),
          ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: const Color(0xffEFEFEF),
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset("assets/svg/cash.svg"),
              ),
            ),
            title: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => IncomeList()));
              },
              child: const Text(
                "Income",
                style: TextStyle(color: Colors.black),
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddIncomePage()));
              },
              child: SvgPicture.asset("assets/svg/plus_circle.svg"),
            ),
          ),
          ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: const Color(0xffEFEFEF),
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset("assets/svg/loan.svg"),
              ),
            ),
            title: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoanList()));
              },
              child: Text(
                "Loans",
                style: TextStyle(color: Colors.black),
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddLoanPage()));
              },
              child: SvgPicture.asset("assets/svg/plus_circle.svg"),
            ),
          ),
          ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: const Color(0xffEFEFEF),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset("assets/svg/transaction.svg"),
                ),
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TransactionList()));
                },
                child: const Text(
                  "Transaction",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              trailing: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddTransaction()));
                },
                child: SvgPicture.asset("assets/svg/plus_circle.svg"),
              )),
        ],
      );
    } else if (iconColor == 3) {
      return Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(9)),
              height: MediaQuery.of(context).size.height / 20,
              width: MediaQuery.of(context).size.width / 1.1,
              child: TextField(
                onChanged: (text) {},
                onTap: () {},
                controller: searchController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(6),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xffF3F7FC)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xffF3F7FC)),
                    ),
                    hintText: "Search",
                    //  hintStyle: TextStyleDecoration.grey(context),
                    fillColor: Color(0xffF3F7FC),
                    filled: true),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.4,
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        onTap: () {
                          Data.isEdit = true;

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddPortfolio()));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        tileColor: const Color(0xffF3F7FC),
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'https://picsum.photos/250?image=0'),
                                fit: BoxFit.cover,
                              ),
                              color: const Color(0xffEFEFEF),
                              borderRadius: BorderRadius.circular(2),
                              shape: BoxShape.rectangle),
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Asset Name",
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              "Type",
                              style: TextStyle(
                                  color: Color(0xff9974EF), fontSize: 11),
                            )
                          ],
                        ),
                        subtitle: const Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Text(
                            "City,Country",
                            style: TextStyle(color: Color(0xff414141)),
                          ),
                        ),
                        trailing: SvgPicture.asset("assets/svg/options.svg"),
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
    } else if (iconColor == 4) {
      return Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(9)),
              height: MediaQuery.of(context).size.height / 20,
              width: MediaQuery.of(context).size.width / 1.1,
              child: TextField(
                onChanged: (text) {},
                onTap: () {},
                controller: searchController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(6),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xffF3F7FC)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xffF3F7FC)),
                    ),
                    hintText: "Search",
                    //  hintStyle: TextStyleDecoration.grey(context),
                    fillColor: Color(0xffF3F7FC),
                    filled: true),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.4,
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color(0xffDEDEDE), width: .5),
                          borderRadius: BorderRadius.circular(1)),
                      tileColor: const Color(0xffFFFFFF),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "House Loan",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            "Payment",
                            style: TextStyle(
                                color: Color(0xff707070), fontSize: 11),
                          )
                        ],
                      ),
                      subtitle: Row(
                        children: const [
                          Text(
                            "Rs. 34,165.00",
                            style: TextStyle(
                                color: Color(0xff000000), fontSize: 15),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Text(
                              "In 2 Days",
                              style: TextStyle(
                                  color: Color(0xff707070), fontSize: 11),
                            ),
                          )
                        ],
                      ),
                      trailing: Container(
                        height: 33.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.0),
                            gradient: const LinearGradient(colors: [
                              Color(0xff9974EF),
                              Color(0xff3633A8)
                            ])),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          child: const Text('Pay now'),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
    } else if (iconColor == 5) {
      return Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xffF3F7FC)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  Container(

                      ///can view image
                      ///adding image commented here
                      height: 150,
                      width: 80,
                      // child: imageSelect == true
                      //     ? displayImage()
                      //     : GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       showOptionsDialog(context);
                      //     });
                      //   },
                      //   child: Icon(
                      //     Icons.add,
                      //     color: Colors.grey,
                      //   ),
                      // )
                      child: GFAvatar(
                          backgroundColor: Colors.grey[300],
                          backgroundImage: photo == ''
                              ? const NetworkImage(
                                  'https://www.gravatar.com/avatar/?s=46&d=identicon&r=PG&f=1')
                              : NetworkImage(photo),
                          shape: GFAvatarShape.circle)),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Admin Info",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Row(
                        children: [
                          const Text(
                            "Savad farooque  ",
                            style: TextStyle(
                                color: Color(0xff707070), fontSize: 12),
                          ),
                          SvgPicture.asset("assets/svg/edit-solid.svg")
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "savadfarooque@gmail.com",
                            style: TextStyle(
                                color: Color(0xff08640B), fontSize: 11),
                          ),
                          SvgPicture.asset("assets/svg/edit-solid.svg")
                        ],
                      ),
                      const Text(
                        "Change Password",
                        style:
                            TextStyle(color: Color(0xff007BF9), fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  FlutterSwitch(
                    width: 40.0,
                    height: 20.0,
                    valueFontSize: 30.0,
                    toggleSize: 15.0,
                    value: status,
                    borderRadius: 20.0,
                    padding: 1.0,
                    activeColor: const Color(0xff9974EF),
                    activeTextColor: Colors.green,
                    inactiveTextColor: Colors.grey,
                    inactiveColor: Colors.grey,
                    onToggle: (val) {
                      setState(() {
                        status = val;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text("Notifications")
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => UsersList()));
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border:
                        Border.all(color: const Color(0xffDEDEDE), width: .5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Users"),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UsersRoleList()));
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border:
                        Border.all(color: const Color(0xffDEDEDE), width: .5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("User Role"),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddAccount()));
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border:
                        Border.all(color: const Color(0xffDEDEDE), width: .5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Accounts"),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CountryList()));
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border:
                        Border.all(color: const Color(0xffDEDEDE), width: .5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Country"),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 18,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border:
                      Border.all(color: const Color(0xffDEDEDE), width: .5)),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Zakath"),
                    FlutterSwitch(
                      width: 40.0,
                      height: 20.0,
                      valueFontSize: 30.0,
                      toggleSize: 15.0,
                      value: zakath,
                      borderRadius: 20.0,
                      padding: 1.0,
                      activeColor: const Color(0xff9974EF),
                      activeTextColor: Colors.green,
                      inactiveTextColor: Colors.grey,
                      inactiveColor: Colors.grey,
                      onToggle: (val) {
                        setState(() {
                          zakath = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 18,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border:
                      Border.all(color: const Color(0xffDEDEDE), width: .5)),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Interest"),
                    FlutterSwitch(
                      width: 40.0,
                      height: 20.0,
                      valueFontSize: 30.0,
                      toggleSize: 15.0,
                      value: intrest,
                      borderRadius: 20.0,
                      padding: 1.0,
                      activeColor: const Color(0xff9974EF),
                      activeTextColor: Colors.green,
                      inactiveTextColor: Colors.grey,
                      inactiveColor: Colors.grey,
                      onToggle: (val) {
                        setState(() {
                          intrest = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {}
  }

  getAppbar(int iconColor) {
    if (iconColor == 1) {
      return AppBar(
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Dashboard',
          style: TextStyle(
              color: Color(0xff13213A),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      );
    } else if (iconColor == 2) {
      return AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: const Color(0xffffffff),

        elevation: 0,
        title: const Text(
          'Menu',
          style: TextStyle(
              color: Color(0xff13213A),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      );
    } else if (iconColor == 3) {
      return AppBar(
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        automaticallyImplyLeading: false,

        title: const Text(
          'Portfolio',
          style: TextStyle(
              color: Color(0xff13213A),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Data.isEdit = false;
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddPortfolio()));
              },
              icon: SvgPicture.asset("assets/svg/plus.svg")),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/svg/filter.svg")),
        ],
      );
    } else if (iconColor == 4) {
      return AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: const Text(
          'Payment Notification',
          style: TextStyle(
              color: Color(0xff13213A),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      );
    } else if (iconColor == 5) {
      return AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
              color: Color(0xff13213A),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
actions: const [
  Padding(
    padding: EdgeInsets.all(20.0),
    child: Text("Log out",style: TextStyle(color: Color(0xff5728C4)),),
  ),

],
      );
    }
  }
}
