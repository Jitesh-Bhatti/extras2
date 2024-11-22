import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> _login() async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response.session != null) {
        print("Login successful");
        Navigator.of(context).pushReplacementNamed('/rooms');
      } else {
        throw Exception("Login failed");
      }
    } catch (e) {
      print("Login error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
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
              onPressed: _login,
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:extras2/utils/constants.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   static Route<void> route() {
//     return MaterialPageRoute(
//         builder: (context) => const LoginPage());
//   }
//
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   bool _isLoading = false;
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   Future<void> _signIn() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final response = await supabase.auth.signInWithPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//
//       // Check if login is successful
//       if (response.user != null) {
//         // Optionally, you can get the username
//         final username = response.user?.userMetadata?['username'] ?? 'Guest';
//
//         // You can save the username or use it in your app as needed
//         // For example, you might want to navigate to another page
//         // Navigator.of(context).pushReplacement(YourNextPage.route());
//       }
//     } on AuthException catch (error) {
//       context.showErrorSnackBar(message: error.message);
//     } catch (_) {
//       context.showErrorSnackBar(
//           message: unexpectedErrorMessage);
//     }
//     if (mounted) {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Sign In')),
//       body: ListView(
//         padding: formPadding,
//         children: [
//           TextFormField(
//             controller: _emailController,
//             decoration:
//             const InputDecoration(labelText: 'Email'),
//             keyboardType: TextInputType.emailAddress,
//           ),
//           const SizedBox(height: 40,),
//           TextFormField(
//             controller: _passwordController,
//             decoration: const InputDecoration(
//                 labelText: 'Password'),
//             obscureText: true,
//           ),
//           const SizedBox(height: 40,),
//           ElevatedButton(
//             onPressed: _isLoading ? null : _signIn,
//             child: const Text('Login'),
//           ),
//         ],
//       ),
//     );
//   }
// }
