import 'package:groupnotes/services/cloudfirestore/base-service.dart';
import 'package:groupnotes/views/createcharacter/model/user_model.dart';

class UserCloudFireStoreService extends CloudFireStoreBaseService {
  //  UserCloudFireStoreService({required super.collectionName}) : super();

  static UserCloudFireStoreService get instance {
    _instance ??= UserCloudFireStoreService._init(collectionName: 'users');
    return _instance!;
  }

  UserCloudFireStoreService._init({required super.collectionName});

  static UserCloudFireStoreService? _instance;

  Future<void> createUser({
    required UserModel user,
  }) async {
    bool isUserExist = await userIsExist(id: user.id);
    if (isUserExist == true) return;
    await collection.doc(user.id).set(
          user.toMap(),
        );
  }

  Future<Map<String, dynamic>?> getUserInformationById({required String id}) async {
    var docRef = collection.doc(id);
    final doc = await docRef.get();
    return doc.data();
  }

  Future<bool> userIsExist({required String id}) async {
    var docRef = collection.doc(id);
    final doc = await docRef.get();
    return doc.data() == null ? false : true;
  }
}
