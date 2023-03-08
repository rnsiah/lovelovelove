import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

import '../np_atributes.dart';

class NpDonationModal extends StatelessWidget {
  final NonProfit nonProfit;
  const NpDonationModal({Key? key, required this.nonProfit}) : super(key: key);

  List<Widget> getRecentDonors(NonProfit nonProfit) {
    return nonProfit.recentDonors!.map((e) {
      return ProfileDot(profile: e);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            children: getRecentDonors(nonProfit),
          ),
          NonProfitInfo(nonProfit: nonProfit),
          const Divider(
            height: 16,
            color: Colors.black54,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                nonProfit.logo,
                height: 120,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  children: const [
                    // DriverInfo(),
                    //

                    // DiverAppraise(),
                    SizedBox(
                      height: 12,
                    ),
                    DonationButton(),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class DonationButton extends StatelessWidget {
  const DonationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MaterialButton(
          onPressed: () {},
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
          child: const Text(
            'Call',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {},
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
          child: const Text(
            'Donate Now',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

class NonProfitInfo extends StatelessWidget {
  const NonProfitInfo({
    Key? key,
    required this.nonProfit,
  }) : super(key: key);

  final NonProfit nonProfit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nonProfit.name,
          style: const TextStyle(
            shadows: [
              Shadow(
                  offset: Offset(.5, 0.5),
                  blurRadius: 1.0,
                  color: Colors.black),
            ],
            color: Colors.amber,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'price/hr',
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Attribute(
              value: nonProfit.category![0].name!,
              name: 'Causes',
              textColor: Colors.black87,
            ),
            Attribute(
              value: nonProfit.balance.toString(),
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
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          foregroundImage: NetworkImage(profile.profilePicture!.url),
          backgroundColor: Colors.black,
        ),
        Text(
          profile.username,
          style: const TextStyle(fontSize: 9),
        )
      ],
    );
  }
}
