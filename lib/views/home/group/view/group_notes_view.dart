import 'package:flutter/material.dart';
import 'package:groupnotes/core/constants/navigation/routes.dart';
import 'package:groupnotes/services/auth/auth_service.dart';
import 'package:groupnotes/services/cloudfirestore/group/group-service.dart';
import 'package:groupnotes/views/home/group/model/group_model.dart';
import 'package:groupnotes/views/home/group/view/group_notes_notes_view.dart';

class GroupNotesView extends StatefulWidget {
  const GroupNotesView({Key? key}) : super(key: key);

  @override
  State<GroupNotesView> createState() => GroupNotesViewState();
}

class GroupNotesViewState extends State<GroupNotesView> {
  List<GroupModel>? groups;
  @override
  void initState() {
    super.initState();
    getGroups();
  }

  Future<void> getGroups() async {
    groups =
        await GroupCloudFireStoreService.instance.getGroupsBelongToUser(id: AuthService.firebase().currentUser!.id);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return groups == null
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'GroupNotes',
                style: TextStyle(color: Colors.red),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(NavigationConstants.createGroup);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            body: Column(
              children: groups!
                  .map((group) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GroupNotesNotesView(
                                      groupName: group.groupName,
                                    )),
                          );
                        },
                        child: ListTile(
                          title: Text(group.groupName),
                        ),
                      ))
                  .toList(),
            ),
          );
  }
}
