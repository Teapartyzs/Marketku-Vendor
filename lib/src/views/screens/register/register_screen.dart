import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marketku_vendor/global_variables.dart';
import 'package:marketku_vendor/src/controllers/dio_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return StateRegisterScreen();
  }
}

class StateRegisterScreen extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String email;
  late String password;
  late String confirmPassword;
  void submitRegister() async {
    if (_formKey.currentState!.validate()) {
      try {
        "$url/api/vendor/signup".postData(
          {"fullname": name, "email": email, "password": password},
          (result, message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Register Success $message"),
              ),
            );
          },
        );
      } on DioException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Register failed ${e.response?.data}"),
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
                  name = value;
                },
                decoration: InputDecoration(
                  label: Text("Name"),
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  hintText: "Input your name",
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
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty || value == "") {
                    return "Please input your name";
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
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
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
                  confirmPassword = value;
                },
                decoration: InputDecoration(
                  label: Text("Confirm Password"),
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  hintText: "Input your confirm password",
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
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty || value == "") {
                    return "Please input your confirm password";
                  }
                  if (value != password) {
                    return "Password not match";
                  }
                  return null;
                },
                initialValue: '',
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    submitRegister();
                  },
                  style: FilledButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
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
