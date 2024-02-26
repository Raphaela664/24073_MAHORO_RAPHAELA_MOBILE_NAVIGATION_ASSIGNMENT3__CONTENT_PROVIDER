import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contacts"),
      ),
      body: Container(
        height: double.infinity,
        child: FutureBuilder(
          future: getContacts(),
          builder: (context, AsyncSnapshot snapshot) {
            if(snapshot.data == null){
              return const  Center(
                child: SizedBox(height: 50, child: CircularProgressIndicator(),));
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                Contact contact = snapshot.data[index];
                return Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.person),
                      ),
                      title: Text(contact.displayName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(contact.phones[0] as String),
                        Text(contact.emails[0] as String)
                      ],
                      ) 
                    )
                  ],
                );
              }
            );
          } ,
        ),
      ),
    );
  }
  Future<List<Contact>> getContacts() async{
    bool isGranted = await Permission.contacts.status.isGranted;
    if(!isGranted){
      isGranted = await Permission.contacts.request().isGranted;
    }
    if(isGranted){
      return await FastContacts.getAllContacts();
    }
    return [];
  }
}