import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../theme/app_color.dart';
import '../../data/models/user_model.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

Future<void> sendNativePushAlert({
  required String name,
  required String age,
  required String reason
}) async {
  // OneSignal's global API endpoint
  const String onesignalApiUrl = 'https://onesignal.com/api/v1/notifications';

  // PASTE YOUR ONESIGNAL KEYS HERE
  const String appId = "07087478-9a56-4a2b-bdbd-a8948c773cb1";
  const String restApiKey = "os_v2_app_a4ehi6e2kzfcxpn5vckiy5z4wgifnhutgp4u674hl7aczcwuou57leb5c4fo63ohcbzyc7jvdfc4eww62t7lvfc6ihd35733d2r5tiq";

  final payload = {
    "app_id": appId,
    "included_segments": ["All"],
    "headings": {"en": "🚀 New Saypien Joined!"},
    "contents": {"en": "$name (Age: $age) just applied.\nReason: $reason"}
  };

  try {
    await http.post(
      Uri.parse(onesignalApiUrl),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "Basic $restApiKey"
      },
      body: jsonEncode(payload),
    );
    debugPrint("Native push notification sent!");
  } catch (e) {
    debugPrint("Failed to send push notification: $e");
  }
}


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
      backgroundColor: Colors.transparent, // Must be transparent for blur to work
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 550),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4), // Dark tint for readability
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.platinum.withOpacity(0.15), width: 1),
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
                    SnackBar(content: Text(state.message), backgroundColor: AppColors.burgundy),
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/transparent_logo2.png',
                          height: 80,
                          fit: BoxFit.contain,
                          color: AppColors.golden,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Join the Community',
                          style: GoogleFonts.playfairDisplay(
                            color: AppColors.platinum,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tell us a little about yourself.',
                          style: GoogleFonts.lato(
                            color: AppColors.platinum.withOpacity(0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Input Fields
                        _buildGlassField(_nameController, 'Full Name*', Icons.person_outline),
                        const SizedBox(height: 20),
                        _buildGlassField(_emailController, 'Email*', Icons.email_outlined, isEmail: true),
                        const SizedBox(height: 20),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 3, child: _buildGlassField(_mobileController, 'Mobile*', Icons.phone_outlined, isPhone: true)),
                            const SizedBox(width: 16),
                            Expanded(flex: 2, child: _buildGlassField(_ageController, 'Age*', Icons.cake_outlined, isNumber: true)),
                          ],
                        ),
                        const SizedBox(height: 20),

                        _buildGlassField(_instagramController, 'Instagram ID', Icons.alternate_email, isRequired: false),
                        const SizedBox(height: 20),

                        _buildGlassField(_reasonController, 'Why do you want to join?*', Icons.edit_note, maxLines: 3, isLast: true),
                        const SizedBox(height: 40),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.golden,
                              foregroundColor: AppColors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                                
                                sendNativePushAlert(
                                    name: user.name,
                                    age: user.age.toString(),
                                    reason: user.reason,
                                );
                                context.read<HomeBloc>().add(SubmitSaypienForm(user));
                              }
                            },
                            child: state is HomeFormLoading
                                ? const SizedBox(
                              height: 24, width: 24,
                              child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2),
                            )
                                : Text(
                              'SUBMIT APPLICATION',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassField(
      TextEditingController controller,
      String label,
      IconData icon, {
        bool isEmail = false,
        bool isPhone = false,
        bool isNumber = false,
        bool isRequired = true,
        int maxLines = 1,
        bool isLast = false,
      }) {
    return TextFormField(
      scrollPadding: const EdgeInsets.all(120.0),
      textInputAction: isLast ? TextInputAction.done : (maxLines > 1 ? TextInputAction.newline : TextInputAction.next),
      controller: controller,
      maxLines: maxLines,
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : (isPhone || isNumber
                ? TextInputType.number
                : (maxLines > 1 ? TextInputType.multiline : TextInputType.text)),
      style: GoogleFonts.lato(color: AppColors.platinum, fontSize: 15),
      cursorColor: AppColors.golden,
      validator: (val) {
        if (!isRequired) return null;
        if (val == null || val.isEmpty) return 'Required';
        if (isEmail && !val.contains('@')) return 'Invalid email';
        if (isPhone && val.length < 10) return 'Invalid number';
        if (isNumber && int.tryParse(val) == null) return 'Invalid age';
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.lato(color: AppColors.platinum.withOpacity(0.5), fontSize: 14),
        prefixIcon: Icon(icon, color: AppColors.golden.withOpacity(0.7), size: 18),
        prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        filled: true,
        fillColor: AppColors.platinum.withOpacity(0.03), // Barely visible fill
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.platinum.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.golden.withOpacity(0.5), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.burgundy.withOpacity(0.5)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.burgundy, width: 1.5),
        ),
      ),
    );
  }
}