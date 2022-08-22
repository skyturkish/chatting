import 'package:flutter/material.dart';
import 'package:groupnotes/core/init/navigation/navigation_service.dart';
import 'package:groupnotes/services/auth/auth_service.dart';
import 'package:groupnotes/services/cloudfirestore/group/group-service.dart';
import 'package:groupnotes/views/home/group/model/group_model.dart';
import 'package:groupnotes/views/home/group/view/group_notes_notes_view.dart';
import 'package:lottie/lottie.dart';

class GroupNotesView extends StatefulWidget {
  const GroupNotesView({Key? key}) : super(key: key);

  @override
  State<GroupNotesView> createState() => GroupNotesViewState();
}

class GroupNotesViewState extends State<GroupNotesView> {
  List<GroupModel>? groups;
  List<GroupModel>? allGroups;

  @override
  void initState() {
    super.initState();
    getGroups();
  }

  Future<void> getGroups() async {
    groups =
        await GroupCloudFireStoreService.instance.getGroupsBelongToUser(id: AuthService.firebase().currentUser!.id);
    allGroups = await GroupCloudFireStoreService.instance.getAllGroups();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return groups == null
        ? Scaffold(
            body: Center(
              child: Lottie.asset(
                'assets/lotties/taking_notes.json',
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'GroupNotes',
                style: TextStyle(color: Colors.red),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    NavigationService.instance.navigateToPage(path: '/create-group');
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            body: Column(
              children: [
                Column(
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
                              leading: const Icon(Icons.group),
                              title: Text(group.groupName),
                              trailing: Text(
                                  group.members.contains(AuthService.firebase().currentUser!.id) ? 'aktif' : 'pasif'),
                            ),
                          ))
                      .toList(),
                ),
                const Text('adanaaaa'),
                Column(
                  children: allGroups!
                      .map(
                        (group) => ListTile(
                          leading: const Icon(Icons.group),
                          title: Text(group.groupName),
                          trailing: group.members.contains(AuthService.firebase().currentUser!.id)
                              ? IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
                              : IconButton(
                                  onPressed: () {
                                    GroupCloudFireStoreService.instance.joinGroup(
                                      groupName: group.groupName,
                                      id: AuthService.firebase().currentUser!.id,
                                    );
                                  },
                                  icon: const Icon(Icons.add)),
                        ),
                      )
                      .toList(),
                ),
              ],
            ));
  }
}
