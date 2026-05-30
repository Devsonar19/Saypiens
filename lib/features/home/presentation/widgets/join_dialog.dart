import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../theme/app_color.dart';
import '../../data/models/user_model.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class JoinSaypienDialog extends StatefulWidget {
  const JoinSaypienDialog({super.key});

  @override
  State<JoinSaypienDialog> createState() => _JoinSaypienDialogState();
}

class _JoinSaypienDialogState extends State<JoinSaypienDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _ageController = TextEditingController();
  final _reasonController = TextEditingController();
  final _instagramController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _ageController.dispose();
    _reasonController.dispose();
    _instagramController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // Changed to a premium charcoal/dark grey instead of deep black
      backgroundColor: const Color(0xFF1C1C1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.golden.withValues(alpha: 0.4), width: 1),
      ),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeFormSuccess) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Welcome, Saypien! You are on the list.', style: TextStyle(color: Colors.black)),
                backgroundColor: AppColors.golden,
              ),
            );
          } else if (state is HomeFormError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red.shade900),
            );
          }
        },
        builder: (context, state) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 550),
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    Image.asset(
                      'assets/images/transparent_logo2.png',
                      height: 120,
                      fit: BoxFit.contain,
                      color: AppColors.golden,
                    ),
                    const SizedBox(height: 16),

                    // Welcome Text
                    Text(
                      'Join the Community',
                      style: GoogleFonts.playfairDisplay(
                        color: AppColors.golden,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tell us a little about yourself.',
                      style: TextStyle(
                        color: Colors.white70, // Lighter, crisper subtitle
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Name Field
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white, fontSize: 15), // Crisp white text
                      cursorColor: AppColors.golden,
                      decoration: _inputDecoration('Full Name*', Icons.person_outline),
                      validator: (val) => val != null && val.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      cursorColor: AppColors.golden,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration('Email*', Icons.email_outlined),
                      validator: (val) => val != null && !val.contains('@') ? 'Enter a valid email' : null,
                    ),
                    const SizedBox(height: 20),

                    // Mobile and Age Fields (Side by Side)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _mobileController,
                            style: const TextStyle(color: Colors.white, fontSize: 15),
                            cursorColor: AppColors.golden,
                            keyboardType: TextInputType.phone,
                            decoration: _inputDecoration('Mobile Number*', Icons.phone_outlined),
                            validator: (val) => val != null && val.length < 10 ? 'Invalid number' : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _ageController,
                            style: const TextStyle(color: Colors.white, fontSize: 15),
                            cursorColor: AppColors.golden,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration('Age*', Icons.cake_outlined),
                            validator: (val) {
                              if (val == null || val.isEmpty) return 'Required';
                              if (int.tryParse(val) == null) return 'Invalid';
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Instagram Field
                    TextFormField(
                      controller: _instagramController,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      cursorColor: AppColors.golden,
                      decoration: _inputDecoration('Instagram ID', Icons.alternate_email),
                    ),
                    const SizedBox(height: 20),

                    // Reason Field
                    TextFormField(
                      controller: _reasonController,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      cursorColor: AppColors.golden,
                      decoration: _inputDecoration('Why do you want to join?*', Icons.edit_note),
                      validator: (val) => val != null && val.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 32),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.golden,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: state is HomeFormLoading
                            ? null
                            : () {
                          if (_formKey.currentState!.validate()) {
                            final user = SaypienUserModel(
                              name: _nameController.text.trim(),
                              email: _emailController.text.trim(),
                              mobile: _mobileController.text.trim(),
                              age: int.parse(_ageController.text.trim()),
                              reason: _reasonController.text.trim(),
                              insta: _instagramController.text.trim(),
                            );
                            context.read<HomeBloc>().add(SubmitSaypienForm(user));
                          }
                        },
                        child: state is HomeFormLoading
                            ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2.5),
                        )
                            : const Text(
                          'Submit Application',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white60, fontSize: 13), // Slightly smaller label

      // Reduced icon size to 18
      prefixIcon: Icon(icon, color: AppColors.golden.withValues(alpha: 0.8), size: 18),

      // THIS IS THE MAGIC FIX: Shrinks the invisible box around the icon
      prefixIconConstraints: const BoxConstraints(
        minWidth: 36,
        minHeight: 36,
      ),

      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.06),

      // Tighter padding to give the text more breathing room
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.golden, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade300.withValues(alpha: 0.5)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade300, width: 1.5),
      ),
    );
  }
}