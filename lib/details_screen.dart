import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:poke_app/const/landscape_container.dart';
import 'package:poke_app/const/portrait_container.dart';
import 'package:poke_app/const/rowstyling.dart';
import 'package:poke_app/const/stat_row.dart';
import 'package:poke_app/const/text_style.dart';

import 'const/colors.dart';

class DetailScreen extends StatelessWidget {
  final dynamic data;

  DetailScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                width: double.infinity,
                child: orientation == Orientation.portrait
                    ? portraitContainer(data)
                    : landscapeContainer(),
              ),
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12))),
                  child: Column(
                    children: [
                      const TabBar(
                        labelColor: black,
                        unselectedLabelColor: grey,
                        tabs: [
                          Tab(
                            text: "About",
                          ),
                          Tab(
                            text: "Base Stats",
                          )
                        ],
                      ),
                      Expanded(
                        child: TabBarView(children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                normalText(
                                    color: black,
                                    size: 16,
                                    text: data["xdescription"]),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: width - 100,
                                    child: Card(
                                      color: lightGrey,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                headingText(
                                                    color: grey,
                                                    size: 16,
                                                    text: "Height"),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                headingText(
                                                    color: grey,
                                                    size: 16,
                                                    text: data["height"])
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                headingText(
                                                    color: grey,
                                                    size: 16,
                                                    text: "Weight"),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                headingText(
                                                    color: grey,
                                                    size: 16,
                                                    text: data["weight"])
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                headingText(
                                    color: black, size: 16, text: "Breeding"),
                                const SizedBox(
                                  height: 10,
                                ),
                                rowStyling(text: "Gender", value: "male"),
                                rowStyling(
                                    text: "Egg Cycle", value: "Grass ,monster"),
                                rowStyling(
                                    text: "Evolution", value: "Grass, monster"),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                statRow(
                                  text: "HP",
                                  value: "20",
                                ),
                                statRow(
                                  text: "Attack",
                                  value: "70",
                                ),
                                statRow(
                                  text: "Defense",
                                  value: "40",
                                ),
                                statRow(
                                  text: "Evolution",
                                  value: "90",
                                ),
                              ],
                            ),
                          )
                        ]),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
