import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';

import 'add_loans.dart';

class LoanList extends StatefulWidget {

  @override
  State<LoanList> createState() => _LoanListState();
}

class _LoanListState extends State<LoanList> {
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
          'Loans',
          style: TextStyle(
              color: Color(0xff13213A),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        actions: [

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
                          side: const BorderSide(color: Color(0xffDEDEDE), width: .5),
                          borderRadius: BorderRadius.circular(1)),
                      tileColor: const Color(0xffFFFFFF),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children:  [
                                Container(
                                  width:MediaQuery.of(context).size.width/14,

                                  child: const Text(
                                    "Gave -",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 11),
                                  ),
                                ),
                                const Text(
                                  "House Loan",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                )
                              ],
                            ),
                            const Text("03/03/2022",style: TextStyle(color: Color(0xff707070),fontSize: 11),),

                          ],
                        ),
const SizedBox(height: 4,),
                          const Text("Rs. 10,00,000.00",style: TextStyle(color: Colors.black,fontSize: 12),),
                          Row(
                            children:  [
                              Container(
                                width:MediaQuery.of(context).size.width/14,

                                child: const Text(
                                  "@10%",
                                  style: TextStyle(
                                      color: Color(0xff3633A8), fontSize: 11),
                                ),
                              ),
                              const Text(
                                "For 2 years & 6 Months",
                                style: TextStyle(
                                    color: Color(0xff707070), fontSize: 11),
                              )
                            ],
                          ),const SizedBox(height: 4,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Outstanding",style: TextStyle(color: Color(0xff707070),fontSize: 11),),
                              Text("Next Payment",style: TextStyle(color: Color(0xff707070),fontSize: 11),),

                            ],
                          ),

                        ],
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        const Text(
                        "Rs. 10,25,000.00",
                        style: TextStyle(
                            color: Colors.black, fontSize: 11),
                      ),
                    Row(
                      children: const [
                        Text(
                          "Rs. 34,165.00",
                          style: TextStyle(
                              color: Colors.black, fontSize: 11),
                        ),
                        SizedBox(width: 5,),
                        Text("In 123 Days",style: TextStyle(color: Color(0xff707070),fontSize: 11),),

                      ],
                    ),

                    ],
                    ),const SizedBox(height: 4,),

                        ],
                      ),
                      trailing: SvgPicture.asset("assets/svg/options.svg"),
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xffF3F7FC),
        height: MediaQuery.of(context).size.height/16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: (){},
              child: Row(
                children: [
                  SvgPicture.asset("assets/svg/export.svg"),
                  const SizedBox(
                    width: 4,
                  ),
                  //

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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddLoanPage()));

                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.add,color: Colors.white,),
                    Text('Add'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),),

    );
  }
}
