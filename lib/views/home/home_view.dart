import 'package:flutter/material.dart';
import 'package:groupnotes/core/constants/navigation/routes.dart';
import 'package:groupnotes/core/extensions/context/context_extension.dart';
import 'package:groupnotes/core/init/navigation/navigation_service.dart';
import 'package:groupnotes/core/mixin/log_mixin.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> with Logger {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.red),
        ),
        actions: [
          IconButton(
              onPressed: () {
                NavigationService.instance.navigateToPageClear(path: NavigationConstants.login);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: context.dynamicHeight(0.6),
              width: context.dynamicWidth(0.4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color.fromARGB(255, 228, 185, 91), Color.fromARGB(255, 32, 21, 8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(
                onPressed: () {
                  NavigationService.instance.navigateToPage(path: NavigationConstants.groupNotes);
                },
                child: Text(
                  'group chat',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
            Container(
              height: context.dynamicHeight(0.6),
              width: context.dynamicWidth(0.4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color.fromARGB(255, 228, 185, 91), Color.fromARGB(255, 32, 21, 8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(
                onPressed: () {
                  NavigationService.instance.navigateToPage(path: NavigationConstants.personalNotes);
                },
                child: Text(
                  'personal notes',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
