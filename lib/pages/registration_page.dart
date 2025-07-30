import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/change_notifiers/registration_controller.dart';
import 'package:notes_app/pages/recover_password_page.dart';
import 'package:notes_app/tools/constants.dart';
import 'package:notes_app/tools/validator.dart';
import 'package:notes_app/widgets/note_button.dart';
import 'package:notes_app/widgets/note_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/widgets/note_icon_button_outlined.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final RegistrationController _registrationController;
  late TextEditingController _fullNameController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  late final GlobalKey<FormState> _formkey;

  @override
  void initState() {
    super.initState();
    _registrationController = context.read();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formkey = GlobalKey();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Selector<RegistrationController, bool>(
                selector: (context, controller) => controller.isRegisterMode,
                builder: (context, isRegisterMode, _) => Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        isRegisterMode ? 'Registration Page' : 'Sign in',
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w600,
                          color: primary,
                          fontSize: 36,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'in order to async your notes to the cloud, you need to register/sign in to the app',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 46),
                      if (isRegisterMode) ...[
                        NoteFormField(
                          controller: _fullNameController,
                          labelText: 'Full name',
                          textCapitalization: TextCapitalization.sentences,
                          fillColor: white,
                          filled: true,
                          textInputAction: TextInputAction.next,
                          validator: Validator.nameValidator,
                          onChanged: (newValue) {
                            _registrationController.fullName = newValue;
                          },
                        ),
                        SizedBox(height: 12),
                      ],
                      NoteFormField(
                        controller: _emailController,
                        labelText: 'email address',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        fillColor: white,
                        filled: true,
                        validator: Validator.emailValidator,
                        onChanged: (newValue) {
                          _registrationController.email = newValue;
                        },
                      ),
                      SizedBox(height: 12),
                      Selector<RegistrationController, bool>(
                        selector: (_, controller) =>
                            controller.isPasswordHidden,
                        builder: (_, password, _) => NoteFormField(
                          controller: _passwordController,
                          labelText: 'Password',
                          fillColor: white,
                          filled: true,
                          obscureText: password,
                          suffixIcon: GestureDetector(
                            child: IconButton(
                              onPressed: () {
                                _registrationController.isPasswordHidden =
                                    !password;
                              },
                              icon: password
                                  ? FaIcon(FontAwesomeIcons.eye)
                                  : FaIcon(FontAwesomeIcons.eyeSlash),
                            ),
                          ),
                          validator: Validator.passwordValidator,
                          onChanged: (newValue) {
                            _registrationController.password = newValue;
                          },
                        ),
                      ),
                      SizedBox(height: 12),
                      if (!isRegisterMode) ...[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RecoverPasswordPage()));
                          },
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                      SizedBox(
                        height: 48,
                        child: Selector<RegistrationController, bool>(
                          selector: (_, controller) => controller.isLoading,
                          builder: (_, isLoading, _) => NoteButton(
                            onPressed: isLoading ? null : () {
                              // if left side is null, we are not going to move forward to the registration 
                              if (_formkey.currentState?.validate() ?? false) {
                                _registrationController.authenticateWithEmailAndPassword(context: context);
                              }
                              // ?. Null değilse çalıştır, null ise geç.
                              //Eğer _formKey.currentState null değilse, validate() fonksiyonunu çağır.
                              //Eğer null ise, hiçbir şey yapma (çökme!).
                            },
                            child: isLoading
                                ? SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(color: white,))
                                : Text(
                                    isRegisterMode
                                        ? 'Create my accaunt'
                                        : 'Sign in',
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(color: primary, thickness: 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              isRegisterMode
                                  ? 'or register with'
                                  : 'or sign in with',
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(color: primary, thickness: 1),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: NoteIconButtonOutlined(
                              icon: FontAwesomeIcons.google,
                              onPressed: () {
                                _registrationController.authenticateWithGoogle(context: context);
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: NoteIconButtonOutlined(
                              icon: FontAwesomeIcons.facebook,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      Text.rich(
                        TextSpan(
                          text: isRegisterMode
                              ? 'Already have an account? '
                              : 'Don\'t have an account? ',
                          style: TextStyle(
                            color: gray700,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: isRegisterMode ? 'Sign in' : 'Register',
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _registrationController.isRegisterMode =
                                      !isRegisterMode;
                                },
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      //  SizedBox(height: 32),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       isRegisterMode
                      //           ? 'Already have an account?'
                      //           : 'Don\'t have an account?',
                      //     ),
                      //     TextButton(
                      //       onPressed: () {},
                      //       child: Text(
                      //         isRegisterMode ? 'Sign in' : 'Register',
                      //         style: TextStyle(
                      //           color: primary,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 // context.read<RegistrationController>().isRegisterMode = !isRegisterMode; same as  Provider.of();
 // Provider.of<RegistrationController>( context,listen: false,)