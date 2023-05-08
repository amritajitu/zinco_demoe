import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import 'add_contact.dart';


class ContactFetchPage extends StatefulWidget {
  @override
  _ContactFetchPageState createState() => _ContactFetchPageState();
}

class _ContactFetchPageState extends State<ContactFetchPage> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      home: Scaffold(
          backgroundColor: const Color(0xffffffff),

          appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xff13213A),
                ),
              ),

              elevation: 0.0,
              backgroundColor: const Color(0xffffffff),

              title: Text('Contacts',style: TextStyle(color: Color(0xff13213A)),)),
          body: _body()));

  Widget _body() {
    if (_permissionDenied) return Center(child: Text('Permission denied'));
    if (_contacts == null) return Center(child: CircularProgressIndicator());
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: ListView.builder(
          itemCount: _contacts!.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ListTile(
              tileColor: Color(0xffF3F7FC),
                title: Text(_contacts![i].displayName),
              ///phone number view not done
              // subtitle:Text('${_contacts![i].phones.first}') ,
                onTap: () async {
                  final fullContact =  await FlutterContacts.getContact(_contacts![i].id);
                  await Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ContactPage(fullContact!)));
                }),
          )),
    );
  }
}





 ///
///
///
// import 'package:flutter/material.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
//
//
// class FlutterContactsExample extends StatefulWidget {
//   @override
//   _FlutterContactsExampleState createState() => _FlutterContactsExampleState();
// }
//
// class _FlutterContactsExampleState extends State<FlutterContactsExample> {
//   List<Contact>? _contacts;
//   bool _permissionDenied = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchContacts();
//   }
//
//   Future _fetchContacts() async {
//     if (!await FlutterContacts.requestPermission(readonly: true)) {
//       setState(() => _permissionDenied = true);
//     } else {
//       final contacts = await FlutterContacts.getContacts();
//       setState(() => _contacts = contacts);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(title: Text('Contacts',style: TextStyle(),)),
//           body: _body()));
//
//   Widget _body() {
//     if (_permissionDenied) return Center(child: Text('Permission denied'));
//     if (_contacts == null) return Center(child: CircularProgressIndicator());
//     return ListView.builder(
//         itemCount: _contacts!.length,
//         itemBuilder: (context, i) => ListTile(
//             title: Text(_contacts![i].displayName),
//             onTap: () async {
//               final fullContact =
//               await FlutterContacts.getContact(_contacts![i].id);
//               await Navigator.of(context).push(
//                   MaterialPageRoute(builder: (_) => ContactPage(fullContact!)));
//             }));
//   }
// }
//
// class ContactPage extends StatefulWidget {
//   final Contact contact;
//   ContactPage(this.contact);
//
//   @override
//   State<ContactPage> createState() => _ContactPageState();
// }
//
// class _ContactPageState extends State<ContactPage> {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//       appBar: AppBar(title: Text(widget.contact.displayName)),
//       body: Column(children: [
//         Text('First name: ${widget.contact.name.first}'),
//         Text('Last name: ${widget.contact.name.last}'),
//         Text(
//             'Phone number: ${widget.contact.phones.isNotEmpty ? widget.contact.phones.first.number : '(none)'}'),
//         Text(
//             'Email address: ${widget.contact.emails.isNotEmpty ? widget.contact.emails.first.address : '(none)'}'),
//       ]));
// }