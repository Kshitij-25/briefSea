import 'dart:developer';

import 'package:briefsea/data/models/contacts_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common/app_utils/shared_prefs_helper.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';
import '../core/app_error.dart';

abstract class ContactDataSource {
  Future<List<ContactsModel>?>? getContacts(context);
  Future<void> sendContacts(List<ContactsModel> contacts, context);
}

class ContactDataSourceImpl implements ContactDataSource {
  final ApiClient _apiClient;

  ContactDataSourceImpl(this._apiClient);

  Future<String> getJwtToken() async {
    String? jwtToken = await SharedPreferencesHelper.getString('jwtToken');
    return jwtToken ?? "";
  }

  @override
  Future<List<ContactsModel>?>? getContacts(context) async {
    try {
      if (await Permission.contacts.isGranted != null || await Permission.contacts.isGranted == true) {
        var contactsBox = Hive.box('contactsBox');
        List<Contact> contactList = await FlutterContacts.getContacts(withProperties: true, sorted: true);
        List<ContactsModel> contactsModelList = contactList.map((contact) => ContactsModel.fromContact(contact)).toList();
        contactsBox.put('contacts', contactsModelList);
        // print(contactsModelList.toString());
        // AppUtility(context).message(contactsModelList.toString());
        // print("contactsModelList" + contactsModelList.length.toString());
        // AppUtility(context).message(contactsModelList.length.toString());
        return contactsModelList;
      } else {
        return [];
      }
    } catch (e) {
      print('Error in ContactDataSource - getContacts: $e');
      return [];
    }
  }

  @override
  Future<void> sendContacts(List<ContactsModel> contacts, context) async {
    var jwtToken = await getJwtToken();

    try {
      // Convert the contacts to JSON format
      List<Map<String, dynamic>> contactJsonList = contacts.map((contact) => contact.toJson()).toList();

      var body = {
        'contacts': contactJsonList,
      };

      Response? response = await _apiClient.postReq(
        url: ApiConstants.uploadContacts,
        body: body,
        jwtToken: jwtToken,
      );

      if (response?.data != null && response?.statusCode != null) {
        if (response!.statusCode == 200 || response.statusCode == 201) {
          var responseJson = response.data;
          log(responseJson.toString());
          // AppUtility(context).message("Updated Contacts");
        } else {
          // AppUtility(context).message("Failed to Upload 1.");
          throw AppError(statusCode: response.statusCode);
        }
      } else {
        // AppUtility(context).message("Failed to Upload 2.");
        throw AppError();
      }
    } catch (e) {
      // AppUtility(context).message("Failed to Upload 3.");
      log("sendContacts Error", error: e);
      throw AppError(errorMessage: e.toString());
    }
  }
}
