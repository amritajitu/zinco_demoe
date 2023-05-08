import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';


class AddUserRole extends StatefulWidget {
  @override
  State<AddUserRole> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddUserRole> {
  TextEditingController contactNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController userRoleController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  bool isCreate=false;
  bool isEdit=false;
  bool isDelete=false;

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
          'Accountant',
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
            children:  [

              SizedBox(
                height: 10,
              ),
            Text("Portfolio",style: TextStyle(color: Color(0xff000000),fontSize: 20),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/10,
                      child: FlutterSwitch(
                        width: 40.0,
                        height: 20.0,
                        valueFontSize: 30.0,
                        toggleSize: 15.0,
                        value: isCreate,
                        borderRadius: 20.0,
                        padding: 1.0,
                        activeColor: const Color(0xff9974EF),
                        activeTextColor: Colors.green,
                        inactiveTextColor: Colors.grey,
                        inactiveColor: Colors.grey,
                        onToggle: (val) {
                          setState(() {
                            isCreate = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text("Create",style: TextStyle(fontSize: 17),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/10,
                      child: FlutterSwitch(
                        width: 40.0,
                        height: 20.0,
                        valueFontSize: 30.0,
                        toggleSize: 15.0,
                        value: isEdit,
                        borderRadius: 20.0,
                        padding: 1.0,
                        activeColor: const Color(0xff9974EF),
                        activeTextColor: Colors.green,
                        inactiveTextColor: Colors.grey,
                        inactiveColor: Colors.grey,
                        onToggle: (val) {
                          setState(() {
                            isEdit = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text("Edit",style: TextStyle(fontSize: 17),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/10,
                      child: FlutterSwitch(
                        width: 40.0,
                        height: 20.0,
                        valueFontSize: 30.0,
                        toggleSize: 15.0,
                        value: isDelete,
                        borderRadius: 20.0,
                        padding: 1.0,
                        activeColor: const Color(0xff9974EF),
                        activeTextColor: Colors.green,
                        inactiveTextColor: Colors.grey,
                        inactiveColor: Colors.grey,
                        onToggle: (val) {
                          setState(() {
                            isDelete = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text("Delete",style: TextStyle(fontSize: 17),)
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Contacts",style: TextStyle(color: Color(0xff000000),fontSize: 20),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/10,
                      child: FlutterSwitch(
                        width: 40.0,
                        height: 20.0,
                        valueFontSize: 30.0,
                        toggleSize: 15.0,
                        value: isCreate,
                        borderRadius: 20.0,
                        padding: 1.0,
                        activeColor: const Color(0xff9974EF),
                        activeTextColor: Colors.green,
                        inactiveTextColor: Colors.grey,
                        inactiveColor: Colors.grey,
                        onToggle: (val) {
                          setState(() {
                            isCreate = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text("Create",style: TextStyle(fontSize: 17),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/10,
                      child: FlutterSwitch(
                        width: 40.0,
                        height: 20.0,
                        valueFontSize: 30.0,
                        toggleSize: 15.0,
                        value: isEdit,
                        borderRadius: 20.0,
                        padding: 1.0,
                        activeColor: const Color(0xff9974EF),
                        activeTextColor: Colors.green,
                        inactiveTextColor: Colors.grey,
                        inactiveColor: Colors.grey,
                        onToggle: (val) {
                          setState(() {
                            isEdit = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text("Edit",style: TextStyle(fontSize: 17),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/10,
                      child: FlutterSwitch(
                        width: 40.0,
                        height: 20.0,
                        valueFontSize: 30.0,
                        toggleSize: 15.0,
                        value: isDelete,
                        borderRadius: 20.0,
                        padding: 1.0,
                        activeColor: const Color(0xff9974EF),
                        activeTextColor: Colors.green,
                        inactiveTextColor: Colors.grey,
                        inactiveColor: Colors.grey,
                        onToggle: (val) {
                          setState(() {
                            isDelete = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text("Delete",style: TextStyle(fontSize: 17),)
                  ],
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

        },
      ),
    );
  }
}
