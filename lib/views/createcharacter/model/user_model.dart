import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

import 'package:groupnotes/core/constants/cloudFireStore/cloud_fire_store_constants.dart';

@immutable
class UserModel {
  final String id;
  final String name;
  final String surName;
  final List<String> groupNames; // dynami olmayınca saçma bir hata geliyor, fixle onu
  final bool gender;
  const UserModel({
    required this.id,
    required this.name,
    required this.surName,
    required this.groupNames,
    required this.gender,
  });
  UserModel.fromSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.data()[FirestoreDatabaseTextFields.ownerUserIdFieldName],
        name = snapshot.data()[FirestoreDatabaseTextFields.textFieldName] as String,
        surName = snapshot.data()[FirestoreDatabaseTextFields.textFieldSurName] as String,
        groupNames = snapshot.data()[FirestoreDatabaseTextFields.textFieldGroupNames] as List<String>,
        gender = snapshot.data()[FirestoreDatabaseTextFields.textFieldGender] as bool;
}
