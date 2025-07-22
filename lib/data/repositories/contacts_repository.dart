import 'package:briefsea/data/data_sources/contacts_data_source.dart';

class ContactsRepository {
  final ContactDataSource _contactDataSource;

  ContactsRepository(this._contactDataSource);

  // Future<List<ContactsModel>?>? getContacts() {
  //   return _contactDataSource.getContacts();
  // }

  // Future<void> sendContacts(List<ContactsModel> contacts) {
  //   return _contactDataSource.sendContacts(contacts);
  // }
}
//