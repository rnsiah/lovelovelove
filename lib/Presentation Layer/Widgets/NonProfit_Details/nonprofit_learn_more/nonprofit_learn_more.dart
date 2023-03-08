import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';

class NPLearnMore extends StatefulWidget {
  final NonProfit nonprofit;
  const NPLearnMore({Key? key, required this.nonprofit}) : super(key: key);

  @override
  State<NPLearnMore> createState() => _NPLearnMoreState();
}

class _NPLearnMoreState extends State<NPLearnMore> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .65,
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 3, color: Colors.amber)),
            height: MediaQuery.of(context).size.height * .30,
            child: (widget.nonprofit.links != null &&
                    widget.nonprofit.links!.isNotEmpty)
                ? ListView.builder(
                    itemCount: widget.nonprofit.links!.length,
                    itemBuilder: (context, index) => Card(
                          child: ListTile(
                              subtitle: Text(
                                widget.nonprofit.links![index].publication,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              title: Text(
                                widget.nonprofit.links![index].title,
                                style: const TextStyle(fontSize: 20),
                              )),
                        ))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        '${widget.nonprofit.name} has no relevent links at the moment',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.amber),
                      ),
                    ),
                  ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / .3,
            child: ListView(shrinkWrap: true, children: [
              Text(
                "${widget.nonprofit.name}'s prjects",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 7,
              ),
              (widget.nonprofit.projects != null &&
                      widget.nonprofit.projects!.isNotEmpty)
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.nonprofit.projects!.length,
                      itemBuilder: (context, index) => Card(
                            child: ListTile(
                              title: Text(
                                widget.nonprofit.projects![index].title,
                                style: const TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                              subtitle: Text(
                                  'Fundraising Goal: \$${widget.nonprofit.projects![index].fundraisingGoal!}'),
                            ),
                          ))
                  : Center(
                      child: Text(
                          '${widget.nonprofit.name} has no current projects'),
                    ),
            ]),
          )
        ],
      ),
    );
  }
}
