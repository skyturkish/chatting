import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groupnotes/services/cloud/cloud_storage_constants.dart';
import 'package:groupnotes/services/cloud/cloud_storage_exceptions.dart';
import 'package:groupnotes/services/groupcloud/group_cloud_note.dart';

class FirebaseCloudGroupStorage {
  final groupNotes = FirebaseFirestore.instance.collection('groupNotes');

  static final FirebaseCloudGroupStorage _shared = FirebaseCloudGroupStorage._sharedInstance();
  FirebaseCloudGroupStorage._sharedInstance();
  factory FirebaseCloudGroupStorage() => _shared;

  Future<void> deleteNote({required String documentId}) async {
    try {
      await groupNotes.doc(documentId).delete();
    } catch (e) {
      throw CouldNoteDeleteNoteException();
    }
  }

  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    try {
      await groupNotes.doc(documentId).update({textFieldName: text});
    } catch (e) {
      throw CouldNoteUpdateNoteException();
    }
  }

  Stream<Iterable<GroupCloudNote>> allNotes({required String groupName}) => groupNotes.snapshots().map((event) =>
      event.docs.map((doc) => GroupCloudNote.fromSnapShot(doc)).where((note) => note.groupName == groupName));
}
