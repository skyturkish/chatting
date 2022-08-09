import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groupnotes/core/constants/cloudFireStore/cloud_fire_store_constants.dart';
import 'package:groupnotes/core/constants/enums/locale_keys_enum.dart';
import 'package:groupnotes/core/init/cache/locale_manager.dart';
import 'package:groupnotes/services/cloudnote/cloud_storage_exceptions.dart';
import 'package:groupnotes/views/home/createcharacter/model/user_model.dart';
import 'dart:developer' as devtools show log;

class CreateUserFirebaseCloudStorage {
  // Tüm aşamalar geçildikten sonra cache atayım, eğer tüm aşamalar geçilmemişse ve haliyle cachelenmemişti logOut atayım adamı
  final users = FirebaseFirestore.instance.collection('users');

  static final CreateUserFirebaseCloudStorage _shared = CreateUserFirebaseCloudStorage._sharedInstance();
  CreateUserFirebaseCloudStorage._sharedInstance();
  factory CreateUserFirebaseCloudStorage() => _shared;

  Future<void> deleteUser({required String documentId}) async {
    try {
      await users.doc(documentId).delete();
    } catch (e) {
      throw CouldNoteDeleteNoteException();
    }
  }

  Future<UserModel> createUser({required String ownerUserId, required String name, required String surName}) async {
    final document = await users.add({
      FirestoreDatabaseTextFields.ownerUserIdFieldName: ownerUserId,
      FirestoreDatabaseTextFields.textFieldGender: false,
      FirestoreDatabaseTextFields.textFieldGroupNames: <dynamic>[],
      FirestoreDatabaseTextFields.textFieldName: name,
      FirestoreDatabaseTextFields.textFieldSurName: surName,
    });
    final fetchedUser = await document.get();
    UserModel user = UserModel(
      documentId: fetchedUser.id, // document id
      ownerUsedId: ownerUserId,
      name: fetchedUser[FirestoreDatabaseTextFields.textFieldName] as String,
      surName: fetchedUser[FirestoreDatabaseTextFields.textFieldSurName] as String,
      groupNames: fetchedUser[FirestoreDatabaseTextFields.textFieldGroupNames] as List<dynamic>,
      gender: fetchedUser[FirestoreDatabaseTextFields.textFieldGender] as bool,
    );

    await LocaleManager.instance.setStringValue(PreferencesKeys.USERID, ownerUserId);

    return user;
  }

  Future<UserModel?> getUserIfExist({required String userId}) async {
    // devtools.log(users.doc('l7eDi9Byf7mFuAU1G2zR').);

    final user = users.where("user_id", isEqualTo: userId);
    // devtools.log(user.toString());
    return null;
  }

  Future<void> denemebrom() async {
    final user = <String, dynamic>{
      "first": "adana",
      "last": "kral",
      "born": 15789,
      "yeni alan": "obba cubba",
    };

// Add a new document with a generated ID
    FirebaseFirestore.instance
        .collection("deneme")
        .add(user)
        .then((DocumentReference doc) => devtools.log('DocumentSnapshot added with ID: ${doc.id}'));
  }

  Future<void> verilerial() async {
    await FirebaseFirestore.instance.collection("deneme").get().then((event) {
      for (var doc in event.docs) {
        devtools.log("${doc.data()['last']}");
        devtools.log("${doc.id} => ${doc.data()}");
      }
    });
  }
}
// reference data type varmış, onu kullanabilirsin