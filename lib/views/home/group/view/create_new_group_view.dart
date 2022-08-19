import 'package:flutter/material.dart';
import 'package:groupnotes/services/auth/auth_service.dart';
import 'package:groupnotes/services/cloudfirestore/group/group-service.dart';
import 'package:groupnotes/views/_product/_widgets/textformfield/custom_text_form_field.dart';

class CreateNewGroupView extends StatefulWidget {
  const CreateNewGroupView({Key? key}) : super(key: key);

  @override
  State<CreateNewGroupView> createState() => CreateNewGroupViewState();
}

class CreateNewGroupViewState extends State<CreateNewGroupView> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController groupNameController;
  @override
  void initState() {
    groupNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CreateNewGroup',
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: groupNameController,
              textInputType: TextInputType.name,
              hintText: 'group name',
            ),
            ElevatedButton(
              onPressed: () {
                GroupCloudFireStoreService.instance.createGroup(
                  groupName: groupNameController.text,
                  founderId: AuthService.firebase().currentUser!.id,
                );
              },
              child: const Text('create group'),
            ),
          ],
        ),
      ),
    );
  }
}
