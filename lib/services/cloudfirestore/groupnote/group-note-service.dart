import 'package:groupnotes/services/cloudfirestore/base-service.dart';
import 'package:groupnotes/services/cloudfirestore/personal/cloud_storage_exceptions.dart';
import 'package:groupnotes/views/home/group/model/group_note_model.dart';

class GroupNoteCloudFireStoreService extends CloudFireStoreBaseService {
  //  GroupNoteCloudFireStoreService({required super.collectionName}) : super();

  static GroupNoteCloudFireStoreService get instance {
    _instance ??= GroupNoteCloudFireStoreService._init(collectionName: 'groupNotes');
    return _instance!;
  }

  GroupNoteCloudFireStoreService._init({required super.collectionName});

  static GroupNoteCloudFireStoreService? _instance;

  Future<void> deleteNote({required String documentId}) async {
    try {
      await collection.doc(documentId).delete();
    } catch (e) {
      throw CouldNoteDeleteNoteException();
    }
  }

  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    try {
      await collection.doc(documentId).update({'note': text});
    } catch (e) {
      throw CouldNoteUpdateNoteException();
    }
  }

  Stream<Iterable<GroupNote>> allNotes({required String groupName}) => collection.snapshots().map(
      (event) => event.docs.map((doc) => GroupNote.fromSnapShot(doc)).where((note) => note.groupName == groupName));

  Future<Iterable<GroupNote>> getNotes({required String groupName}) async {
    try {
      return await collection
          .where(
            'groupName', // user_id kısmında benim verdiğim ownerUserId kısmına eşit olan yerdeki dataları al onları benim modelime çevir ve döndür
            isEqualTo: groupName, //
          )
          .get()
          .then(
            (value) => value.docs.map(
              (doc) => GroupNote.fromSnapShot(doc),
            ),
          );
    } catch (e) {
      throw CouldNoteGetAllNotesException();
    }
  }

  // normalde note burada alınmıyor
  Future<GroupNote> createNewNote(
      {required String note, required String ownerUserId, required String groupName}) async {
    final document = await collection.add({
      'groupName': groupName,
      'ownerUserId': ownerUserId,
      'note': note,
    });
    final fetchedNote = await document.get();
    return GroupNote(
      documentId: fetchedNote.id,
      ownerUserId: ownerUserId,
      groupName: groupName,
      note: note,
    );
  }
}
