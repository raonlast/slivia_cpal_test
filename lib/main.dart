import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silvia_cpal_test/features/home/presentation/pages/home_page.dart';
import 'package:silvia_cpal_test/shared/providers/record_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RecordProvider(),
        )
      ],
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Silvia CPAL Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
