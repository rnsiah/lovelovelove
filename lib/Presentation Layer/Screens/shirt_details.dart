import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/shirt_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Circular_Clipper.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Shirt_Details/shirt_details_tab.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/shirt_order/shirt_order_widget.dart';

// ignore: must_be_immutable
class ShirtDetails extends StatefulWidget {
  late Shirt shirt;
  late Profile profile;
  ShirtDetails({required this.shirt, required this.profile});

  @override
  _ShirtDetailsState createState() => _ShirtDetailsState();
}

ShirtRepository shirtRepository = ShirtRepository();

class _ShirtDetailsState extends State<ShirtDetails>
    with TickerProviderStateMixin {
  _getShirtDetails() async {
    Shirt theshirt = await shirtRepository.fetchShirt(widget.shirt.id!);
    return theshirt;
  }

  _getProfile() {
    ProfileBloc profileBloc = context.read<ProfileBloc>();
    Profile profile = profileBloc.state.profile!;
    return profile;
  }

  void initState() {
    _getShirtDetails().then((value) {
      widget.shirt = value;
      Profile newProfile = _getProfile();
      widget.profile = newProfile;
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void showOrder(BuildContext context) {
  //   showBarModalBottomSheet(
  //       backgroundColor: Colors.white,
  //       context: context,
  //       builder: (_) {
  //         return MaterialButton(
  //           onPressed: () => ShirtOrderForm(shirt: widget.shirt),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    ShirtOrderBlocBloc shirtOrderBloc = context.read<ShirtOrderBlocBloc>();
    CartBloc cartBloc = context.read<CartBloc>();
    return Scaffold(
        floatingActionButton: BlocProvider.value(
          value: shirtOrderBloc,
          child: widget.profile.altruePoints != null &&
                  widget.shirt.requiredLevel != null &&
                  widget.profile.altruePoints! >
                      widget.shirt.requiredLevel!.minimumPoints
              ? FloatingActionButton.extended(
                  label: const Text('Get Now'),
                  elevation: 12,
                  onPressed: () {
                    context
                        .read<ShirtOrderBlocBloc>()
                        .add(ShirtOrderStarted(shirt: widget.shirt));
                    showModalBottomSheet(
                        backgroundColor: Colors.white.withOpacity(.9),
                        context: context,
                        builder: (_) {
                          return ShirtOrderForm(
                            cartBloc: cartBloc,
                            shirtOrderBlocBloc: shirtOrderBloc,
                            shirt: widget.shirt,
                          );
                        });
                  },
                  backgroundColor: Colors.amber,
                )
              : FloatingActionButton(
                  elevation: 12,
                  backgroundColor: Colors.amber,
                  child: const Text(
                    'Get This',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 65, right: 20, bottom: 20),
                                  margin: const EdgeInsets.only(top: 45),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(0, 10),
                                            blurRadius: 10)
                                      ]),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text(''),
                                      SizedBox(
                                        height: 15,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  }),
        ),
        body: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => context.read<ProfileBloc>()),
            ],
            child: ListView(children: <Widget>[
              Stack(children: <Widget>[
                Container(
                  transform: Matrix4.translationValues(0.0, -50, 0.0),
                  child: Hero(
                    tag: widget.shirt.originalImage!,
                    child: ClipShadowPath(
                      clipper: CircularClipper(),
                      shadow: const Shadow(blurRadius: 20.0),
                      child: Image(
                        height: 340.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.shirt.originalImage!),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      padding: const EdgeInsets.only(left: 30),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 30,
                      color: Colors.amber,
                    ),
                    const Image(
                      image: AssetImage('images/Altrue Logo White.png'),
                      fit: BoxFit.scaleDown,
                      height: 60,
                      width: 150,
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(left: 2),
                      onPressed: () {
                        context
                            .read<ProfileBloc>()
                            .add(AddShirt(addedShirt: widget.shirt));
                      },
                      icon: const Icon(Icons.favorite),
                      iconSize: 30,
                      color: Colors.amber,
                    ),
                  ],
                ),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
                Row(children: [
                  widget.shirt.variations!.length > 0
                      ? Container(
                          transform: Matrix4.translationValues(-30, -140, 0),
                          width: 300,
                          height: 300,
                          child: Image(
                            fit: BoxFit.contain,
                            image:
                                NetworkImage(widget.shirt.variations![0].image),
                          ))
                      : Container(
                          transform: Matrix4.translationValues(-30, -140, 0),
                          width: 300,
                          height: 300,
                          child: Image(
                              fit: BoxFit.contain,
                              image: NetworkImage(widget.shirt.shirtImage!))),
                  Container(
                    transform: Matrix4.translationValues(-40, -120, 0),
                    child: Column(children: [
                      Text('\$${widget.shirt.price}',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      const Text('Price',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Level Required \n ${widget.shirt.requiredLevel!.name}',
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      )
                    ]),
                  )
                ]),
                Container(
                  transform: Matrix4.translationValues(10, -150, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.shirt.name!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 35)),
                        Text('REGION:${widget.shirt.country!.name}',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black54)),
                        const SizedBox(height: 6),
                      ]),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Container(
                      transform: Matrix4.translationValues(0, -125, 0),
                      child: Column(children: [
                        Container(
                          transform: Matrix4.translationValues(-128, 0, 0),
                          child: const Text('Shirt Info:',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.shirt.altrueInfo ?? widget.shirt.altrueInfo!,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ])),
                ),
                // Text(
                //   shirt.atrocity[0].title,
                //   style: TextStyle(
                //       fontSize: 21,
                //       fontWeight: FontWeight.w600
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                const SizedBox(height: 8),
                const SizedBox(height: 10),
              ]),
              ShirtDetailTabs(
                shirt: widget.shirt,
                profile: widget.profile,
              )
            ])));
  }
}
