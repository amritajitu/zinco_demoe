import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled3/screens/dashboard.dart';
import '../global/text_style.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isHidden = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 2,
              child: Form(
                key: _formKey,
                child: ListView(children: [
                  const Text(
                    "Sign in",
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text(
                    "to your account",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter user name';
                        }
                        return null;
                      },
                      controller: userNameController,
                      readOnly: true,
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
                          contentPadding: const EdgeInsets.all(7),
                          // labelText: labelText,
                          //labelStyle: TextStyleDecoration.red(context),
                          hintText: "User name",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              "assets/svg/user.svg",
                              width: 5,
                              height: 5,
                            ),
                          ),
                          hintStyle: TextStyleDecoration.hintTextColor(context),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: const Color(0xffF3F7FC))),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 1.1,
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
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  "assets/svg/password.svg",
                                  height: 4,
                                  width: 4,
                                ),
                              ),
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
                              hintStyle:
                                  const TextStyle(color: Color(0xff778EB8)),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color(0xffF3F7FC)))),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height / 34,
                            //height of button
                            width: MediaQuery.of(context).size.width / 20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xff5346BD), width: 1),
                              // color: Repository.tileView(context),
                              shape: BoxShape.circle,
                            ),
                            //  color: Colors.blue,
                            child: Checkbox(
                              checkColor: const Color(0xff5346BD),
                              activeColor: Colors.transparent,
                              fillColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  // print(isChecked);
                                  isChecked = value!;
                                });
                              },
                            )),
                        const SizedBox(
                          width: 11,
                        ),
                        const Text("Keep me Logged in.")
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    height: MediaQuery.of(context).size.height /
                        15, //height of button
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xff5346BD),
                      ),
                      child: const Text(
                        'SIGN IN',
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Dashboard()));
                      },
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      );
}
