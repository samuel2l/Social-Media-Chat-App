import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/contacts/repository/contact_repository.dart';

final contactsProvider=FutureProvider((ref) => ref.watch(contactsRepositoryProvider).getContacts());
