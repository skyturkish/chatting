import 'package:cloud_firestore/cloud_firestore.dart' show QuerySnapshot;
import 'package:groupnotes/services/cloudfirestore/base-service.dart';

class GroupNoteCloudFireStoreService extends CloudFireStoreBaseService {
  //  GroupNoteCloudFireStoreService({required super.collectionName}) : super();

  static GroupNoteCloudFireStoreService get instance {
    _instance ??= GroupNoteCloudFireStoreService._init(collectionName: 'users');
    return _instance!;
  }

  GroupNoteCloudFireStoreService._init({required super.collectionName});

  static GroupNoteCloudFireStoreService? _instance;

  Future<List<Map<String, dynamic>?>> getUserInformationById({required String id}) async {
    QuerySnapshot documents = await collection.where('user_id', isEqualTo: id).get(); // bunu da diğer yerden alacaksın
    return documents.docs.map(
      (doc) {
        final adana = doc.data() as Map<String, dynamic>;
        return adana;
      },
    ).toList();
  }

  Future<bool> userIsExist({required String id}) async {
    QuerySnapshot documents = await collection.where('user_id', isEqualTo: id).get();
    final user = documents.docs.map(
      (doc) {
        final adana = doc.data() as Map<String, dynamic>;
        return adana;
      },
    ).toList();
    return user.isEmpty ? false : true;
  }
}
