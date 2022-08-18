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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user_id': id});
    result.addAll({'name': name});
    result.addAll({'surName': surName});
    result.addAll({'groupNames': groupNames});
    result.addAll({'gender': gender});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['user_id'] ?? '',
      name: map['name'] ?? '',
      surName: map['surName'] ?? '',
      groupNames: List<String>.from(map['groupNames']),
      gender: map['gender'] ?? false,
    );
  }
}
