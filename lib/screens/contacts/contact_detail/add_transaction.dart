import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/screens/transactions/detail/country_state.dart';
import 'package:untitled3/screens/transactions/detail/from&to_account.dart';

import '../../../global/custom_class.dart';
import 'from_account.dart';

class AddTransactionContact extends StatefulWidget {
  @override
  State<AddTransactionContact> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddTransactionContact> {
  DateTime selectedDateAndTime = DateTime.now();
  TextEditingController calenderController = TextEditingController();
  TextEditingController fromAccountController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController fromAmountController = TextEditingController();
  TextEditingController toAccountController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController narationController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController contactNameController = TextEditingController();
  Color buttonBack1 = const Color(0xff3633A8);
  Color buttonBack2 = const Color(0xffC6DEFC);
  Color textColor1 = Colors.white;
  Color textColor2 = const Color(0xff3633A8);

  String _date = "DD/MM/YYYY";
  String dateFormat = "2022-01-01";
  bool isReturn = false;

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

    timeController.text = "12:00 AM";
  }

  String? _selectedTime;

  Future<void> _show() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (result != null) {
      setState(() {
        print(result.period);
        _selectedTime = result.format(context);
        var a = result.period;
        print(a);
        timeController.text = _selectedTime!;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController expenseController = TextEditingController();
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
          'Add a Transaction',
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
                height: 10,
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
                  onTap: () {},
                  controller: contactNameController,
                  // focusNode: contactNameFCNode,
                  // onEditingComplete: () {
                  //   FocusScope.of(context).requestFocus(phoneNumberFCNode);
                  // },
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff3633A8))),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff3633A8))),
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff3633A8))),
                      hintStyle: TextStyle(
                        color: Color(0xffA1A1A1),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: "Contact Name",
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      prefixIcon: Icon(Icons.person),
                      labelStyle: TextStyle(
                        color: Color(0xffA1A1A1),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: EdgeInsets.all(6),
                      fillColor: Color(0xffF3F7FC),
                      filled: true),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter amount';
                          }
                          return null;
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,8}')),
                        ],
                        controller: amountController,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xffF3F7FC)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xffF3F7FC)),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                  left: 8, right: 8, top: 14, bottom: 8),
                              child: Text(
                                "Rs.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            contentPadding: EdgeInsets.all(7),
                            // labelText: labelText,
                            //labelStyle: TextStyleDecoration.red(context),
                            hintText: "1000.00",
                            hintStyle: TextStyle(
                                color: Color(0xff778EB8), fontSize: 20),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xffF3F7FC)))),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height:      MediaQuery.of(context).size.height / 15, //height of button
                width: MediaQuery.of(context).size.width / 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height /
                          20, //height of button
                      width: MediaQuery.of(context).size.width / 3.5,
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
                          'Pay',
                          style: TextStyle(
                              //    color: textColor1
                              ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      height: MediaQuery.of(context).size.height /
                          20, //height of button
                      width: MediaQuery.of(context).size.width / 3.5,
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
                          'Receive',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: MediaQuery.of(context).size.height / 20,
                    child: TextFormField(

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
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: MediaQuery.of(context).size.height / 20,
                    child: TextFormField(
                      controller: timeController,
                      textAlign: TextAlign.center,
                      readOnly: true,
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
                            child: SvgPicture.asset("assets/svg/clock.svg"),
                          ),
                          filled: true,
                          fillColor: const Color(0xffF3F7FC)),
                      onTap: () {
                        _show();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                  child: Text(
                "Account Details",
                style: TextStyle(color: Color(0xff13213A), fontSize: 20),
              )),
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
                      onTap: () async {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FromAccount()),
                        );

                        print(result);

                        if (result != null) {
                          setState(() {
                            fromAccountController.text = result;
                          });
                        } else {}
                      },
                      controller: fromAccountController,

                      // style: TextStyle(
                      //     color: Repository.textColor(context),fontSize: 13),
                      readOnly: true,
                      decoration: TextFieldDecoration.defaultStyleWithIcon(context,hintTextStr: "From Account"))),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter amount';
                        }
                        return null;
                      },
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,8}')),
                      ],
                      controller: fromAmountController,
                      readOnly: true,
                      decoration: TextFieldDecoration.defaultStyle(context,hintTextStr: "From Amount"))),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLength: 5,
                      controller: narationController,
                      decoration:TextFieldDecoration.defaultStyle(context,hintTextStr: "Narration"))),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: CheckboxListTile(
                      //checkbox positioned at left
                      value: isReturn,
                      activeColor: Color(0xffBCBCBC),
                      checkColor: Color(0xff3633A8),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? value) {
                        setState(() {
                          isReturn = value!;
                        });
                      },
                      title: const Text(
                        "Return/payment Notification",
                        style: TextStyle(color: Color(0xff778EB8)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.4,
                    height: MediaQuery.of(context).size.height / 20,
                    child: TextFormField(
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
              )
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
