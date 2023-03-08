import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/all_company_donations.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/mediteranein_diet.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/title_viiew.dart';

class MyCompanyHome extends StatefulWidget {
  final Profile profile;
  final ForProfitCompany company;

  const MyCompanyHome({required this.profile, required this.company});

  @override
  State<MyCompanyHome> createState() => _MyCompanyHomeState();
}

class _MyCompanyHomeState extends State<MyCompanyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Image(
              image: AssetImage('images/Altrue Logo White.png'),
            ),
          ],
        ),
      ),
      body: ListView(scrollDirection: Axis.vertical, children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: TitleView(
            company: widget.company,
            titleTxt: widget.company.name,
          ),
        ),
        MediterranesnDietView(
          profile: widget.profile,
          isProfileInfo: false,
          isCompanyInfo: true,
          company: widget.company,
        ),
        const TitleView(
          titleTxt: 'Our Donations',
        ),
        widget.company.donationsMade!.donations!.length != 0 &&
                widget.company.donationsMade!.matched!.length != 0
            ? CompanyDonationsList(company: widget.company)
            : Container(
                height: 80,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Your Organization has 0 donations',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/companymatch',
                              arguments: widget.company);
                        },
                        child: const Text(
                          'Get Started Now',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ),
              )
      ]),
    );
  }
}
