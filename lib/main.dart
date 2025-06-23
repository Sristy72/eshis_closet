import 'package:eshis_closet/screen/category_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'firebase_options.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Initialize Supabase
  await Supabase.initialize(url: 'https://dskisvegrrymgvheztzb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRza2lzdmVncnJ5bWd2aGV6dHpiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA1MzMxODgsImV4cCI6MjA2NjEwOTE4OH0.fmXGMzJNR6tletY8Hb4LI3mjXfkJv6Or0HmCeDcXdB0',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CategoryScreen(),
    );
  }
}
