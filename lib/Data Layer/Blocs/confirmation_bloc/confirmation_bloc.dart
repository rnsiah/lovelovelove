import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/confirmation_bloc/confirmation_event.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/confirmation_bloc/confirmation_state.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/validationCubit.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

class ConfirmatioBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final UserRepository userRepository;
  final ValidationCubit validationCubit;

  ConfirmatioBloc({required this.userRepository, required this.validationCubit})
      : super(ConfirmationState());

  Stream<ConfirmationState> mapEventToState(ConfirmationEvent event) async* {
    if (event is ConfirmationCodeChanged) {
      yield state.copyWith(code: event.code);
    } else if (event is ConfirmationSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        User user = await userRepository.confirmSignUpWithoutConfirmation(
            confirmationCode: event.code,
            email: validationCubit.credentials!.email);
        await userRepository.persistToken(user: user);
        validationCubit.launchSession(user);

        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFaiiled('Failed'));
      }
    }
  }
}
