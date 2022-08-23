import 'package:flutter/material.dart';
import 'package:groupnotes/core/constants/navigation/routes.dart';
import 'package:groupnotes/views/auth/login/view/login_view.dart';
import 'package:groupnotes/views/home/group/view/create_new_group_view.dart';
import 'package:groupnotes/views/home/group/view/group_notes_view.dart';
import 'package:groupnotes/views/home/home_view.dart';
import 'package:groupnotes/views/home/personalnotes/create_update_note_view.dart';
import 'package:groupnotes/views/home/personalnotes/notes_view.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case NavigationConstants.createOrUpdateNoteRoute:
        return normalNavigate(const CreateUpdateNoteView());

      case NavigationConstants.personalNotes:
        return normalNavigate(const NotesView());

      case NavigationConstants.home:
        return normalNavigate(const HomeView());

      case NavigationConstants.groupNotes:
        return normalNavigate(const GroupNotesView());
      case NavigationConstants.createGroup:
        return normalNavigate(
          const CreateNewGroupView(),
        );
      case NavigationConstants.login:
        return normalNavigate(
          const LoginView(),
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

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
