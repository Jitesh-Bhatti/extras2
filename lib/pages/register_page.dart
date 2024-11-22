import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> _register() async {
    try {
      final response = await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response.user != null) {
        print("Registration successful: ${response.user!.email}");
        // Navigate to the rooms page after successful registration
        Navigator.of(context).pushReplacementNamed('/rooms');
      } else {
        throw Exception("Registration failed.");
      }
    } catch (e) {
      print("Registration error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _register,
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:extras2/pages/login_page.dart';
// import 'package:extras2/pages/rooms_page.dart';
// import 'package:extras2/utils/constants.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// class RegisterPage extends StatefulWidget {
//   const RegisterPage(
//       {Key? key, required this.isRegistering})
//       : super(key: key);
//
//   static Route<void> route({bool isRegistering = false}) {
//     return MaterialPageRoute(
//       builder: (context) =>
//           RegisterPage(isRegistering: isRegistering),
//     );
//   }
//
//   final bool isRegistering;
//
//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }
//
// class _RegisterPageState extends State<RegisterPage> {
//   final bool _isLoading = false;
//
//   final _formKey = GlobalKey<FormState>();
//
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _usernameController = TextEditingController();
//
//   late final StreamSubscription<AuthState>
//   _authSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//
//     bool haveNavigated = false;
//     // Listen to auth state to redirect user when the user clicks on confirmation link
//     _authSubscription =
//         supabase.auth.onAuthStateChange.listen((data) {
//           final session = data.session;
//           if (session != null && !haveNavigated) {
//             haveNavigated = true;
//             Navigator.of(context)
//                 .pushReplacement(RoomsPage.route());
//           }
//         });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//
//     // Dispose subscription when no longer needed
//     _authSubscription.cancel();
//   }
//
//   Future<void> _signUp() async {
//     final isValid = _formKey.currentState!.validate();
//     if (!isValid) {
//       return;
//     }
//     final email = _emailController.text;
//     final password = _passwordController.text;
//     final username = _usernameController.text;
//     try {
//       await supabase.auth.signUp(
//         email: email,
//         password: password,
//         data: {'username': username},
//         emailRedirectTo: 'io.supabase.chat://login',
//       );
//       context.showSnackBar(
//           message:
//           'Please check your inbox for confirmation email.');
//     } on AuthException catch (error) {
//       context.showErrorSnackBar(message: error.message);
//     } catch (error) {
//       debugPrint(error.toString());
//       context.showErrorSnackBar(
//           message: unexpectedErrorMessage);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Register'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: formPadding,
//           children: [
//             TextFormField(
//               controller: _emailController,
//               decoration: const InputDecoration(
//                 label: Text('Email'),
//               ),
//               validator: (val) {
//                 if (val == null || val.isEmpty) {
//                   return 'Required';
//                 }
//                 return null;
//               },
//               keyboardType: TextInputType.emailAddress,
//             ),
//             SizedBox(height: 40,),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 label: Text('Password'),
//               ),
//               validator: (val) {
//                 if (val == null || val.isEmpty) {
//                   return 'Required';
//                 }
//                 if (val.length < 6) {
//                   return '6 characters minimum';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 40,),
//             TextFormField(
//               controller: _usernameController,
//               decoration: const InputDecoration(
//                 label: Text('Username'),
//               ),
//               validator: (val) {
//                 if (val == null || val.isEmpty) {
//                   return 'Required';
//                 }
//                 final isValid =
//                 RegExp(r'^[A-Za-z0-9_]{3,24}$')
//                     .hasMatch(val);
//                 if (!isValid) {
//                   return '3-24 long with alphanumeric or underscore';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 40,),
//             ElevatedButton(
//               onPressed: _isLoading ? null : _signUp,
//               child: const Text('Register'),
//             ),
//             // SizedBox(height: 40,),
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context)
//                       .push(LoginPage.route());
//                 },
//                 child:
//                 const Text('I already have an account'))
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
