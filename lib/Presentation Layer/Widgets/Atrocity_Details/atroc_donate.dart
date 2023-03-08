import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/NonProfit_Details/np_donation_modal.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/np_atributes.dart';

import 'package:syncfusion_flutter_sliders/sliders.dart';

class AtrocityDonateModal extends StatefulWidget {
  final Atrocity atrocity;
  final Profile profile;
  const AtrocityDonateModal(
      {Key? key, required this.atrocity, required this.profile})
      : super(key: key);

  @override
  _AtrocityDonateModalState createState() => _AtrocityDonateModalState();
}

class _AtrocityDonateModalState extends State<AtrocityDonateModal> {
  double _amount = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
          children: [
            AtrocityInfo(atrocity: widget.atrocity),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Donors',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 7,
                ),
                Container(
                  height: widget.atrocity.recentDonors == null ||
                          widget.atrocity.recentDonors!.length < 1
                      ? 20
                      : 80,
                  child: widget.atrocity.recentDonors == null ||
                          widget.atrocity.recentDonors!.length < 1
                      ? const Text('No Recent Donors')
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.atrocity.recentDonors!.length,
                          itemBuilder: (context, index) {
                            return ProfileDot(
                                profile: widget.atrocity.recentDonors![index]);
                          }),
                )
              ],
            ),
            const Divider(
              height: 16,
              color: Colors.white,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.atrocity.category![0].image!,
                  height: 70,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    children: [
                      // DriverInfo(),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'Donate To Specific Project',
                        style: TextStyle(color: Colors.amber),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // DropdownButton<String>(
                      //   value: _selectedItem,
                      //   items: projects(widget.nonProfit).map((e) {
                      //     return DropdownMenuItem<String>(
                      //       child: Text(
                      //         e,
                      //         style: TextStyle(fontSize: 12),
                      //       ),
                      //       value: e,
                      //     );
                      //   }).toList(),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _selectedItem = value!;
                      //     });
                      //   },
                      // ),

                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: widget.profile.balance! >= 0
                            ? Container(
                                child: Column(
                                  children: [
                                    const Text(
                                      'Please raise funds to donate to this atrocity',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    MaterialButton(
                                        color: Colors.black.withOpacity(.7),
                                        child: const Text(
                                          'Learn How',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {})
                                  ],
                                ),
                              )
                            : SfSlider(
                                min: 0,
                                max: widget.profile.balance,
                                value: _amount,
                                interval: 1,
                                showTicks: true,
                                activeColor: Colors.white,
                                showLabels: true,
                                enableTooltip: true,
                                thumbIcon: Container(
                                  child: const Icon(Icons.add),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(90)),
                                ),
                                onChanged: (dynamic value) {
                                  setState(() {
                                    _amount = value;
                                  });
                                }),
                      ),
                      const DonationButton(),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AtrocityInfo extends StatelessWidget {
  const AtrocityInfo({
    Key? key,
    required this.atrocity,
  }) : super(key: key);

  final Atrocity atrocity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Text(
                  atrocity.title,
                  style: const TextStyle(
                    shadows: [
                      Shadow(
                          offset: Offset(.5, 0.5),
                          blurRadius: 1.0,
                          color: Colors.black),
                    ],
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: Attribute(
                  value: atrocity.category![0].name!,
                  name: 'Causes',
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Attribute(
              value: atrocity.balance.toString(),
              name: 'Donations This Wekk',
              textColor: Colors.black87,
            ),
          ],
        )
      ],
    );
  }
}

class ProfileDot extends StatelessWidget {
  final ProfileRepresentation profile;
  const ProfileDot({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          CircleAvatar(
              radius: 25,
              foregroundImage: NetworkImage(profile.profilePicture!.url),
              backgroundColor: Colors.white),
          Text(profile.username)
        ],
      ),
    );
  }
}
