import 'package:flutter/material.dart';
import 'package:groupnotes/core/constants/navigation/routes.dart';
import 'package:groupnotes/core/init/navigation/navigation_service.dart';
import 'package:groupnotes/services/auth/auth_service.dart';
import 'package:groupnotes/services/cloudfirestore/user/user-service.dart';
import 'package:groupnotes/views/_product/_widgets/textformfield/custom_text_form_field.dart';
import 'package:groupnotes/views/createcharacter/model/user_model.dart';
import 'package:groupnotes/views/home/home_view.dart';

class CreateUserView extends StatefulWidget {
  const CreateUserView({Key? key}) : super(key: key);

  @override
  State<CreateUserView> createState() => CreateUserViewState();
}

class CreateUserViewState extends State<CreateUserView> {
  final ValueNotifier<bool?> gender = ValueNotifier(null);

  late final TextEditingController nameController;
  late final TextEditingController surNameController;

  @override
  void initState() {
    nameController = TextEditingController();
    surNameController = TextEditingController();
    userExistOrNot();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    surNameController.dispose();

    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  bool? isUserExist;

  Future<void> userExistOrNot() async {
    bool isExist = await UserCloudFireStoreService.instance.isUserExist(userId: AuthService.firebase().currentUser!.id);

    isUserExist = isExist;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isUserExist == null
        ? const CircularProgressIndicator()
        : isUserExist == true
            ? const HomeView()
            : Scaffold(
                appBar: AppBar(
                    title: const Text(
                  'CreateUser',
                  style: TextStyle(color: Colors.red),
                )),
                body: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: nameController,
                        textInputType: TextInputType.name,
                        hintText: 'name',
                      ),
                      CustomTextFormField(
                        controller: surNameController,
                        textInputType: TextInputType.name,
                        hintText: 'surName',
                      ),
                      GenderChoose(gender: gender),
                      ElevatedButton(
                          onPressed: () async {
                            final userInformations = UserModel(
                              id: AuthService.firebase().currentUser!.id,
                              name: nameController.text,
                              surName: surNameController.text,
                              groupNames: const [],
                              gender: gender.value!,
                            );
                            // null koyduk adama seçtirmek zorundasın

                            await UserCloudFireStoreService.instance.createUser(user: userInformations);

                            bool isExist = await UserCloudFireStoreService.instance
                                .isUserExist(userId: AuthService.firebase().currentUser!.id);
                            //isUserExist = isExist;
                            //setState(() {});
                            if (isExist == true) {
                              NavigationService.instance.navigateToPageClear(path: NavigationConstants.home);
                            }
                          },
                          child: const Text('create my account'))
                    ],
                  ),
                ),
              );
  }
}

class GenderChoose extends StatelessWidget {
  const GenderChoose({
    Key? key,
    required this.gender,
  }) : super(key: key);

  final ValueNotifier<bool?> gender;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: gender,
      builder: (context, value, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              gender.value = true;
            },
            style: ElevatedButton.styleFrom(
              primary: gender.value == null || gender.value == false
                  ? const Color.fromARGB(255, 92, 161, 207)
                  : const Color.fromARGB(255, 37, 131, 41),
            ),
            child: const Text(
              'man',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                gender.value = false;
              },
              style: ElevatedButton.styleFrom(
                primary: gender.value == null || gender.value == true
                    ? const Color.fromARGB(255, 92, 161, 207)
                    : const Color.fromARGB(255, 37, 131, 41),
              ),
              child: const Text(
                'woman',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
