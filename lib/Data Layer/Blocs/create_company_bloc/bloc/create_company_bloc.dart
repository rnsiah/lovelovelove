import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/company_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

part 'create_company_event.dart';
part 'create_company_state.dart';

class CreateCompanyBloc extends Bloc<CreateCompanyEvent, CreateCompanyState> {
  final CompanyRepository companyRepository = CompanyRepository();
  final UserRepository userRepository = UserRepository();

  CreateCompanyBloc() : super(CreateCompanyState());

  Stream<CreateCompanyState> mapEventToState(CreateCompanyEvent event) async* {
    if (event is CompanyAddressChange) {
      yield state.copyWith(companyAddress: event.companyAddress);
    } else if (event is CompanyFacebookChange) {
      yield state.copyWith(facebook: event.comFacebook);
    } else if (event is CompanyInstagramChange) {
      yield state.copyWith(instagram: event.comInsta);
    } else if (event is CompanyNameChange) {
      yield state.copyWith(companyName: event.companyName);
    } else if (event is CompanyYearStartedChanged) {
      yield state.copyWith(yearStarted: event.companyYear);
    } else if (event is CompanyMissionChanged) {
      yield state.copyWith(mission: event.mission);
    } else if (event is CompanyLogoChanged) {
      yield state.copyWith(logo: event.logo);
    } else if (event is CompanyDescriptionChange) {
      yield state.copyWith(description: event.companyDescription);
    } else if (event is CompanyMainImageChange) {
      yield state.copyWith(mainImage: event.compMainImage);
    } else if (event is CompanyWebsiteChange) {
      yield state.copyWith(website: event.companyWebsite);
    } else if (event is CompanyAttemptCreate) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        User? user = await userRepository.userDao.getCurrentUser(0);
        CompanyCompletion company = CompanyCompletion(
            companyAddress: state.companyAddress,
            companyName: state.companyName,
            description: state.description,
            instagram: state.instagram,
            facebook: state.facebook,
            wehsite: state.wehsite,
            profile: event.profile,
            missionStatement: state.mission,
            yearStarted: state.yearStarted);

        bool companyCreated =
            await companyRepository.newCompany(company: company, user: user);
        if (companyCreated == true) {
          yield state.copyWith(formStatus: SubmissionSuccess());
        }
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFaiiled(e.toString()));
        print(e.toString());
      }
    }
  }
}
