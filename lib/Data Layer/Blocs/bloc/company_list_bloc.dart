import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/company_repository.dart';

part 'company_list_event.dart';
part 'company_list_state.dart';

class CompanyListBloc extends Bloc<CompanyListEvent, CompanyListState> {
  final CompanyRepository companyRepository = CompanyRepository();
  CompanyListBloc() : super(const CompanyListState());

  @override
  Stream<CompanyListState> mapEventToState(CompanyListEvent event) async* {
    if (event is FetchCompanyList) {
      List<ForProfitCompany> company =
          await companyRepository.getCompanyList(user: event.user);

      yield state.copyWith(
          companies: company, status: CompanyListStatus.success);
    }
    if (event is CompanyListFetchedByCategory) {
      yield (const CompanyListState(status: CompanyListStatus.loading));
      try {
        List<ForProfitCompany> company =
            await companyRepository.getCompanyListByCategory(
                user: event.user, category: event.category);
        if (company.length > 1) {
          yield CompanyListState(
              companies: company, status: CompanyListStatus.success);
        }
      } catch (e) {
        yield CompanyListFailed();
      }
    }
  }
}
