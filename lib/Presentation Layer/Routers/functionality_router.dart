import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/atrocity_details.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/atrocity_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/cause_details.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/cause_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/companies_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/company_dashboard.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/company_home.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/company_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/company_match_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/company_signup.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/create_link.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/credit_card_page.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/find_friends_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/home_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/mynonprofit_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/newProject.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/non_profit_detail.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/nonprofit_list_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/nonprofit_signup.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/profile_page.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/qr_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/shirt_details.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/shirts_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/signup_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/supporters.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/userProfile_fillScreen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_nonprofitsList.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_profile_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/company_detail_page.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/payment_sheet.dart';

Widget makeRoute(
    {required BuildContext context,
    required String routeName,
    Object? arguments}) {
  final Widget child =
      _buildRoute(context: context, routeName: routeName, arguments: arguments);
  return child;
}

Widget _buildRoute(
    {required BuildContext context,
    required String routeName,
    Object? arguments}) {
  switch (routeName) {
    case '/signUp':
      return SignUpScreen();
    case '/home':
      HomeArguments homearguments = arguments as HomeArguments;
      return HomePage(
        cartBloc: homearguments.cartBloc,
        user: homearguments.user,
        profile: homearguments.profile,
        profileBloc: homearguments.profileBloc,
      );
    case '/userProfile':
      Profile profile = arguments as Profile;

      return ProfileScreen(
        profile: profile,
      );
    case '/signup':
      return SignUpScreen();
    case '/usernonprofits':
      Profile profile = arguments as Profile;
      return UserNonProfits(
        profile: profile,
      );
    case '/myQrCode':
      Profile profile = arguments as Profile;
      return MyQrScreen(
        profile: profile,
      );
    case '/supporters':
      Profile profile = arguments as Profile;
      return SupporterPage(profile: profile);
    case '/shirts':
      Profile profile = arguments as Profile;
      return ShirtList(
        profile: profile,
      );
    case '/payment':
      return PaymentScreen();
    case '/ShirtDetail':
      ShirtDetailArguments argument = arguments as ShirtDetailArguments;
      return ShirtDetails(
        shirt: argument.shirt,
        profile: argument.profile,
      );
    case '/nonprofits':
      Profile profile = arguments as Profile;
      return NonProfitList(
        profile: profile,
      );
    case '/nonProfitView':
      final argument = arguments as NonProfitDetailArguments;
      return NonProfitDetails(
        nonProfit: argument.nonProfit,
        profile: argument.profile,
      );
    case '/atrocities':
      AtrocityListArguments argument = arguments as AtrocityListArguments;
      return AtrocityList(profile: argument.profile);
    case '/atrocityView':
      AtrocityDetailArguments atrocity = arguments as AtrocityDetailArguments;
      return AtrocityDetails(
        atrocity: atrocity.atrocity,
        profile: atrocity.profile,
      );
    case '/causes':
      final CauseListArguments argument = arguments as CauseListArguments;
      return CauseList(profile: argument.profile);
    case '/causeView':
      final argument = arguments as CategoryArguments;
      return CauseDetails(
        cause: argument.category,
        profile: argument.profile,
      );
    case '/companies':
      Profile profile = arguments as Profile;
      return CompaniesListScreen(profile: profile );
    case '/companyDetails':
      ForProfitCompany company = arguments as ForProfitCompany;
      return CompanYDetailPage(company: company);
    case '/editprofile':
      User user = arguments as User;
      return UserProfileComplete(user: user);
    case '/findfriends':
      Profile profile = arguments as Profile;
      return FindFriends(
        profile: profile,
      );
    case '/profilepage':
      Profile profile = arguments as Profile;
      return ProfilePage(profile: profile);
    case '/nonprofitRegister':
      Profile profile = arguments as Profile;
      return NonProfitSignUp(profile: profile);
    case '/companyRegister':
      Profile profile = arguments as Profile;
      return CompanySignupPage(profile: profile);
    case '/companymatch':
      ForProfitCompany company = arguments as ForProfitCompany;
      return CompanyMatchScreen(company: company);
    case '/creditCardDetails':
      return CreditCardPage();

    case '/companyDashboard':
      final argument = arguments as DashBoardScreenArguments;
      return MyDiaryScreen(
        profile: argument.profile,
      );
    case '/mynonprofit':
      MyNonProfitDetailArgments argument =
          arguments as MyNonProfitDetailArgments;
      return MyNonProfitHome(
        profile: argument.profile,
        nonprofit: argument.nonprofit,
      );

    case '/CompanyHome':
      CompanyHomeArguments argument = arguments as CompanyHomeArguments;
      return MyCompanyHome(
        profile: argument.profile,
        company: argument.company,
      );

    case '/createProject':
      CreateProjectArguments argument = arguments as CreateProjectArguments;
      return NewProject(
        nonprofit: argument.nonprofit,
        profile: argument.profile,
      );

    case '/createNPLink':
      NonProfit nonprofit = arguments as NonProfit;
      return CreateLink(nonprofit: nonprofit);

    default:
      throw 'Route $routeName is not defined';
  }
}

class ShirtDetailArguments {
  Shirt shirt;
  Profile profile;
  ShirtDetailArguments({required this.shirt, required this.profile});
}

class CauseListArguments {
  Profile profile;
  CauseListArguments({required this.profile});
}

class CategoryArguments {
  Category category;
  Profile profile;

  CategoryArguments({required this.category, required this.profile});
}

class DashBoardScreenArguments {
  final Profile profile;

  DashBoardScreenArguments({required this.profile});
}

class NonProfitListArguments {
  final Profile profile;

  NonProfitListArguments({required this.profile});
}

class CreateProjectArguments {
  final Profile profile;
  final NonProfit nonprofit;

  CreateProjectArguments({required this.nonprofit, required this.profile});
}

class NonProfitDetailArguments {
  final Profile profile;
  final NonProfit nonProfit;

  NonProfitDetailArguments({required this.nonProfit, required this.profile});
}

class MyNonProfitDetailArgments {
  final Profile profile;
  final NonProfit nonprofit;
  MyNonProfitDetailArgments({required this.nonprofit, required this.profile});
}

class CompanyHomeArguments {
  final Profile profile;
  final ForProfitCompany company;

  CompanyHomeArguments({required this.company, required this.profile});
}

class AtrocityListArguments {
  final Profile profile;
  AtrocityListArguments({required this.profile});
}

class AtrocityDetailArguments {
  final Profile profile;
  final Atrocity atrocity;

  AtrocityDetailArguments({required this.atrocity, required this.profile});
}

class HomeArguments {
  final CartBloc cartBloc;
  final Profile profile;
  final ProfileBloc profileBloc;
  final User user;
  HomeArguments(
      {required this.profile,
      required this.user,
      required this.profileBloc,
      required this.cartBloc});
}
