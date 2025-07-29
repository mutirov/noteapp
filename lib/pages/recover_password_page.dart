import 'package:flutter/material.dart';
import 'package:notes_app/change_notifiers/registration_controller.dart';
import 'package:notes_app/tools/constants.dart';
import 'package:notes_app/tools/validator.dart';
import 'package:notes_app/widgets/note_back_button.dart';
import 'package:notes_app/widgets/note_button.dart';
import 'package:notes_app/widgets/note_form_field.dart';
import 'package:provider/provider.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  TextEditingController _emailController = TextEditingController();
   GlobalKey<FormFieldState> emailKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recover Password'),
        leading: NoteBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Don\'t worry, we will help you recover your password.',
                style: TextStyle(fontSize: 18, color: Colors.grey[900]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              NoteFormField(
                labelText: 'Email',
                key: emailKey,
                controller: _emailController,
                fillColor: white,
                filled: true,
                validator: Validator.emailValidator,
              ),
              SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: Selector<RegistrationController, bool>(
                  selector: (context, controller) => controller.isLoading,
                  builder: (_, isLoading, _) => NoteButton(
                    onPressed: isLoading ? null : () {
                      if (emailKey.currentState?.validate() ?? false) {
                        context.read<RegistrationController>().resetPassword(context: context, email: _emailController.text.trim());
                      }
                    },
                    child: isLoading ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: white,
                      ),
                    ) : const Text('Send Recovery link'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
