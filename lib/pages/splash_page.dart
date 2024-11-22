import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'rooms_page.dart'; // Ensure this import is correct

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _autoLogin();
  }

  Future<void> _autoLogin() async {
    final deviceId = await _getOrGenerateDeviceId();
    final email = "$deviceId@device.com";
    final password = "password_$deviceId";
    final username = "user_$deviceId";

    try {
      // Attempt to log in
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        print("Login successful for device: $deviceId");
      } else {
        throw Exception("No session returned during login.");
      }
    } catch (e) {
      if (e.toString().contains("Invalid login credentials")) {
        print("Login failed. Attempting to sign up...");

        try {
          // Attempt sign-up
          final signUpResponse = await supabase.auth.signUp(
            email: email,
            password: password,
            data: {'username': username},
          );

          if (signUpResponse.user != null) {
            print("Sign-up successful for device: $deviceId");
          } else {
            throw Exception("Sign-up failed. User not created.");
          }
        } catch (signUpError) {
          print("Sign-up error: $signUpError");
        }
      } else {
        print("Unexpected authentication error: $e");
      }
    }

    // Navigate to RoomsPage
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => RoomsPage()),
      );
    }
  }

  Future<String> _getOrGenerateDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('device_id');

    if (deviceId != null) return deviceId;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? "unknown_ios_device";
      } else {
        deviceId = "unknown_device_${DateTime.now().millisecondsSinceEpoch}";
      }
    } catch (e) {
      deviceId = "fallback_device_${DateTime.now().millisecondsSinceEpoch}";
      print("Device ID generation error: $e");
    }

    await prefs.setString('device_id', deviceId);
    return deviceId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:extras2/pages/register_page.dart';
// import 'package:extras2/pages/rooms_page.dart';
// import 'package:extras2/utils/constants.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// /// Page to redirect users to the appropriate page depending on the initial auth state
// class SplashPage extends StatefulWidget {
//   const SplashPage({Key? key}) : super(key: key);
//
//   @override
//   SplashPageState createState() => SplashPageState();
// }
//
// class SplashPageState extends State<SplashPage> {
//   @override
//   void initState() {
//     getInitialSession();
//     super.initState();
//   }
//
//   Future<void> getInitialSession() async {
//     // quick and dirty way to wait for the widget to mount
//     await Future.delayed(Duration.zero);
//
//     try {
//       final session =
//       await SupabaseAuth.instance.initialSession;
//       if (session == null) {
//         Navigator.of(context).pushAndRemoveUntil(
//             RegisterPage.route(), (_) => false);
//       } else {
//         Navigator.of(context).pushAndRemoveUntil(
//             RoomsPage.route(), (_) => false);
//       }
//     } catch (_) {
//       context.showErrorSnackBar(
//         message: 'Error occurred during session refresh',
//       );
//       Navigator.of(context).pushAndRemoveUntil(
//           RegisterPage.route(), (_) => false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }
