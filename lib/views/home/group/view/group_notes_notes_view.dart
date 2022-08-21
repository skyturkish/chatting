import 'package:flutter/material.dart';
import 'package:groupnotes/services/auth/auth_service.dart';
import 'package:groupnotes/services/cloudfirestore/groupnote/group-note-service.dart';
import 'package:groupnotes/views/_product/_widgets/textformfield/custom_text_form_field.dart';
import 'package:groupnotes/views/home/group/model/group_note_model.dart';

class GroupNotesNotesView extends StatefulWidget {
  const GroupNotesNotesView({Key? key, required this.groupName}) : super(key: key);
  final String groupName;

  @override
  State<GroupNotesNotesView> createState() => GroupNotesNotesViewState();
}

class GroupNotesNotesViewState extends State<GroupNotesNotesView> {
  late final TextEditingController _noteController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _noteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.groupName,
          style: const TextStyle(color: Colors.red),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            StreamBuilder(
              stream: GroupNoteCloudFireStoreService.instance.allNotes(groupName: widget.groupName),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    if (snapshot.hasData) {
                      final allNotes = snapshot.data as Iterable<GroupNote>;
                      return ListView.builder(
                        itemCount: allNotes.length,
                        itemBuilder: (context, index) {
                          final note = allNotes.elementAt(index);
                          // print(notes[index].toString());
                          return ListTile(
                            onTap: () {
                              // kendi onTapi
                              //onTap(note);
                            },
                            title: Text(
                              note.note,
                              maxLines: 1, //bu 3 satır tüm yazılar yerine bir satır gözükmesini
                              softWrap: true, // ve satır sonunda ..... olmasını sağlıyor
                              overflow: TextOverflow.ellipsis, //
                            ),
                            trailing: IconButton(
                              // her elemanın en solunda bu simge var ve onpressed var
                              onPressed: () async {
                                // final shouldDelete = await showDeleteDialog(context);
                                // if (shouldDelete) {
                                //   onDeleteNote(note); // void Function(DatabaseNote note);
                                // }
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          );
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  default:
                    return const CircularProgressIndicator();
                }
              },
            ),
            CustomTextFormField(
              controller: _noteController,
              textInputType: TextInputType.name,
              hintText: 'add note',
            ),
            ElevatedButton(
              onPressed: () {
                GroupNoteCloudFireStoreService.instance.createNewNote(
                  note: _noteController.text,
                  ownerUserId: AuthService.firebase().currentUser!.id,
                  groupName: widget.groupName,
                );
              },
              child: const Text('add note'),
            ),
          ],
        ),
      ),
    );
  }
}
