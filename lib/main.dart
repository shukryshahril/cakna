import 'package:cakna/provider/rooms.dart';
import 'package:cakna/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'auth/authentication_service.dart';
import 'auth/sign_in_page.dart';
import 'config/palette.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
            providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<AuthenticationService>().authStateChanges, initialData: null,
          ),
          ChangeNotifierProvider(
            create: (context) => RoomsProvider(),
          )
        ],
          child: MaterialApp(
        title: 'Flutter Clubhouse UI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(backgroundColor: Palette.background),
          scaffoldBackgroundColor: Palette.background,
          primaryColor: Colors.white,
          accentColor: Palette.green,
          iconTheme: const IconThemeData(color: Colors.black),
          fontFamily: GoogleFonts.montserrat().fontFamily,
          textTheme: GoogleFonts.montserratTextTheme(),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          /* dark theme settings */
        ),
        themeMode: ThemeMode.light,
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomeScreen();
    }
    return SignInPage();
  }
}
