import 'package:flutter/material.dart';

import 'models/member.dart';
import 'screens/detail_screen.dart';
import 'screens/home_screen.dart';
import 'screens/registration_screen.dart';
import 'theme.dart';

void main() => runApp(const KindredApp());

class KindredApp extends StatelessWidget {
  const KindredApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kindred',
      debugShowCheckedModeBanner: false,
      theme: KindredTheme.data(),
      initialRoute: HomeScreen.route,
      routes: {
        HomeScreen.route: (_) => const HomeScreen(),
        RegistrationScreen.route: (_) => const RegistrationScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == DetailScreen.route) {
          final member = settings.arguments as Member?;
          if (member == null) {
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const RegistrationScreen(),
            );
          }
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => DetailScreen(member: member),
          );
        }
        return null;
      },
    );
  }
}
