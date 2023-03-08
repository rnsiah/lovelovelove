import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';

class FeaturedShirts extends StatefulWidget {
  final double imageHeight;
  final List<Shirt> shirtlist;
  final double imageWidth;
  final String title;
  final Profile profile;

  const FeaturedShirts({
    required this.profile,
    required this.title,
    required this.imageWidth,
    required this.shirtlist,
    required this.imageHeight,
    Key? key,
  }) : super(key: key);

  @override
  _FeaturedShirtsState createState() => _FeaturedShirtsState();
}

class _FeaturedShirtsState extends State<FeaturedShirts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Altrue Collection Of The Week',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () => {},
                  child: const Text(
                    'See More',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.amber,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: widget.imageHeight,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.shirtlist.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/ShirtDetail',
                          arguments: ShirtDetailArguments(
                              shirt: widget.shirtlist[index],
                              profile: widget.profile));
                    },
                    child: Container(
                      width: widget.imageWidth,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],

                        borderRadius: BorderRadius.circular(10),
                        // boxShadow: <BoxShadow>[
                        //   BoxShadow(
                        //       color: Colors.grey.withOpacity(0.2),
                        //       offset: Offset(1.1, 1.1),
                        //       blurRadius: 10.0),
                        // ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image:
                              NetworkImage(widget.shirtlist[index].shirtImage!),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
