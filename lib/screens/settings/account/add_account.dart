import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/global/custom_class.dart';

class AddAccount extends StatefulWidget {
  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController openingBalanceController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  FocusNode accNameFcNode = FocusNode();
  FocusNode accTypeFCNode = FocusNode();
  FocusNode openingBalanceFCNode = FocusNode();
  FocusNode countryFCNode = FocusNode();
  FocusNode currencyFCNode = FocusNode();
  var photo = "";
  String _date = "DD/MM/YYYY";
  String dateFormat = "2022-01-01";

  DateTime selectedDateAndTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    DateTime dt = DateTime.now();

    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(dt);
    _date = '$formatted';
    calenderController..text = _date;
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
          'Add Account',
          style: TextStyle(
              color: Color(0xff13213A),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                child: TextFormField(
                    focusNode: accNameFcNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(accTypeFCNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    controller: accountNameController,
                    decoration: TextFieldDecoration.defaultStyle(context,hintTextStr: "Account Name"))),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                child: TextFormField(
                    focusNode: accTypeFCNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(openingBalanceFCNode);
                    },
                    controller: accountTypeController,
                    decoration: TextFieldDecoration.defaultStyleWithIcon(context,hintTextStr: "Account Type"))),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: TextFormField(
                        focusNode: openingBalanceFCNode,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(countryFCNode);
                        },
                        controller: openingBalanceController,
                        decoration:TextFieldDecoration.defaultStyle(context,hintTextStr: "Opening Balance"))),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  height: MediaQuery.of(context).size.height / 20,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    controller: calenderController,
                    readOnly: true,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0xff878787)),
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xffF3F7FC)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xffF3F7FC)),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: "",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset("assets/svg/calender.svg"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: TextFormField(
                        focusNode: countryFCNode,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(currencyFCNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        controller: countryController,
                        decoration: TextFieldDecoration.defaultStyleWithIcon(context,hintTextStr: "Currency"))),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: TextFormField(
                        focusNode: currencyFCNode,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        controller: currencyController,
                        decoration: TextFieldDecoration.defaultStyle(context,hintTextStr: "Currency"))),
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: GestureDetector(
        child: SvgPicture.asset('assets/svg/save.svg'),
        onTap: () {
          Navigator.pop(context);
        },
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
      });
    }
  }
}
