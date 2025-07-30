import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:notes_app/tools/constants.dart';
import 'package:notes_app/tools/dialogs.dart';

class RegistrationController extends ChangeNotifier {
  bool _isRegisterMode = true;
  bool get isRegisterMode => _isRegisterMode;
  set isRegisterMode(bool value) {
    _isRegisterMode = value;
    notifyListeners();
  }

  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;
  set isPasswordHidden(bool value) {
    _isPasswordHidden = value;
    notifyListeners();
  }

  String _fullName = '';
  String get fullName => _fullName.trim();
  set fullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  String _email = '';
  String get email => _email.trim();
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // this funtcion is going to to be for both registration and login
  Future<void> authenticateWithEmailAndPassword({
    required BuildContext context,
  }) async {
    _isLoading = true;
    try {
      if (_isRegisterMode) {
        await AuthService.register(
          fullName: fullName,
          email: email,
          password: password,
        );
        if (!context.mounted) return;
        showMessageDialog(
          context: context,
          message:
              'A verification email has been sent to your email address. Please verify your email before logging in.',
        );
        //while email is not verified, just reload the user
        while (!AuthService.isEmailVerified) {
          await Future.delayed(
            const Duration(seconds: 5),
            () => AuthService.user?.reload(),
          );
        }
      } else {
        await AuthService.login(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showMessageDialog(
        context: context,
        message: authExceptionMapper[e.code] ?? 'Unknown error',
      );
    } catch (e) {
      if (!context.mounted) return;
      showMessageDialog(context: context, message: 'Unknown error');
    } finally {
      _isLoading = false;
    }
  }

  Future<void> authenticateWithGoogle({required BuildContext context}) async {
    try {
      await AuthService.signInWithGoogle();
    } on NoGoogleAccountChosenException {
      return;
    } catch (e) {
      if (!context.mounted) return;
      showMessageDialog(context: context, message: 'Unknown error');
    }
  }

  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    _isLoading = true;
    try {
      await AuthService.resetPassword(email: email);
      if (!context.mounted) return;
      showMessageDialog(
        context: context,
        message: 'A password reset link has been sent to your email address.',
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showMessageDialog(
        context: context,
        message: authExceptionMapper[e.code] ?? 'Unknown error',
      );
    } catch (e) {
      if (!context.mounted) return;
      showMessageDialog(context: context, message: 'Unknown error');
    } finally {
      _isLoading = false;
    }
  }
}

class NoGoogleAccountChosenException implements Exception {
  const NoGoogleAccountChosenException();
}