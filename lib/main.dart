import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_supabse_codelab/common/environment.dart';
import 'package:flutter_supabse_codelab/pages/account_page.dart';
import 'package:flutter_supabse_codelab/pages/login_page.dart';
import 'package:flutter_supabse_codelab/pages/splash_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: Environment.fileName);

  //  supabase - initialize
  await Supabase.initialize(
    url: Environment.supabaseUrl,
    anonKey: Environment.supabaseKey,
  );

  runApp(const MyApp());
}

// supabase - instance
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Supabase Codelab',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/account': (context) => const AccountPage(),
      },
    );
  }
}
