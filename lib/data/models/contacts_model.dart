import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'contacts_model.freezed.dart';
part 'contacts_model.g.dart';

@freezed
@HiveType(typeId: 1)
class ContactsModel with _$ContactsModel {
  factory ContactsModel({
    @HiveField(0) String? id,
    @HiveField(1) String? displayName,
    @HiveField(2) String? name,
    @HiveField(3) List<String>? phones,
    @HiveField(4) List<String>? emails,
  }) = _ContactsModel;

  factory ContactsModel.fromJson(Map<String, dynamic> json) => _$ContactsModelFromJson(json);

  factory ContactsModel.fromContact(Contact contact) {
    // Extract only phones and emails
    // List<String> phones = contact.phones.map((phone) => phone.number.replaceAll(RegExp(r'[-\s+]|^(\+91)'), '')).toList();
    List<String> phones = contact.phones.map((phone) => phone.number).toList();
    List<String> emails = contact.emails.map((email) => email.address).toList();

    return ContactsModel(
      id: contact.id,
      displayName: contact.displayName,
      name: '${contact.name.first} ${contact.name.last}',
      phones: phones,
      emails: emails,
    );
  }
}
