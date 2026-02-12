import 'package:flutter/material.dart';
import '../data/api/api_client.dart';
import '../data/api/auth_api.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isSubmitted = false;
  bool _isLoading = false;
  late AuthApi _authApi;

  @override
  void initState() {
    super.initState();
    _authApi = AuthApi(ApiClient());
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Call the forgot password API
        await _authApi.forgotPassword(_emailController.text.trim());

        // Success - show success message
        if (mounted) {
          setState(() {
            _isSubmitted = true;
            _isLoading = false;
          });
        }
      } on ApiException catch (e) {
        // Show error message
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        // Show generic error message
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to send reset email: ${e.toString()}'),
              backgroundColor: Colors.red,
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
        title: const Text('Forgot Password'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: _isSubmitted
                ? _buildSuccessMessage()
                : _buildForgotPasswordForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.lock_reset,
            size: 80,
            color: Colors.blue,
          ),
          const SizedBox(height: 20),
          const Text(
            'Reset Password',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Enter your email address and we will send you instructions to reset your password.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 40),
          
          // Email Field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          
          // Submit Button
          ElevatedButton(
            onPressed: _isLoading ? null : _handleSubmit,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Send Reset Link',
                    style: TextStyle(fontSize: 18),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(
          Icons.check_circle,
          size: 100,
          color: Colors.green,
        ),
        const SizedBox(height: 20),
        const Text(
          'Check Your Email',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'We have sent password reset instructions to ${_emailController.text}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Back to Login',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
