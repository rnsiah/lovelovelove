import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';

class SignUpState {
  final String email;
  final String password1;
  final String password2;
  final FormSubmissionStatus formaStatus;
  bool get isValidemail => email.contains('@') && email.length > 5;
  bool get isValidpassword => password1.length > 6;

  bool validatePW(String p, String p2) {
    if (p != p2) {
      return false;
    } else {
      return true;
    }
  }

  SignUpState(
      {this.email = '',
      this.password1 = '',
      this.password2 = '',
      this.formaStatus = const InitialFormStatus()});

  SignUpState copyWith({
    String? email,
    String? password1,
    String? password2,
    FormSubmissionStatus? formStatus,
  }) {
    return SignUpState(
        email: email ?? this.email,
        password1: password1 ?? this.password1,
        password2: password2 ?? this.password2,
        formaStatus: formStatus ?? this.formaStatus);
  }
}
