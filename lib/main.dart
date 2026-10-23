import 'package:flutter/material.dart';
import 'package:pertemuan1/providers/app_state_provider.dart';
import 'package:provider/provider.dart';
import 'config/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppStateProvider(),
      child: MaterialApp.router( //tambahkan router untuk navigasi
        title: 'Anime Verse',
        theme: ThemeData(
          fontFamily: 'Urbanist',
        ),
        routerConfig: createRouter(), //gunakan createRouter untuk konfigurasi router
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
