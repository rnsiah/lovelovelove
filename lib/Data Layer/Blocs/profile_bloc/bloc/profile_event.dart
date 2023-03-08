part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfile extends ProfileEvent {
  final Profile profile;
  const FetchProfile({required this.profile});
}

class LoadQR extends ProfileEvent {
  final Profile profile;
  const LoadQR({required this.profile});
}

class FetchProfileAutoLogin extends ProfileEvent {
  final Profile profile;
  const FetchProfileAutoLogin({required this.profile});
}

class AddShirt extends ProfileEvent {
  final Shirt addedShirt;
  const AddShirt({required this.addedShirt});
}

class DeleteShirt extends ProfileEvent {
  final Shirt deletedShirt;
  const DeleteShirt({required this.deletedShirt});
}

class AddAtrocity extends ProfileEvent {
  final Atrocity atrocity;
  const AddAtrocity({required this.atrocity});
}

class AddNonProfit extends ProfileEvent {
  final NonProfit nonProfit;
  const AddNonProfit({required this.nonProfit});
}

class ChangeProfilePicture extends ProfileEvent {
  final XFile profilePicture;
  const ChangeProfilePicture({required this.profilePicture});
}

class AddUserToFollow extends ProfileEvent {
  final int profileToFollow;
  const AddUserToFollow({required this.profileToFollow});
}

class AddOrderItem extends ProfileEvent {
  final OrderItem orderItem;
  const AddOrderItem({required this.orderItem});
}

class SubmitOrderItems extends ProfileEvent {
  final List<OrderItem> orderItems;
  const SubmitOrderItems({required this.orderItems});
}

class AddFollower extends ProfileEvent {
  final ManageFollower interaction;

  const AddFollower({required this.interaction});
}

class RemoveFollower extends ProfileEvent {
  final ManageFollower interaction;
  const RemoveFollower({required this.interaction});
}

class LogOut extends ProfileEvent {}
