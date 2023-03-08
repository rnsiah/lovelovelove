import 'dart:math';

import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/NonProfit_Details/np_donation_modal.dart';

import 'package:awesome_select/awesome_select.dart' show S2Choice, SmartSelect;

import 'package:selection_menu/selection_menu.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class NpDonate extends StatefulWidget {
  final NonProfit nonProfit;
  final Profile profile;

  const NpDonate({Key? key, required this.nonProfit, required this.profile})
      : super(key: key);

  @override
  State<NpDonate> createState() => _NpDonateState();
}

class _NpDonateState extends State<NpDonate> {
  double _amount = 0;

  List<String> projects(NonProfit nonProfit) {
    List<String> titles = ['None'];
    for (var project in nonProfit.projects!) {
      titles.add(project.title);
    }

    return titles;
  }

  List<String> projectTitles(NonProfit nonProfit) {
    List<String> titles = [];
    for (var project in nonProfit.projects!) {
      titles.add(project.title);
    }
    return titles;
  }

  List<Widget> getRecentDonors(NonProfit nonProfit) {
    List<ProfileRepresentation> list = nonProfit.recentDonors!.toSet().toList();
    if (list.length < 5) {
      return list.map((e) {
        return ProfileDot(profile: e);
      }).toList();
    }
    return list.take(4).toList().map((e) {
      return ProfileDot(profile: e);
    }).toList();
  }

  String _selectedItem = 'None';

  @override
  void initState() {
    // _list = projectTitles(widget.nonProfit);
    // _selectedItem = 'Pick A Project';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double finalAmount = double.parse((_amount).toStringAsFixed(2));
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
          children: [
            NonProfitInfo(nonProfit: widget.nonProfit),
            const SizedBox(height: 10),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Donors',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                    height: 80,
                    child: widget.nonProfit.recentDonors == null ||
                            widget.nonProfit.recentDonors!.isEmpty
                        ? const Text('No Recent Donors')
                        : ListView(
                            padding: const EdgeInsets.symmetric(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: getRecentDonors(widget.nonProfit),
                          ))
              ],
            ),
            const Divider(
              height: 16,
              color: Colors.black54,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.nonProfit.logo,
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
                      const Text('Donate To Specific Project'),
                      const SizedBox(
                        height: 12,
                      ),
                      DropdownButton<String>(
                        value: _selectedItem,
                        items: projects(widget.nonProfit).map((e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedItem = value!;
                          });
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: widget.profile.balance == null ||
                                widget.profile.balance! <= 0
                            ? const Text('Please refill your account')
                            : SfSlider(
                                min: 0,
                                max: widget.profile.balance,
                                value: _amount,
                                interval: 1,
                                showTicks: true,
                                activeColor: Colors.black,
                                showLabels: true,
                                enableTooltip: true,
                                thumbIcon: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Icon(Icons.add),
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
    // child: Column(
    //   crossAxisAlignment: CrossAxisAlignment.end,
    //   children: [
    //     Container(
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(30),
    //         color: Colors.white,
    //       ),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           Container(
    //             child: Column(
    //               children: [
    //                 Text(
    //                   widget.profile.username!,
    //                   style: TextStyle(color: Colors.amber, fontSize: 22),
    //                 ),
    //                 SizedBox(
    //                   height: 6,
    //                 ),
    //                 Text(
    //                   'Altrue Balance',
    //                   style: TextStyle(color: Colors.amber),
    //                 ),
    //                 Text(
    //                   widget.profile.balance.toString(),
    //                   style: TextStyle(color: Colors.amber),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Container(
    //             color: Colors.black,
    //             child: Column(
    //               children: [
    //                 Text(
    //                   widget.nonProfit.name,
    //                   style: TextStyle(color: Colors.amber),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     Container(
    //       width: 180,
    //       child: TextFormField(
    //           initialValue: _amount.toString(),
    //           decoration: InputDecoration(
    //             labelText: 'Amount to Donate',
    //           )),
    //     ),
    // Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: SfSlider(
    //       min: 0,
    //       max: widget.profile.balance,
    //       value: _amount,
    //       interval: 1,
    //       showTicks: true,
    //       showLabels: true,
    //       enableTooltip: true,
    //       thumbIcon: Container(
    //         child: Icon(Icons.add),
    //         decoration:
    //             BoxDecoration(borderRadius: BorderRadius.circular(90)),
    //       ),
    //       onChanged: (dynamic value) {
    //         setState(() {
    //           _amount = value;
    //         });
    //       }),
    // ),

    // Text('Donate To Specific Project'),
    // SizedBox(
    //   height: 12,
    // ),
    // DropdownButton<String>(
    //   value: _selectedItem,
    //   items: projects(widget.nonProfit).map((e) {
    //     return DropdownMenuItem<String>(
    //       child: Text(e),
    //       value: e,
    //     );
    //   }).toList(),
    //   onChanged: (value) {
    //     setState(() {
    //       _selectedItem = value!;
    //     });
    //   },
    // ),

    // AwesomeDropDown(
    //     selectedItem: _selectedItem,
    //     onDropDownItemClick: (selectedItem) {
    //       setState(() {
    //         _selectedItem = selectedItem;
    //       });
    //     },
    //     numOfListItemToShow: 7,
    //     dropDownList: title(widget.nonProfit)),

    // SmartSelect.single(
    //   selectedValue: value,
    //   choiceItems: love,
    // ),

    //     SizedBox(
    //       height: 120,
    //     ),
    //     Text("\$" + finalAmount.toString())

    //     // SelectionMenu<ListTile>(
    //     //     itemBuilder:this.itemBuilder(context, , () { }),
    //     //     itemsList: list,
    //     //     onItemSelected: onItemSelected)
    //   ],
    // ),
  }

  Widget itemBuilder(BuildContext context, NonProfitProject project,
      OnItemTapped onItemTapped) {
    return ListTile(
      title: Text(project.title),
      onTap: onItemTapped,
    );
  }
}
