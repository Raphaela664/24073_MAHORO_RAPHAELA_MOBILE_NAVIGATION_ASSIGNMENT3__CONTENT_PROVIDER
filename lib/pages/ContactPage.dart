// import 'package:fast_contacts/fast_contacts.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ContactPage extends StatefulWidget {
//   const ContactPage({super.key});
//   @override
//   State<ContactPage> createState() => _ContactPageState();
// }

// class _ContactPageState extends State<ContactPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Contacts"),
//       ),
//       body: Container(
//         height: double.infinity,
//         child: FutureBuilder(
//           future: getContacts(),
//           builder: (context, AsyncSnapshot snapshot) {
//             if(snapshot.data == null){
//               return const  Center(
//                 child: SizedBox(height: 50, child: CircularProgressIndicator(),));
//             }
//             return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (context, index){
//                 Contact contact = snapshot.data[index];
//                 return Column(
//                   children: [
//                     ListTile(
//                       leading: const CircleAvatar(
//                         radius: 20,
//                         child: Icon(Icons.person),
//                       ),
//                       title: Text(contact.displayName),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [

//                         Text(contact.phones as String),
//                         Text(contact.emails[0] as String)
//                       ],
//                       ) 
//                     )
//                   ],
//                 );
//               }
//             );
//           } ,
//         ),
//       ),
//     );
//   }
//   Future<List<Contact>> getContacts() async{
//     bool isGranted = await Permission.contacts.status.isGranted;
//     if(!isGranted){
//       isGranted = await Permission.contacts.request().isGranted;
//     }
//     if(isGranted){
//       return await FastContacts.getAllContacts();
//     }
//     return [];
//   }
// }

import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late Future<List<Contact>> _contactsFuture;

  @override
  void initState() {
    super.initState();
    _contactsFuture = getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contacts"),
      ),
      body: Container(
        height: double.infinity,
        child: FutureBuilder<List<Contact>>(
          future: _contactsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            final contacts = snapshot.data!;
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  leading: const CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person),
                  ),
                  title: Text(contact.displayName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final phone in contact.phones)
                        Text(phone.number),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<Contact>> getContacts() async {
    final isGranted = await Permission.contacts.request().isGranted;
    if (isGranted) {
      return FastContacts.getAllContacts();
    }
    return [];
  }
}
