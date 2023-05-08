import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/screens/income/income_list.dart';
import 'package:untitled3/screens/transactions/detail/country_state.dart';
import 'package:untitled3/screens/transactions/detail/from&to_account.dart';

class AddTransaction extends StatefulWidget {
  @override
  State<AddTransaction> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddTransaction> {
  DateTime selectedDateAndTime = DateTime.now();
  TextEditingController calenderController = TextEditingController();
  TextEditingController fromAccountController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController toAccountController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController amount1Controller = TextEditingController();
  TextEditingController narationController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  String _date = "DD/MM/YYYY";
  String dateFormat = "2022-01-01";
  bool isZakath = false;

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
                              builder: (context) => TransactionCountry()),
                        );

                        print(result);

                        if (result != null) {
                          setState(() {
                            countryController.text = result;
                          });
                        } else {}
                      },
                      controller: countryController,

                      // style: TextStyle(
                      //     color: Repository.textColor(context),fontSize: 13),
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
                          // labelText: labelText,
                          //labelStyle: TextStyleDecoration.red(context),
                          hintText: "From country",
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
                          return 'Please enter name';
                        }
                        return null;
                      },
                      onTap: () async {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionAccount()),
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
                          hintText: "From account",
                          hintStyle: TextStyle(color: Color(0xff778EB8)),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xffF3F7FC)))),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "Balance :",
                        style:
                            TextStyle(color: Color(0xff13213A), fontSize: 14),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "1000.00",
                        style: TextStyle(color: Color(0xff778EB8)),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
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
                              contentPadding: EdgeInsets.all(7),
                              hintText: "Amount",
                              hintStyle: TextStyle(color: Color(0xff778EB8)),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Color(0xffF3F7FC)))),
                ],
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
                      onTap: () async {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionCountry()),
                        );

                        print(result);

                        if (result != null) {
                          setState(() {
                            stateController.text = result;
                          });
                        } else {}
                      },
                      controller: stateController,
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
                          // labelText: labelText,
                          //labelStyle: TextStyleDecoration.red(context),
                          hintText: "To Country",
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
                          return 'Please enter name';
                        }
                        return null;
                      },
                      onTap: () async {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionAccount()),
                        );

                        print(result);

                        if (result != null) {
                          setState(() {
                            toAccountController.text = result;
                          });
                        } else {}
                      },
                      controller: toAccountController,
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
                          // labelText: labelText,
                          //labelStyle: TextStyleDecoration.red(context),
                          hintText: "To Amount",
                          hintStyle: TextStyle(color: Color(0xff778EB8)),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xffF3F7FC)))),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "Balance :",
                        style:
                            TextStyle(color: Color(0xff13213A), fontSize: 14),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "1000.00",
                        style: TextStyle(color: Color(0xff778EB8)),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
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
                          controller: amount1Controller,
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
                              contentPadding: EdgeInsets.all(7),
                              hintText: "Amount",
                              hintStyle: TextStyle(color: Color(0xff778EB8)),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Color(0xffF3F7FC)))),
                ],
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
                      textAlign: TextAlign.center,
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
                          hintText: "1 USD = Rs.84.88",
                          hintStyle: TextStyle(color: Color(0xff778EB8)),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xffF3F7FC)))),
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
                          hintText: "Naration",
                          hintStyle: TextStyle(color: Color(0xff778EB8)),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xffF3F7FC)))),
              const SizedBox(
                height: 10,
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
                content: Text("Enter mandatory field")));
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
