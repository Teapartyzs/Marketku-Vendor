import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marketku_vendor/global_variables.dart';
import 'package:marketku_vendor/src/controllers/dio_controller.dart';
import 'package:marketku_vendor/src/providers/vendor_provider.dart';
import 'package:marketku_vendor/src/views/screens/main/main_screen.dart';
import 'package:marketku_vendor/src/views/screens/register/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerContainer = ProviderContainer();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return StateLoginScreen();
  }
}

class StateLoginScreen extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  void submitLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        "$url/api/vendor/signin".postData(
          {"email": email, "password": password},
          (result, message) async {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString("token", result['token']);
            providerContainer
                .read(vendorProvider.notifier)
                .setVendor(jsonEncode(result['Vendor']));
            await sharedPreferences.setString(
                "vendor_user", jsonEncode(result['Vendor']));
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Login Success $message"),
              ),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ),
            );
          },
        );
      } on DioException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login failed ${e.response?.data}"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "MARKETKU VENDOR",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
              const SizedBox(
                height: 32,
              ),
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  label: Text("Email"),
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  hintText: "Input your email",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || value == "") {
                    return "Please input your email";
                  }
                  return null;
                },
                initialValue: '',
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  label: Text("Password"),
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  hintText: "Input your password",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || value == "") {
                    return "Please input your password";
                  }
                  return null;
                },
                obscureText: true,
                initialValue: '',
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    submitLogin();
                  },
                  style: FilledButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Create account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "click here",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
