import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/contacts/repository/contact_repository.dart';

final contactsProvider=FutureProvider((ref) => ref.watch(contactsRepositoryProvider).getContacts());

final selectContactControllerProvider = Provider((ref) {
  
  return SelectContactController(
    ref: ref,
    contactsRepository: ref.watch(contactsRepositoryProvider),
  );
});

class SelectContactController {
  final ProviderRef ref;
  final ContactsRepository contactsRepository;
  SelectContactController({
    required this.ref,
    required this.contactsRepository,
  });

  void selectContact(Contact selectedContact, BuildContext context) {
    contactsRepository.selectContact(selectedContact, context);
  }
}