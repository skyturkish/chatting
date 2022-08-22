import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue, QuerySnapshot;
import 'package:groupnotes/core/mixin/log_mixin.dart';
import 'package:groupnotes/services/cloudfirestore/base-service.dart';
import 'package:groupnotes/views/home/group/model/group_model.dart';

class GroupCloudFireStoreService extends CloudFireStoreBaseService with Logger {
  //  UserCloudFireStoreService({required super.collectionName}) : super();
  // sadece bir tane olacaksa, onun unieq id'sini document id olarak yaz
  static GroupCloudFireStoreService get instance {
    _instance ??= GroupCloudFireStoreService._init(collectionName: 'groups');
    return _instance!;
  }

  GroupCloudFireStoreService._init({required super.collectionName});

  static GroupCloudFireStoreService? _instance;

  Future<void> createGroup({required String groupName, required String founderId}) async {
    bool groupExist = await isGroupExist(groupName: groupName);
    if (groupExist == true) {}
    await collection
        .doc(groupName)
        .set(GroupModel(founder: founderId, groupName: groupName, members: [founderId]).toMap());
  }

  Future<bool> isGroupExist({required String groupName}) async {
    var docRef = collection.doc(groupName);
    final doc = await docRef.get();
    return doc.data() == null ? false : true;
  }

  Future<List<GroupModel>> getGroupsBelongToUser({required String id}) async {
    QuerySnapshot documents =
        await collection.where('members', arrayContains: id).get(); // bunu da diğer yerden alacaksın
    final groups = documents.docs.map(
      (doc) {
        final groupInfo = doc.data() as Map<String, dynamic>;
        return groupInfo;
      },
    ).toList();

    return groups.map((group) => GroupModel.fromMap(group)).toList();
  }

  Future<List<GroupModel>> getAllGroups() async {
    QuerySnapshot documents = await collection.get(); // bunu da diğer yerden alacaksın
    final groups = documents.docs.map(
      (doc) {
        final groupInfo = doc.data() as Map<String, dynamic>;
        return groupInfo;
      },
    ).toList();

    return groups.map((group) => GroupModel.fromMap(group)).toList();
  }

  Future<void> joinGroup({required String groupName, required String id}) async {
    collection.doc(groupName).update({
      "members": FieldValue.arrayUnion([id])
    });
  }
}
