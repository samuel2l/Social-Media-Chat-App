import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/contacts/controller/contatcts_controller.dart';

class ContactsScreen extends ConsumerWidget {
  static const String routeName = '/contacts';
  const ContactsScreen({super.key});
// void selectContact(
//       WidgetRef ref, Contact selectedContact, BuildContext context) {
//     ref
//         .read(selectContactControllerProvider)
//         .selectContact(selectedContact, context);
//   }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select contact'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: ref.watch(contactsProvider).when(
            data: (contacts) {

              return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return InkWell(
                      onTap: () {
                        // selectContact(ref, contact, context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Text(
                            contact.displayName,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          leading: contact.photo == null
                              ? null
                              : CircleAvatar(
                                  backgroundImage: MemoryImage(contact.photo!),
                                  radius: 30,
                                ),
                        ),
                      ),
                    );
                  });
            },
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
