import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/shirt_repository.dart';

part 'shirt_event.dart';
part 'shirt_state.dart';

class ShirtBloc extends Bloc<ShirtEvent, ShirtState> {
  final ShirtRepository shirtRepository;

  ShirtBloc({required this.shirtRepository}) : super(ShirtState()) {
    fetchfeaturedShirtsOnLogin();
  }

  fetchfeaturedShirtsOnLogin() async {
    emit(ShirtState(status: ShirtStatus.initial));
    try {
      List<Shirt> all = await shirtRepository.fetchShirtList();
      List<Shirt> featured = await shirtRepository.featuredShirts();
      if (featured.isNotEmpty) {
        ShirtState newState = state.copyWith(
            shirtlist: all,
            featuredShirts: featured,
            status: ShirtStatus.successful);
        emit(newState);
      }
    } catch (e) {
      print(e.toString());
      ShirtState newState = const ShirtState(status: ShirtStatus.failure);
      emit(newState);
    }
  }

  @override
  Stream<ShirtState> mapEventToState(
    ShirtEvent event,
  ) async* {
    if (event is FetchShirts) {
      List<Shirt> shirtlist = await shirtRepository.fetchShirtList();
      ShirtState newState = state.copyWith(shirtlist: shirtlist);
      yield newState;
    }
    if (event is FetchShirtByCategory) {
      ShirtState newState = state.copyWith(categoryChange: false);
      yield newState;

      try {
        List<Shirt> categoryShirtList =
            await shirtRepository.fetchShirtByCategory(event.category);
        if (categoryShirtList.isEmpty) {
          List<Shirt> allShirts = await shirtRepository.featuredShirts();
          ShirtState newState = state.copyWith(
              categoryShirtList: allShirts,
              shirtlist: state.shirtlist,
              status: ShirtStatus.successful);
          yield newState;
        }
        ShirtState newState = state.copyWith(
            categoryShirtList: categoryShirtList,
            categoryChange: true,
            status: ShirtStatus.successful);
        yield newState;
      } catch (e) {
        print(e.toString());
      }
    }
    if (event is FetchShirt) {
      await shirtRepository.fetchShirt(event.shirt.id!);
    }
  }
}
