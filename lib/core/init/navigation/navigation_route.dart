import 'package:flutter/material.dart';
import 'package:groupnotes/core/constants/navigation/routes.dart';
import 'package:groupnotes/views/home/group/view/create_new_group_view.dart';
import 'package:groupnotes/views/home/group/view/group_notes_view.dart';
import 'package:groupnotes/views/home/home_view.dart';
import 'package:groupnotes/views/home/personalnotes/create_update_note_view.dart';
import 'package:groupnotes/views/home/personalnotes/notes_view.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case NavigationConstants.createOrUpdateNoteRoute:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CreateUpdateNoteView(),
      );
    case NavigationConstants.personalNotes:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NotesView(),
      );
    case NavigationConstants.home:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeView(),
      );
    case NavigationConstants.groupNotes:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const GroupNotesView(),
      );
    case NavigationConstants.createGroup:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CreateNewGroupView(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
