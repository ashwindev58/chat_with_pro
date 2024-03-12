import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SwitchTabEvent extends AuthEvent {
  final bool isLoginForm;

  const SwitchTabEvent({required this.isLoginForm});

  @override
  List<Object> get props => [isLoginForm];
}

class AuthFormEvent extends AuthEvent {
  // Define events for form interactions (login, registration, etc.)
}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthPageState extends AuthState {
  final bool isLoginForm;

  const AuthPageState({required this.isLoginForm});

  @override
  List<Object> get props => [isLoginForm];
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthPageState(isLoginForm: true));

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SwitchTabEvent) {
      yield AuthPageState(isLoginForm: event.isLoginForm);
    } else if (event is AuthFormEvent) {
      // Handle form interactions here (login, registration, etc.)
    }
  }
}

// UI
class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state is AuthPageState && state.isLoginForm ? 'Login' : 'Registration'),
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
                      _buildTabSwitcher(context),
                      const SizedBox(height: 20),
                      _buildTextFields(state),
                      const SizedBox(height: 20),
                      _buildTermsAndConditions(context, state),
                      const SizedBox(height: 20),
                      _buildLoginOrRegisterButton(context),
                      const SizedBox(height: 10),
                      _buildRememberMeCheckbox(context),
                      _buildForgotPasswordLink(context),
                      _buildSocialMediaButtons(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabSwitcher(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTab(context, 'Login', true),
        const SizedBox(width: 20),
        _buildTab(context, 'Register', false),
      ],
    );
  }

  Widget _buildTab(BuildContext context, String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<AuthBloc>(context).add(SwitchTabEvent(isLoginForm: text == 'Login'));
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

  Widget _buildTextFields(AuthState state) {
    return Column(
      children: [
        TextField(
          controller: (state is AuthPageState && state.isLoginForm)
              ? TextEditingController()
              : TextEditingController(),
          decoration: InputDecoration(
            labelText: (state is AuthPageState && state.isLoginForm)
                ? 'Username or Email'
                : 'Name',
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: TextEditingController(),
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: TextEditingController(),
          decoration: InputDecoration(
            labelText: 'Password',
            suffixIcon: IconButton(
              icon: Icon(Icons.visibility),
              onPressed: () {
                // Handle visibility toggle
              },
            ),
          ),
          obscureText: true,
          style: const TextStyle(color: Colors.white),
        ),
        if (!(state is AuthPageState) || !state.isLoginForm) ...[
          const SizedBox(height: 12),
          TextField(
            controller: TextEditingController(),
            decoration: const InputDecoration(labelText: 'Confirm Password'),
            obscureText: true,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ],
    );
  }

  Widget _buildTermsAndConditions(BuildContext context, AuthState state) {
    if (!(state is AuthPageState) || !state.isLoginForm) {
      return Row(
        children: [
          Checkbox(
            value: false,
            onChanged: (value) {
              // Handle checkbox state
            },
          ),
          const Text(
            'I agree to the Terms and Conditions',
            style: TextStyle(color: Colors.white),
          ),
        ],
      );
    }
    return Container();
  }

  Widget _buildLoginOrRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Dispatch AuthFormEvent for login or registration
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orangeAccent,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        'Login', // Change text based on the current state
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox(BuildContext context) {
    if (BlocProvider.of<AuthBloc>(context).state is AuthPageState &&
        (BlocProvider.of<AuthBloc>(context).state as AuthPageState).isLoginForm) {
      return Row(
        children: [
          Checkbox(
            value: false,
            onChanged: (value) {
              // Handle checkbox state
            },
          ),
          const Text('Remember Me', style: TextStyle(color: Colors.white)),
        ],
      );
    }
    return Container();
  }

  Widget _buildForgotPasswordLink(BuildContext context) {
    if (BlocProvider.of<AuthBloc>(context).state is AuthPageState &&
        (BlocProvider.of<AuthBloc>(context).state as AuthPageState).isLoginForm) {
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
