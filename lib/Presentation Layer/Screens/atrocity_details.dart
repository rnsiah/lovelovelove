import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Atrocity_Details/atroc_donate.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Atrocity_Details/atrocity_details_tabs.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Circular_Clipper.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/atrocity_learn_more/atrocity_learn_more_tabs.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class AtrocityDetails extends StatefulWidget {
  final Atrocity atrocity;
  final Profile profile;

  const AtrocityDetails(
      {super.key, required this.atrocity, required this.profile});
  @override
  State<AtrocityDetails> createState() => _AtrocityDetailsState();
}

class _AtrocityDetailsState extends State<AtrocityDetails> {
  _launchURL(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
        ),
        builder: (builder) {
          return Container(
            height: 500.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: const SizedBox(
                child: Center(
              child: Text("This is a modal sheet"),
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                elevation: 12,
                color: Colors.black,
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.black87,
                      isDismissible: true,
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.0)),
                      ),
                      builder: (context) => DraggableScrollableSheet(
                          minChildSize: 0.3,
                          maxChildSize: 0.75,
                          expand: false,
                          builder: (_, controller) => AtrocityDonateModal(
                              atrocity: widget.atrocity,
                              profile: widget.profile)));
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
                elevation: 12,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          AtrocityLearnMoreTabs(atrocity: widget.atrocity));
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
      backgroundColor: Colors.black26,
      // body: SlidingUpPanel(
      //   parallaxEnabled: true,
      //   panel: Center(
      //     child: Text('Lern'),
      //   ),
      body: BlocProvider<ProfileBloc>(
        create: (context) => context.read<ProfileBloc>(),
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  transform: Matrix4.translationValues(0.0, -50, 0.0),
                  child: Hero(
                    tag: widget.atrocity.imageUrl!,
                    child: ClipShadowPath(
                      clipper: CircularClipper(),
                      shadow: const Shadow(blurRadius: 20.0),
                      child: Image(
                        height: 400.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.atrocity.imageUrl!),
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
                      padding: const EdgeInsets.only(left: 20),
                      onPressed: () {
                        print(widget.atrocity.slug);
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
                      onPressed: () => _launchURL(widget.atrocity.videoURL),
                      shape: const CircleBorder(),
                      fillColor: Colors.white,
                      child: const Icon(Icons.play_arrow,
                          size: 60.0, color: Colors.black),
                    ),
                  ),
                ),
                const Positioned(
                    bottom: 5,
                    right: 150,
                    child: Text('Watch Video',
                        style: TextStyle(color: Colors.white))),
                Positioned(
                  bottom: 0,
                  right: 25,
                  child: Column(children: const [
                    Text(
                      '5',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Colors.white),
                    ),
                    Text('Donations', style: TextStyle(color: Colors.white))
                  ]),
                ),
                Positioned(
                    bottom: 0,
                    left: 20,
                    child: Column(children: [
                      Text("\$${widget.atrocity.balance}",
                          style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const Text(
                        'Altrue Funds Raised:',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ])),
                Text(widget.atrocity.balance.toString(),
                    style: const TextStyle(color: Colors.white)),
                Positioned(
                  bottom: 90.0,
                  left: 20.0,
                  child: Column(children: [
                    IconButton(
                      onPressed: () => Share.share(widget.atrocity.title),
                      icon: const Icon(Icons.share),
                      iconSize: 40.0,
                      color: Colors.amber,
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
                Positioned(
                  bottom: 90.0,
                  right: 25.0,
                  child: Column(children: [
                    IconButton(
                      onPressed: () {
                        print(widget.atrocity.slug);
                        context
                            .read<ProfileBloc>()
                            .add(AddAtrocity(atrocity: widget.atrocity));
                      },
                      icon: const Icon(Icons.add),
                      iconSize: 40.0,
                      color: Colors.amber,
                    ),
                    Container(
                      color: Colors.black,
                      width: 50,
                      child: const Text('Follow ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.amber)),
                    ),
                  ]),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Text(
                            widget.atrocity.title.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                              width: 90,
                              height: 60,
                              child: Image(
                                fit: BoxFit.contain,
                                image:
                                    NetworkImage(widget.atrocity.country!.flag),
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'REGION:',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(widget.atrocity.region!.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  const SizedBox(height: 8),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        "What's Going On:",
                        style: TextStyle(fontSize: 18, color: Colors.amber),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: SingleChildScrollView(
                      child: Text(
                        widget.atrocity.info!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AtrocityDetailTabs(
                atrocity: widget.atrocity, profile: widget.profile)
          ],
        ),
      ),
    );
  }

  // Widget _panel(ScrollController sc) {
  //   return MediaQuery.removePadding(
  //       context: context,
  //       removeTop: true,
  //       child: ListView(controller: sc, children: [
  //         Text('Support Today'),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         AtrocityDetails(atrocity: widget.atrocity)
  //       ]));
  // }
}
