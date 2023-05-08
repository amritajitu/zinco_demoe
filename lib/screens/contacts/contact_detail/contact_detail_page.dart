import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/screens/contacts/contact_detail/add_transaction.dart';

class ContactDetailPage extends StatefulWidget {
  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
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
    fromDate = _date;
    toDate = _date;
  }

  List colors = [Colors.red, Colors.green];

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
          'Savad farooque',
          style: TextStyle(
              color: Color(0xff13213A),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                color: Color(0xff3633A8),
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: Color(0xff3633A8),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: ListView(
          children: [
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Phone No",
                    style: TextStyle(color: Color(0xff3633A8), fontSize: 14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "8838403975",
                        style: TextStyle(color: Color(0xff000000)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset("assets/svg/message.svg"),
                          IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset("assets/svg/phone.svg")),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              tileColor: const Color(0xffF3F3F3),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Summary",
                    style: TextStyle(color: Color(0xff3633A8), fontSize: 18),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Total Recieved",
                              style: TextStyle(color: Color(0xff089B17)),
                            ),
                            Text(
                              "Rs. 1000.00",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Total Paid",
                              style: TextStyle(color: Color(0xffFF0000)),
                            ),
                            Text(
                              "Rs. 1000.00",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Transactions",
                  style: TextStyle(color: Color(0xff13213A), fontSize: 20),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 20,
                  // width: MediaQuery.of(context).size.width/2.3,
                  decoration: BoxDecoration(
                      color: const Color(0xff040404),
                      borderRadius: BorderRadius.circular(23)),
                  child: Row(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.transparent),
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Text(
                          fromDate,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const Text(
                        "-",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.transparent),
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Text(
                          toDate,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color(0xffDEDEDE), width: .5),
                          borderRadius: BorderRadius.circular(1)),
                      tileColor: const Color(0xffFFFFFF),
                      leading: Container(
                        width: 20,
                        color: colors[index],
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "21 Feb 2023, 10:00 AM",
                            style: TextStyle(color: Color(0xff8D8D8D)),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Cash in Hand",
                                style: TextStyle(color: Color(0xff000000)),
                              ),
                              Text(
                                "- Rs. 1000.00",
                                style: TextStyle(color: colors[index]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: SvgPicture.asset("assets/svg/options.svg"),
                    );
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
              width: 10,
            ),
            Container(
              height: 33.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17.0),
                  color: const Color(0xff3633A8)),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddTransactionContact()));
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
      ));

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
        fromDate = _date;
        toDate = _date;
      });
    }
  }
}
