import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:extras2/cubits/profiles/profiles_cubit.dart';
import 'package:extras2/utils/constants.dart';
import 'package:extras2/pages/splash_page.dart';
import 'package:extras2/main_app/map.dart';
import 'package:extras2/cubits/rooms/rooms_cubit.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://rwjwihrcmkpzjaccmesq.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ3andpaHJjbWtwemphY2NtZXNxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjgzODc1OTIsImV4cCI6MjA0Mzk2MzU5Mn0.uUcEFMVI2wIl5uav1Cbcg_L88_glZ_3xWm3ya6TTDB4',
    authCallbackUrlHostname: 'login',
  );

  // Set the app to immersive mode and landscape orientation
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive); // Hides top/bottom bars
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfilesCubit>(
          create: (context) => ProfilesCubit(),
        ),
        BlocProvider<RoomCubit>(
          create: (context) => RoomCubit(),
        ),

      ],
      child: MaterialApp(
        title: 'SupaChat',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: SplashPage(), // Set the home screen to MapScreen
      ),
    );
  }
}
