import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

class NonprofitProjectRepository {
  ApiProvider apiProvider = ApiProvider();
  UserRepository userRepository = UserRepository();

  Future<dynamic> submit(NonProfitProjectCreation npProject) async {
    User? user = await userRepository.userDao.getCurrentUser(0);
    final response = apiProvider.postAuthenticatedData(
        'api/createProject/', user!.key!, user.altid!, npProject);
    return response;
  }
}
