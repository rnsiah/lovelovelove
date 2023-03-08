import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Circular_Clipper.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/NonProfit_Details/nonprofit_learn_more/nonprofit_learn_more.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/NonProfit_Details/nonprofit_learn_more/nonprofit_learn_more_tabs.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/NonProfit_Details/nonprofitdetail_tabs.dart';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NonProfitDetails extends StatefulWidget {
  final NonProfit nonProfit;
  final Profile profile;

  const NonProfitDetails(
      {Key? key, required this.nonProfit, required this.profile})
      : super(key: key);

  @override
  State<NonProfitDetails> createState() => _NonProfitDetailsState();
}

class _NonProfitDetailsState extends State<NonProfitDetails> {
  _launchURL(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterButtons: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .04,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                color: Colors.black,
                onPressed: () {
                  showModalBottomSheet(
                      isDismissible: true,
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0)),
                      ),
                      builder: (_) => DraggableScrollableSheet(
                            initialChildSize: 0.5,
                            minChildSize: 0.2,
                            maxChildSize: 0.7,
                            expand: false,
                            builder: (_, controller) => NpDonate(
                              nonProfit: widget.nonProfit,
                              profile: widget.profile,
                            ),
                          ));
                },
                child: const Text(
                  'Donate Now',
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0)),
                      ),
                      context: context,
                      builder: (context) =>
                          NPLearnMore(nonprofit: widget.nonProfit));
                },
                color: Colors.amber,
                child: const Text('Learn More',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              )
            ],
          ),
        )
      ],
      body: BlocProvider<ProfileBloc>(
        create: (context) => context.read<ProfileBloc>(),
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  transform: Matrix4.translationValues(0.0, -50, 0.0),
                  child: Hero(
                    tag: widget.nonProfit.logo,
                    child: ClipShadowPath(
                      clipper: CircularClipper(),
                      shadow: const Shadow(blurRadius: 20.0),
                      child: Image(
                        height: 400.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.nonProfit.mainImage!),
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
                      color: Colors.white,
                    ),
                    const Image(
                      image: AssetImage('images/Altrue Logo White.png'),
                      fit: BoxFit.scaleDown,
                      height: 60,
                      width: 150,
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(left: 0),
                      onPressed: () {
                        context
                            .read<ProfileBloc>()
                            .add(AddNonProfit(nonProfit: widget.nonProfit));
                        print(widget.nonProfit.name);
                      },
                      icon: const Icon(Icons.favorite),
                      iconSize: 30,
                      color: Colors.amber,
                    ),
                  ],
                ),
                Positioned.fill(
                  bottom: 30.0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RawMaterialButton(
                      elevation: 12.0,
                      padding: const EdgeInsets.all(10),
                      onPressed: () {},
                      shape: const CircleBorder(),
                      fillColor: Colors.black,
                      child: const Icon(
                        Icons.play_arrow,
                        size: 60.0,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
                widget.nonProfit.owner!.username == widget.profile.username
                    ? const Positioned(
                        bottom: 5, right: 150, child: Text('Edit Video Link'))
                    : const Positioned(
                        bottom: 5, right: 150, child: Text('Watch Video')),
                Positioned(
                  bottom: 115.0,
                  right: 12,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                        child: RawMaterialButton(
                            shape: const CircleBorder(),
                            elevation: 3,
                            fillColor: Colors.black,
                            onPressed: widget.nonProfit.facebook != null
                                ? () => _launchURL(
                                    'http://facebook.com/${widget.nonProfit.facebook}')
                                : () {},
                            child: const Icon(
                              Icons.facebook_rounded,
                              color: Colors.amber,
                              size: 30,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4),
                        child: RawMaterialButton(
                            shape: const CircleBorder(),
                            elevation: 3,
                            fillColor: Colors.black.withOpacity(.70),
                            onPressed: widget.nonProfit.facebook != null
                                ? () => _launchURL(
                                    'http://facebook.com/${widget.nonProfit.facebook}')
                                : () {},
                            child: const Icon(
                              Icons.social_distance,
                              size: 30,
                              color: Colors.amber,
                            )),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 115.0,
                  left: 28.0,
                  child: GestureDetector(
                    onTap: () {
                      Share.share(widget.nonProfit.atrocity!.length == 0
                          ? 'Hey Everybody! Go check out ${widget.nonProfit.name}, and all the good work they are currently doing '
                          : 'Hey Everybody! Go check out ${widget.nonProfit.name}, and all the good work they are currently doing to help ');
                    },
                    child: Column(children: [
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                        height: 44,
                        width: 44,
                        child: const Center(
                          child: Icon(
                            Icons.share,
                            size: 30,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        color: Colors.black,
                        child: const Text('Share ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.amber)),
                      ),
                    ]),
                  ),
                ),
                Positioned(
                  bottom: .0,
                  left: 20.0,
                  child: Column(children: [
                    Text('\$ ${widget.nonProfit.balance}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 19)),
                    const Text('Raised Already')
                  ]),
                ),
                widget.nonProfit.owner!.username == widget.profile.username
                    ? Positioned(
                        bottom: 90.0,
                        right: 25.0,
                        child: Column(children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                            iconSize: 40.0,
                            color: Colors.amber,
                          ),
                          Container(
                            color: Colors.black,
                            width: 50,
                            child: const Text('Edit Image ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.amber,
                                )),
                          ),
                        ]),
                      )
                    : const SizedBox(
                        height: 0,
                      ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Text(
                          widget.nonProfit.name.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          child: GestureDetector(
                            onTap: () =>
                                _launchURL(widget.nonProfit.websiteUrl),
                            child: Image(
                              image: NetworkImage(widget.nonProfit.logo),
                              width: 150,
                              height: 75,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text('Year Started:${widget.nonProfit.yearStarted}'),
                      ],
                    )
                  ]),

                  Container(),

                  Container(
                    height: 250,
                    width: double.infinity,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        widget.nonProfit.owner!.username ==
                                widget.profile.username
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Mission Statement',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.amber,
                                      ))
                                ],
                              )
                            : const Text(
                                'Mission Statement',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.nonProfit.missionStatement!,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        widget.nonProfit.owner!.username ==
                                widget.profile.username
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Vision Statement',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.amber,
                                      ))
                                ],
                              )
                            : const Text(
                                'Vision Statement',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.nonProfit.visionStatement!,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    )),
                  ),
                  const SizedBox(height: 35),
                  const Center(
                      child: Text('Support The Altrue Way',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.amber))),
                  const SizedBox(
                    height: 14,
                  ),
                  NonProfitDetailTabs(
                    nonProfit: widget.nonProfit,
                    profile: widget.profile,
                  )
                  // NonProfitDetails(nonProfit: nonProfit)
                  //  Expanded(
                  //    child: ListView.builder(itemCount: widget.atrocities.category.length,
                  //      itemBuilder: (context, index)=>CategoryCard(
                  //        category:widget.atrocities.category[index],
                  //        press: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Cause_Details(category:widget.atrocities.category[index]))),
                  //      ),
                  // ),
                  //  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
