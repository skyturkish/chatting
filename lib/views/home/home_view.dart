import 'package:flutter/material.dart';
import 'package:groupnotes/core/constants/navigation/routes.dart';
import 'package:groupnotes/core/mixin/log_mixin.dart';
import 'package:groupnotes/services/cloudfirestore/group/group-service.dart';

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
      )),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(NavigationConstants.groupNotes);
            },
            child: const Text('GroupNotes'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(NavigationConstants.personalNotes);
            },
            child: const Text('notes'),
          ),
          ElevatedButton(
            onPressed: () async {
              final adana = await GroupCloudFireStoreService.instance.isGroupExist(groupName: 'adana');
              final bursa = await GroupCloudFireStoreService.instance.isGroupExist(groupName: 'bursa');
              devtoolsLog(adana.toString());
              devtoolsLog(bursa.toString());
            },
            child: const Text('gruba katıl'),
          ),
        ],
      ),
    );
  }
}
