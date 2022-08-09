import 'package:flutter/material.dart';
import 'package:groupnotes/core/constants/navigation/routes.dart';
import 'package:groupnotes/views/home/home_view.dart';
import 'package:groupnotes/views/home/notes/create_update_note_view.dart';
import 'package:groupnotes/views/home/notes/notes_view.dart';

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
