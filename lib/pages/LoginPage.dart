import 'package:apps/constant/route_constants.dart';
import 'package:apps/helper/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apps/providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Add a GlobalKey<FormState> for form validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Add a DbHelper instance
  final DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // Assign the form key
          child: Column(
            children: <Widget>[
              // Centered Image and Application Name
              Container(
                margin: const EdgeInsets.only(top: 200.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10), // Add spacing
                    Text(
                      "RM Apps",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      'assets/images/icon.png',
                      width: 200,
                      height: 150,
                    ),
                    Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue)),
                      labelText: 'Email',
                      hintText: "Enter valid email",
                      labelStyle: TextStyle(color: Colors.lightBlue)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue)),
                      labelText: 'Password',
                      hintText: 'Enter secure password',
                      labelStyle: TextStyle(color: Colors.lightBlue)),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                margin: const EdgeInsets.only(top: 30.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, attempt to log in
                      final email = emailController.text;
                      final password = passwordController.text;

                      // Call the login function from DbHelper
                      final loginSuccessful =
                          await dbHelper.loginUser(email, password);

                      if (loginSuccessful) {
                        // fetch user data
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                        await userProvider.fetchUserByEmail(email);

                        Navigator.pushNamed(context, homeRoute);
                      } else {
                        // Show an error message to the user
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Login Failed'),
                            content: const Text('Invalid email or password'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
