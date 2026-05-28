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
  final _reasonController = TextEditingController();
  final _instagramController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _reasonController.dispose();
    _instagramController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withValues(alpha: 0.9), // Deep, sleek black
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.golden.withValues(alpha: 0.3), width: 1), // Golden outer border
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
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/transparent_logo2.png',
                      height: 300, // Adjusted height for better form balance
                      fit: BoxFit.contain,
                      color: AppColors.golden,
                    ),
                    const SizedBox(height: 32),
                    // Name Field
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: AppColors.textPrimary),
                      cursorColor: AppColors.golden,
                      decoration: _inputDecoration('Name*'),
                      validator: (val) => val != null && val.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: AppColors.textPrimary),
                      cursorColor: AppColors.golden,
                      decoration: _inputDecoration('Email*'),
                      validator: (val) => val != null && !val.contains('@') ? 'Enter valid email' : null,
                    ),
                    const SizedBox(height: 20),

                    //Instagram Field
                    TextFormField(
                      controller: _instagramController,
                      style: const TextStyle(color: AppColors.textPrimary),
                      cursorColor: AppColors.golden,
                      decoration: _inputDecoration('Instagram'),
                    ),
                    const SizedBox(height: 20),

                    // Reason Field
                    TextFormField(
                      controller: _reasonController,
                      maxLines: 3,
                      style: const TextStyle(color: AppColors.textPrimary),
                      cursorColor: AppColors.golden,
                      decoration: _inputDecoration('Why do you want to join?*'),
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
                          foregroundColor: Colors.black, // Dark text on golden button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: state is HomeFormLoading
                            ? null
                            : () {
                          if (_formKey.currentState!.validate()) {
                            final user = SaypienUserModel(
                              name: _nameController.text.trim(),
                              email: _emailController.text.trim(),
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
                          child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2),
                        )
                            : const Text(
                            'Join Now',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2
                            )
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

  // The updated input decoration for the golden theme
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: AppColors.textPrimary.withValues(alpha: 0.5)),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.05), // Very slight highlight inside the field
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.textPrimary.withValues(alpha: 0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.golden, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red.shade400),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red.shade400, width: 2),
      ),
    );
  }
}