import 'package:flutter/material.dart';
import 'package:poke_app/const/api_services.dart';
import 'package:poke_app/const/colors.dart';
import 'package:poke_app/const/poke_type_container.dart';
import 'package:poke_app/const/text_style.dart';
import 'package:poke_app/details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Demo(),
      theme: ThemeData(fontFamily: "circula"),
    );
  }
}

class Demo extends StatelessWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "PokeApp",
                style: TextStyle(fontFamily: "circula_bold", fontSize: 36),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                  child: FutureBuilder(
                      future: getAPI(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data;
                          return GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: width < 600
                                          ? 2
                                          : width < 1100
                                              ? 4
                                              : 6,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  data: data[index],
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: -20,
                                          right: -20,
                                          child: Image.asset(
                                            "assets/pokeball.png",
                                            width: 130,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 8,
                                          right: 8,
                                          child: Image.network(
                                            data[index]["imageurl"],
                                            width: 130,
                                          ),
                                        ),
                                        Positioned(
                                            top: 20,
                                            left: 10,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                headingText(
                                                    color: Colors.white,
                                                    size: 24,
                                                    text: data[index]["name"]),
                                                typeContainer(
                                                    color: Colors.white,
                                                    size: 16,
                                                    text: "Grass"),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                typeContainer(
                                                    color: Colors.white,
                                                    size: 16,
                                                    text: "Poision")
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return const Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(lightGreen),
                          ));
                        }
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
