import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_notdefteri/tools/locator.dart';
import 'package:firebase_notdefteri/view/HomePage.dart';
import 'package:firebase_notdefteri/viewModel/HomePageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home:MultiProvider(providers: [
         ChangeNotifierProvider(create: (context)=>HomePageViewModel()),
       ],
         child: HomePage(),
       ),
    );
  }
}
