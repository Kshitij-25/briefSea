import 'package:briefsea/data/core/api_client.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/di/get_it.dart';

class ContactsProvider {
  static final apiClient = getItInstance<ApiClient>();

  // // Fetches the list of contacts.
  // static final getContactsProvider = FutureProvider<List<ContactsModel>>((ref) async {
  //   final contacts = await contactsRepository.getContacts();
  //   return contacts ?? [];
  // });

  // Sends the contacts to the backend server.
  static final sendContactsProvider = FutureProvider<bool>((ref) async {
    var contactsBox = await Hive.box('contactsBox');
    final contacts = await contactsBox.get('contacts');
    // Wait for the contacts to be fetched by the getContactsProvider.
    // final contacts = await ref.watch(getContactsProvider.future);
    // await ContactDataSourceImpl(apiClient).sendContacts(contacts,co);
    return true;
  });
}
