import 'package:flutter/material.dart';
import 'app_state.dart';
import 'screens/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppState.instance.load();
  runApp(const FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Orangtua Delivery',
    theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF28C28)), scaffoldBackgroundColor: const Color(0xFFFFFBF6), appBarTheme: const AppBarTheme(centerTitle: false)),
    home: const LoginPage(),
  );
}
