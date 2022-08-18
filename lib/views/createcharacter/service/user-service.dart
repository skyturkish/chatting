import 'package:cloud_firestore/cloud_firestore.dart' show QuerySnapshot;
import 'package:groupnotes/views/createcharacter/service/base-service.dart';

class UserCloudFireStoreService extends CloudFireStoreBaseService {
  //  UserCloudFireStoreService({required super.collectionName}) : super();

  static UserCloudFireStoreService get instance {
    _instance ??= UserCloudFireStoreService._init(collectionName: 'users');
    return _instance!;
  }

  UserCloudFireStoreService._init({required super.collectionName});

  static UserCloudFireStoreService? _instance;

  Future<List<Map<String, dynamic>?>> getAllDocumentsFilterName({required String name}) async {
    QuerySnapshot documents = await collection.where('name', isEqualTo: name).get();
    return documents.docs.map(
      (doc) {
        final adana = doc.data() as Map<String, dynamic>;
        return adana;
      },
    ).toList();
  }

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
    QuerySnapshot documents = await collection.where('id', isEqualTo: id).get();
    final user = documents.docs.map(
      (doc) {
        final adana = doc.data() as Map<String, dynamic>;
        return adana;
      },
    ).toList();
    return user.isEmpty ? false : true;
  }
}
