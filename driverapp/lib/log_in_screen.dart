import 'dart:convert';
import 'package:driverapp/driver_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? email;
  int? id;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> searchUser() async {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      try {
        var response = await http.post(
          Uri.parse('http://192.168.231.155:5001/searchdriver'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": _emailController.text,
            "password": _passwordController.text,
          }),
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          print(data);

          if (data['info'] != null) {
            if (mounted) {
              setState(() {
                email = data['info']['email'];
                id = data['info']['id'];
              });

              final driverProvider = Provider.of<DriverProvider>(context, listen: false);
              driverProvider.setEmail(data['info']['email']);
              driverProvider.setId(data['info']['driver_id']);

              Navigator.pushReplacementNamed(context, '/home');
            }
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login failed. Incorrect email or password.'),
                ),
              );
            }
          }
        } else {
          print('Failed to login. Status code: ${response.statusCode}');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login failed. Server returned an error.'),
              ),
            );
          }
        }
      } catch (e) {
        print('An error occurred: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An error occurred. Please try again.'),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(CupertinoIcons.person_alt),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(CupertinoIcons.lock_fill),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the password';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[600],
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            searchUser();
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text('Don\'t have an account? Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
