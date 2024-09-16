// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactsRepositoryProvider=Provider((ref){
return ContactsRepository(firestore: FirebaseFirestore.instance);
});

class ContactsRepository {
  FirebaseFirestore firestore;
  ContactsRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];

    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(
            withProperties: true);
      }
    } catch (e) {

    }
    return contacts;
  }
}
