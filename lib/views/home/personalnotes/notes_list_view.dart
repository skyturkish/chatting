import 'package:flutter/material.dart';
import 'package:groupnotes/services/cloudfirestore/personal/cloud_note.dart';
import 'package:groupnotes/utilities/dialogs/delete_dialog.dart';

typedef NoteCallback = void Function(CloudNote note);

class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> notes; // lisview ile göstereceğimiz liste
  final NoteCallback onDeleteNote;

  final NoteCallback onTap;

  const NotesListView({Key? key, required this.notes, required this.onDeleteNote, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes.elementAt(index);
        // print(notes[index].toString());
        return ListTile(
          onTap: () {
            // kendi onTapi
            onTap(note);
          },
          title: Text(
            note.text,
            maxLines: 1, //bu 3 satır tüm yazılar yerine bir satır gözükmesini
            softWrap: true, // ve satır sonunda ..... olmasını sağlıyor
            overflow: TextOverflow.ellipsis, //
          ),
          trailing: IconButton(
            // her elemanın en solunda bu simge var ve onpressed var
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeleteNote(note); // void Function(DatabaseNote note);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
