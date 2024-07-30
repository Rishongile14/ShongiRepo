import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mymapapp/provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
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
      setState(() {
        _isLoading = true;
      });

      try {
        var response = await http.post(
          Uri.parse('http://172.16.12.84:5001/login'),
          headers: const {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": _emailController.text,
            "password": _passwordController.text,
          }),
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          print(data);

          if (data['info'] != null) {
            setState(() {
              email = data['info']['email'];
              id = data['info']['id'];
              _isLoading = false;
            });

            final userProvider = Provider.of<UserProvider>(context, listen: false);
            userProvider.setEmail(data['info']['email']);
            userProvider.setId(data['info']['id']);

            Navigator.pushReplacementNamed(context, '/home');
          } else {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login failed. Incorrect email or password.')),
            );
          }
        } else {
          setState(() {
            _isLoading = false;
          });
          print('Failed to login. Status code: ${response.statusCode}');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login failed. Server returned an error.')),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print('An error occurred: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred. Please try again.')),
        );
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
          child: _isLoading
              ? const CircularProgressIndicator(color: Color.fromRGBO(117, 117, 117, 1),)
              : Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(CupertinoIcons.person_alt),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
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
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(CupertinoIcons.lock_fill),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
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
