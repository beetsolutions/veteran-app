import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';
import '../data/api/api_client.dart';
import '../data/api/auth_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  VideoPlayerController? _videoController;
  bool _videoInitialized = false;
  late AuthApi _authApi;

  @override
  void initState() {
    super.initState();
    _authApi = AuthApi(ApiClient());
    _initializeVideo();
  }

  void _initializeVideo() {
    try {
      _videoController = VideoPlayerController.asset('assets/videos/background.mp4')
        ..initialize().then((_) {
          if (mounted) {
            _videoController?.setLooping(true);
            _videoController?.setVolume(0.0); // Mute the video
            _videoController?.play();
            setState(() {
              _videoInitialized = true;
            });
          }
        }).catchError((error) {
          // If video fails to load, just continue without it
          debugPrint('Video initialization error: $error');
        });
    } catch (e) {
      // If video asset is missing, just continue without it
      debugPrint('Video loading error: $e');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Call the login API
        final user = await _authApi.login(
          _usernameController.text.trim(),
          _passwordController.text,
        );

        // Login successful, navigate to home screen
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } on ApiException catch (e) {
        // Show error message
        if (mounted) {
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login failed: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Theme.of(context).scaffoldBackgroundColor;
    final textColor = isDark ? Colors.white : Colors.black87;
    final inputFillColor = isDark ? Colors.grey[900] : Colors.grey[100];
    final inputBorderColor = isDark ? Colors.grey[700]! : Colors.grey[400]!;
    final primaryAccent = Theme.of(context).brightness == Brightness.dark 
        ? const Color(0xFF1DB954) 
        : Theme.of(context).primaryColor;
    
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Video Background
          if (_videoInitialized)
            Positioned.fill(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController!.value.size.width,
                  height: _videoController!.value.size.height,
                  child: VideoPlayer(_videoController!),
                ),
              ),
            ),
          
          // Dark overlay to ensure text is readable
          if (_videoInitialized)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          
          // Original Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // App Logo/Title
                    Icon(
                      Icons.shield,
                      size: 80,
                      color: primaryAccent,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'VeteranApp',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 60),
                    
                    // Username/Password Form
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Username Field
                          TextFormField(
                            controller: _usernameController,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
                              filled: true,
                              fillColor: inputFillColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: inputBorderColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: inputBorderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: primaryAccent, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
                              filled: true,
                              fillColor: inputFillColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: inputBorderColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: inputBorderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: primaryAccent, width: 2),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          
                          // Forgot Password Link
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: _navigateToForgotPassword,
                              style: TextButton.styleFrom(
                                foregroundColor: textColor,
                                padding: EdgeInsets.zero,
                              ),
                              child: const Text(
                                'Forgot your password?',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryAccent,
                                foregroundColor: isDark ? Colors.black : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                elevation: 0,
                                disabledBackgroundColor: primaryAccent.withOpacity(0.5),
                              ),
                              child: _isLoading
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          isDark ? Colors.black : Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      'Log In',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // Sign Up Link
                          Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Sign up not implemented'),
                                        backgroundColor: isDark ? Colors.grey[800] : Colors.grey[600],
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
