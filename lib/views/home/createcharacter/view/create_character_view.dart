import 'package:flutter/material.dart';
import 'package:groupnotes/services/auth/auth_service.dart';
import 'package:groupnotes/views/home/createcharacter/model/user_model.dart';
import 'package:groupnotes/views/home/createcharacter/service/create_user.dart';

class CreateCharacterView extends StatefulWidget {
  const CreateCharacterView({Key? key}) : super(key: key);

  @override
  State<CreateCharacterView> createState() => CreateCharacterViewState();
}

class CreateCharacterViewState extends State<CreateCharacterView> {
  String isim = 'gelmedi henüz';
  UserModel? kral;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _surNameController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _surNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CreateCharacter',
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'name'),
            ),
            TextFormField(
              controller: _surNameController,
              decoration: const InputDecoration(hintText: 'surName'),
            ),
            ElevatedButton(
              onPressed: () async {
                kral = await CreateUserFirebaseCloudStorage()
                    .createUser(ownerUserId: AuthService.firebase().currentUser!.id, name: _nameController.text);
              },
              child: const Text('create user'),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text('ad getir')),
            Text(kral?.name ?? ' girilmedi')
          ],
        ),
      ),
    );
  }
}
