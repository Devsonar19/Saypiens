import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF3E3F29),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeFormSuccess) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Welcome, Saypien! You are on the list.')),
            );
          } else if (state is HomeFormError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Become a Saypien',
                    style: TextStyle(
                      color: Color(0xFFF1F0E4),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),


                  TextFormField(
                    controller: _nameController,
                    style: const TextStyle(color: Color(0xFFF1F0E4)),
                    decoration: _inputDecoration('Name'),
                    validator: (val) => val != null && val.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(color: Color(0xFFF1F0E4)),
                    decoration: _inputDecoration('Email'),
                    validator: (val) => val != null && !val.contains('@') ? 'Enter valid email' : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _reasonController,
                    maxLines: 3,
                    style: const TextStyle(color: Color(0xFFF1F0E4)),
                    decoration: _inputDecoration('Why do you want to join?'),
                    validator: (val) => val != null && val.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBCA88D),
                        foregroundColor: const Color(0xFF3E3F29),
                      ),
                      onPressed: state is HomeFormLoading
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) {
                          final user = SaypienUserModel(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            reason: _reasonController.text.trim(),
                          );
                          context.read<HomeBloc>().add(SubmitSaypienForm(user));
                        }
                      },
                      child: state is HomeFormLoading
                          ? const CircularProgressIndicator(color: Color(0xFF3E3F29))
                          : const Text('Join Now', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white30),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFBCA88D)),
      ),
    );
  }
}