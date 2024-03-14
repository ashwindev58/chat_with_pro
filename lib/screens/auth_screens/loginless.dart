import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../dashboard/dashboardscreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final ValueNotifier<bool> _isLoginForm = ValueNotifier(true);
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(false);
  final ValueNotifier<bool> _rememberMe = ValueNotifier(false);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
            valueListenable: _isLoginForm,
            builder: (BuildContext context, var a, var b) {
              return Text(_isLoginForm.value ? 'Login' : 'Registration');
            }),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ValueListenableBuilder(
                    valueListenable: _isLoginForm,
                    builder: (BuildContext context, var a, Widget? child) {
                      return _buildTabSwitcher();
                    }),
                const SizedBox(height: 20),
                _buildTextFields(),
                const SizedBox(height: 20),
                ValueListenableBuilder(
                    valueListenable: _isLoginForm,
                    builder: (BuildContext context, var a, var c) {
                      print("print fffffffff ----- $a $c");
                      return _buildTermsAndConditions();
                    }),
                // const SizedBox(height: 20),
                _buildRememberMeCheckbox(),
                const SizedBox(height: 10),
                _buildLoginOrRegisterButton(),

                _buildForgotPasswordLink(),
                _buildSocialMediaButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTab('Login', _isLoginForm.value),
        const SizedBox(width: 20),
        _buildTab('Register', !_isLoginForm.value),
      ],
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    log("buildtaab");
    return GestureDetector(
      onTap: () {
        _isLoginForm.value = text == 'Login';
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: isSelected ? FontWeight.bold : null,
          color: isSelected ? Colors.white : Colors.grey[300],
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return ValueListenableBuilder(
        valueListenable: _isLoginForm,
        builder: (BuildContext context, var a, var c) {
          return Column(
            children: [
              TextField(
                controller:
                    _isLoginForm.value ? _usernameController : _nameController,
                decoration: InputDecoration(
                    labelText:
                        _isLoginForm.value ? 'Username or Email' : 'Name'),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder(
                  valueListenable: _isPasswordVisible,
                  builder: (BuildContext context, var a, var c) {
                    return TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            _isPasswordVisible.value =
                                !_isPasswordVisible.value;
                          },
                        ),
                      ),
                      obscureText: !_isPasswordVisible.value,
                      style: const TextStyle(color: Colors.white),
                    );
                  }),
              if (!_isLoginForm.value) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: _confirmPasswordController,
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ],
          );
        });
  }

  Widget _buildTermsAndConditions() {
    if (!_isLoginForm.value) {
      return Row(
        children: [
          Checkbox(
            value: _rememberMe.value,
            onChanged: (value) {
              _rememberMe.value = value!;
            },
          ),
          const Text('I agree to the Terms and Conditions',
              style: TextStyle(color: Colors.white)),
        ],
      );
    }
    return Container();
  }

  Widget _buildLoginOrRegisterButton() {
    return ValueListenableBuilder(
        valueListenable: _isLoginForm,
        builder: (BuildContext context, var c, var e) {
          return ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(),
                ),
              );
              // Perform login or registration logic here
              // You can validate fields and show error messages if needed
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              _isLoginForm.value ? 'Login' : 'Register',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          );
        });
  }

  Widget _buildRememberMeCheckbox() {
    return ValueListenableBuilder(
        valueListenable: _isLoginForm,
        builder: (BuildContext context, var a, var e) {
          if (_isLoginForm.value) {
            return Row(
              children: [
                ValueListenableBuilder(
                    valueListenable: _rememberMe,
                    builder: (BuildContext context, var a, var b) {
                      return Checkbox(
                        value: _rememberMe.value,
                        onChanged: (value) {
                          _rememberMe.value = value!;
                        },
                      );
                    }),
                const Text('Remember Me',
                    style: TextStyle(color: Colors.white)),
              ],
            );
          }
          return Container();
        });
  }

  Widget _buildForgotPasswordLink() {
    return ValueListenableBuilder(
        valueListenable: _isLoginForm,
        builder: (BuildContext context, var c, var d) {
          if (_isLoginForm.value) {
            return TextButton(
              onPressed: () {
                // Navigate to the password recovery/reset page
              },
              child: const Text('Forgot Password?',
                  style: TextStyle(color: Colors.white)),
            );
          }
          return Container();
        });
  }

  Widget _buildSocialMediaButtons() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text('Or continue with:', style: TextStyle(color: Colors.white)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.facebook),
              onPressed: () {
                // Perform Facebook login or registration
              },
            ),
            IconButton(
              icon: const Icon(Icons.cabin),
              onPressed: () {
                // Perform Twitter login or registration
              },
            ),
            IconButton(
              icon: const Icon(Icons.abc_outlined),
              onPressed: () {
                // Perform Google login or registration
              },
            ),
          ],
        ),
      ],
    );
  }
}
