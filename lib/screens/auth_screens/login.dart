import 'package:flutter/material.dart';



class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoginForm = true;
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginForm ? 'Login' : 'Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Switch Between Login and Registration Tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isLoginForm = true;
                      });
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: _isLoginForm ? FontWeight.bold : null,
                        color: _isLoginForm ? Colors.blue : null,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isLoginForm = false;
                      });
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: !_isLoginForm ? FontWeight.bold : null,
                        color: !_isLoginForm ? Colors.blue : null,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Text Input Fields
              TextField(
                controller: _isLoginForm ? _usernameController : _nameController,
                decoration: InputDecoration(labelText: _isLoginForm ? 'Username or Email' : 'Name'),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isPasswordVisible,
              ),
              if (!_isLoginForm) ...[
                SizedBox(height: 12),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                ),
              ],
              // Additional optional fields for user profile setup (if needed)
              // ...
          
              // Terms and Conditions Checkbox (only for Registration)
              if (!_isLoginForm) ...[
                SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                    ),
                    Text('I agree to the Terms and Conditions'),
                  ],
                ),
              ],
              SizedBox(height: 20),
              // Login or Register Button
              ElevatedButton(
                onPressed: () {
                  // Perform login or registration logic here
                  // You can validate fields and show error messages if needed
                },
                child: Text(_isLoginForm ? 'Login' : 'Register'),
              ),
              SizedBox(height: 10),
              // Remember Me Checkbox
              if (_isLoginForm) ...[
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                    ),
                    Text('Remember Me'),
                  ],
                ),
              ],
              // Forgot Password Link
              if (_isLoginForm) ...[
                TextButton(
                  onPressed: () {
                    // Navigate to the password recovery/reset page
                  },
                  child: Text('Forgot Password?'),
                ),
              ],
              // Social Media Login or Registration Buttons
              SizedBox(height: 20),
              Text('Or continue with:'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Social media login or registration buttons
                  // ...
          
                  // For example:
                  IconButton(
                    icon: Icon(Icons.facebook),
                    onPressed: () {
                      // Perform Facebook login or registration
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.abc),
                    onPressed: () {
                      // Perform Twitter login or registration
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.abc),
                    onPressed: () {
                      // Perform Google login or registration
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
