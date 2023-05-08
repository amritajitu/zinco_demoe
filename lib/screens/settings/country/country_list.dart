import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'create_country.dart';




class CountryList extends StatefulWidget {

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
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
          'Country',
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color(0xffDEDEDE), width: .5),
                          borderRadius: BorderRadius.circular(1)),
                      tileColor: const Color(0xffFFFFFF),
                      title: Text("India"),
                      subtitle:Text("INR",style: TextStyle(color: Color(0xff9974EF),fontSize: 12),) ,

                      trailing: SvgPicture.asset("assets/svg/options.svg"),
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
        Navigator.of(context).push(   MaterialPageRoute(builder: (context) => CreateCountry()));



        },
      ),
    );
  }
}
