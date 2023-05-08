import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CreateCountry extends StatefulWidget {
  @override
  State<CreateCountry> createState() => _CreateCountryState();
}

class _CreateCountryState extends State<CreateCountry> {
  TextEditingController countryController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  FocusNode countryName = FocusNode();
  FocusNode currency = FocusNode();
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
          'Add country',
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
                    focusNode: countryName,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(currency);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    controller: countryController,
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
                        // labelText: labelText,
                        //labelStyle: TextStyleDecoration.red(context),
                        hintText: "Country Name",
                        hintStyle: TextStyle(color: Color(0xff778EB8)),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xffF3F7FC)))),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                child: TextFormField(
                    focusNode: currency,
                    onEditingComplete: () {
                      //  FocusScope.of(context).requestFocus(openingBalanceFCNode);
                    },
                    controller: countryController,
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
                        hintText: "Currency",
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: GestureDetector(
        child: SvgPicture.asset('assets/svg/save.svg'),
        onTap: () {
          //  Navigator.of(context).push(   MaterialPageRoute(builder: (context) => AddUserRole()));
        },
      ),
    );
  }
}
