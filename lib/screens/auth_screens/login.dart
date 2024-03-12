import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
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
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTabSwitcher(),
                const SizedBox(height: 20),
                _buildTextFields(),
                const SizedBox(height: 20),
                _buildTermsAndConditions(),
                const SizedBox(height: 20),
                _buildLoginOrRegisterButton(),
                const SizedBox(height: 10),
                _buildRememberMeCheckbox(),
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
        _buildTab('Login', _isLoginForm),
        const SizedBox(width: 20),
        _buildTab('Register', !_isLoginForm),
      ],
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isLoginForm = text == 'Login';
        });
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
    return Column(
      children: [
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
      ],
    );
  }

  Widget _buildTermsAndConditions() {
    if (!_isLoginForm) {
      return Row(
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
      );
    }
    return Container();
  }

  Widget _buildLoginOrRegisterButton() {
    return ElevatedButton(
      onPressed: () {
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
        _isLoginForm ? 'Login' : 'Register',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    if (_isLoginForm) {
      return Row(
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
      );
    }
    return Container();
  }

  Widget _buildForgotPasswordLink() {
    if (_isLoginForm) {
      return TextButton(
        onPressed: () {
          // Navigate to the password recovery/reset page
        },
        child: const Text('Forgot Password?', style: TextStyle(color: Colors.white)),
      );
    }
    return Container();
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
