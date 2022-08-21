import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groupnotes/core/constants/cloudFireStore/cloud_fire_store_constants.dart';
import 'package:groupnotes/services/cloudfirestore/personal/cloud_note.dart';
import 'package:groupnotes/services/cloudfirestore/personal/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection('notes');
  // burayı abstract yapıp bunu dışarıdan alabilirsin
  // hakikaten alabilirim, aferin bana
  static final FirebaseCloudStorage _shared = FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;

  Future<void> deleteNote({required String documentId}) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNoteDeleteNoteException();
    }
  }

  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    try {
      await notes.doc(documentId).update({FirestoreDatabaseTextFields.textFieldText: text});
    } catch (e) {
      throw CouldNoteUpdateNoteException();
    }
  }

  Stream<Iterable<CloudNote>> allNotes({required String ownerUsedId}) => notes.snapshots().map(
      (event) => event.docs.map((doc) => CloudNote.fromSnapShot(doc)).where((note) => note.ownerUsedId == ownerUsedId));

  Future<Iterable<CloudNote>> getNotes({required String ownerUserId}) async {
    try {
      return await notes
          .where(
            FirestoreDatabaseTextFields
                .ownerUserIdFieldName, // user_id kısmında benim verdiğim ownerUserId kısmına eşit olan yerdeki dataları al onları benim modelime çevir ve döndür
            isEqualTo: ownerUserId, //
          )
          .get()
          .then(
            (value) => value.docs.map(
              (doc) => CloudNote.fromSnapShot(doc),
            ),
          );
    } catch (e) {
      throw CouldNoteGetAllNotesException();
    }
  }

  Future<CloudNote> createNewNote({required String ownerUserId}) async {
    final document = await notes.add({
      FirestoreDatabaseTextFields.ownerUserIdFieldName: ownerUserId,
      FirestoreDatabaseTextFields.textFieldText: '',
    });
    final fetchedNote = await document.get();
    return CloudNote(
      documentId: fetchedNote.id,
      ownerUsedId: ownerUserId,
      text: '',
    );
  }
}
