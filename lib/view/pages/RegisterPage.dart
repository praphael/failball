import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterPage extends StatefulWidget {
  final String title;

  const RegisterPage({super.key, required this.title});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
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
       }
    );
  }

  Future<void> _register() async {
    CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = ''; //clear previous errors
      });

      try {
        final passwd = _passwordController.text.trim();
        final passwd2 = _password2Controller.text.trim();
        if(passwd != passwd2) {
            showErrorDialog(context, "Passwords do not match");
        }
        final email = _emailController.text.trim();

        final user=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: passwd)
            .then((value) async {
            // try {
            //     QuerySnapshot querySnapshot = await showCollection
            //         .where('code', isEqualTo: code)
            //         .get();

            //     if (querySnapshot.docs.isEmpty) {
            //     Fluttertoast.showToast(
            //         msg: "No matching Code.",
            //         toastLength: Toast.LENGTH_SHORT,
            //         gravity: ToastGravity.BOTTOM,
            //         timeInSecForIosWeb: 1,
            //         textColor: Colors.white,
            //         fontSize: 16.0
            //     );
            //     return "";
            //     }

            //     // Since there should be only one document with this code, return the first one
            //     DocumentSnapshot document = querySnapshot.docs.first;
            //     showCollection.doc(document.id).update({
            //     'admin': FieldValue.arrayUnion([
            //         FirebaseAuth.instance.currentUser!.uid
            //     ])
            //     });

            //     firebaseMessaging.subscribeToTopic(document.id).then((value) => {
            //     print("successfully subscribed")
            //     });
            //     var firebaseUser =
            //         FirebaseAuth.instance.currentUser;
            //     if(CImage.value!=null)
            //     {
            //     Reference reference = FirebaseStorage.instance
            //         .ref()
            //         .child('users/${firebaseUser!.uid}');
            //     UploadTask uploadTask = reference.putFile(io.File(CImage.value!.path));
            //     TaskSnapshot snapshot = await uploadTask;
            //     String imageUrl = await snapshot.ref.getDownloadURL();
            //     print(imageUrl);
            //     await userCollection
            //         .doc(firebaseUser.uid)
            //         .set({
            //         'uid': firebaseUser.uid,
            //         'firstName':users.firstName,
            //         'lastName':users.lastName,
            //         'email': users.email,
            //         'role': users.role,
            //         'loginstatus': true,
            //         'image':imageUrl,
            //     }).then((value) {
            //         Fluttertoast.showToast(
            //             msg: "User Added Successfully",
            //             toastLength: Toast.LENGTH_SHORT,
            //             gravity: ToastGravity.BOTTOM,
            //             timeInSecForIosWeb: 1,
            //             textColor: Colors.white,
            //             fontSize: 16.0
            //         );
            //     }
            //     )
            //         .catchError((error) =>
            //         print("Failed to add user: $error"));
            //     }
            //     else{
            //     await userCollection
            //         .doc(firebaseUser?.uid)
            //         .set({
            //         'uid': firebaseUser!.uid,
            //         'firstName':users.firstName,
            //         'lastName':users.lastName,
            //         'email': users.email,
            //         'role': users.role,
            //         'loginstatus': "true",
            //         'image':users.image,

            //     }).then((value) {
            //         Fluttertoast.showToast(
            //             msg: "Information Updated Successfully",
            //             toastLength: Toast.LENGTH_SHORT,
            //             gravity: ToastGravity.BOTTOM,
            //             timeInSecForIosWeb: 1,
            //             textColor: Colors.white,
            //             fontSize: 16.0
            //         );
            //     }
            //     )
            //         .catchError((error) =>
            //         print("Failed to add user: $error"));
            //     }
            // } catch (error) {
            //     print('Error getting document: $error');
            // }


            });

        // await (
        //   username: _usernameController.text.trim(),
        //   email: _emailController.text.trim(),
        //   password: passwd, 
        // );

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
      appBar: AppBar(title: Text('Register')),
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
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Desired username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter desired username';
                  }
                  return null;
                },
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
              TextFormField(
                controller: _password2Controller,
                decoration: InputDecoration(labelText: 'Re-type Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password again';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _register,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text('Register'),
              ),
              // TextButton(onPressed: (){Navigator.pushNamed(context, '/register');}, child: Text("Register")),//replace /register with your register route.
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