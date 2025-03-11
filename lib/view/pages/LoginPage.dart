import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({super.key, required this.title});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String _errorMessage = '';

  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
            return AlertDialog(
                title: Text('Error'),
                content: Text(errorMessage),
                actions: <Widget>[
                TextButton(
                    child: Text('OK'),
                    onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    },
                ),
                ],
            );
        });
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = ''; //clear previous errors
      });

      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Navigate to the home screen or another logged-in screen
        Navigator.pushReplacementNamed(context, '/home'); //Replace '/home' with your route.

      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.message ?? 'An error occurred.';
        });
        print('Firebase Auth Error: ${e.code}, ${e.message}'); //For debugging
      } catch (e) {
         setState(() {
          _isLoading = false;
          _errorMessage = 'An unexpected error occurred.';
        });
        print('Unexpected Error: $e');
      }
    } else {
      setState(() {
        _errorMessage = 'Please fix the errors in the form.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text('Login'),
              ),
              TextButton(onPressed: (){Navigator.pushNamed(context, '/register');}, child: Text("Register")),//replace /register with your register route.
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}