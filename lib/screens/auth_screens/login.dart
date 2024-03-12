import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(),
    );
  }
}

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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginForm ? 'Login' : 'Registration'),
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
          height: double.infinity,width: double.infinity,
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
                          color: _isLoginForm ? Colors.white : Colors.grey[300],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
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
                          color: !_isLoginForm ? Colors.white : Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Text Input Fields
                TextField(
                  controller: _isLoginForm ? _usernameController : _nameController,
                  decoration: InputDecoration(labelText: _isLoginForm ? 'Username or Email' : 'Name'),
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
                  style: const TextStyle(color: Colors.white),
                ),
                if (!_isLoginForm) ...[
                  const SizedBox(height: 12),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
                // Additional optional fields for user profile setup (if needed)
                // ...
            
                // Terms and Conditions Checkbox (only for Registration)
                if (!_isLoginForm) ...[
                  const SizedBox(height: 12),
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
                      const Text('I agree to the Terms and Conditions', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
                // Login or Register Button
                ElevatedButton(
                  onPressed: () {
                    // Perform login or registration logic here
                    // You can validate fields and show error messages if needed
                  },
                  child: Text(_isLoginForm ? 'Login' : 'Register'),
                ),
                const SizedBox(height: 10),
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
                      const Text('Remember Me', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
                // Forgot Password Link
                if (_isLoginForm) ...[
                  TextButton(
                    onPressed: () {
                      // Navigate to the password recovery/reset page
                    },
                    child: const Text('Forgot Password?', style: TextStyle(color: Colors.white)),
                  ),
                ],
                // Social Media Login or Registration Buttons
                const SizedBox(height: 20),
                const Text('Or continue with:', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Social media login or registration buttons
                    // ...
            
                    // For example:
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
            ),
          ),
        ),
      ),
    );
  }
}
