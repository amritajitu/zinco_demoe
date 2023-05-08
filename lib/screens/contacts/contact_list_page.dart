import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';

import 'add_contact.dart';
import 'contact_detail/contact_detail_page.dart';


class ContactListPage extends StatefulWidget {

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  TextEditingController searchController = TextEditingController();
  var photo = "";



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
          'Contacts',
          style: TextStyle(
              color: Color(0xff13213A),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
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
          const SizedBox(
            width: 4,
          ),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/svg/filter.svg")),
        ],
      ),
      body: Padding(
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
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffE5E5E5),
                              Color(0xffF3F3F3),
                              Color(0xffF2F2F2)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              tileColor: const Color(0xffF3F7FC),
                              leading: Container(

                                  ///can view image
                                  ///adding image commented here
                                  height: MediaQuery.of(context).size.height/10,
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
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Asset Name",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        "Type",
                                        style: TextStyle(
                                            color: Color(0xff9974EF),
                                            fontSize: 11),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/message.svg"),
                                      IconButton(
                                          onPressed: () {},
                                          icon: SvgPicture.asset(
                                              "assets/svg/phone.svg")),
                                    ],
                                  )
                                ],
                              ),
                              trailing:GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactDetailPage()));
                                },
                                child:SvgPicture.asset("assets/svg/options.svg") ,
                              )
                                  ,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.15,
                              height: MediaQuery.of(context).size.height / 19,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff9974EF),
                                    Color(0xff3633A8)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "You owe savad",
                                          style: TextStyle(
                                              color: Color(0xffFFFF00),
                                              fontSize: 11),
                                        ),
                                        Text(
                                          "Rs. 32,000.00",
                                          style: TextStyle(
                                              color: Color(0xffFFFFff)),
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset(
                                      "assets/svg/plus_circle.svg",
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: GestureDetector(
        child: SvgPicture.asset('assets/svg/add_circle.svg'),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ContactPage(Contact())));
        },
      ),
    );
  }
}
