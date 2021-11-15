import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_full_project/app_colors.dart' as app_colors;
import 'package:music_full_project/tablas.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    // readData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: app_colors.background,
      child: SafeArea(
          child: Scaffold(
        body: FutureBuilder<dynamic>(
            future: obtenerEditorial(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: Text("Music Player",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700,
                                        color: app_colors.barraModerna))),
                            const SizedBox(width: 5),
                            Icon(Icons.headphones,
                                size: 40, color: app_colors.headPhone)
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 180,
                          child: Stack(children: [
                            Positioned(
                              top: 0,
                              left: -55,
                              right: 0,
                              child: Container(
                                height: 180,
                                child: PageView.builder(
                                    controller:
                                        PageController(viewportFraction: 0.6),
                                    //cuantas veces
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          height: 180,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: Center(
                                            child: Text(
                                                '${snapshot.data![index]['name']}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25.0,
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    '${snapshot.data![index]['picture_big']}'),
                                                fit: BoxFit.fill,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.5),
                                                    BlendMode.srcOver),
                                              )));
                                    }),
                              ),
                            ),
                          ]),
                        ),
                        Expanded(
                            child: NestedScrollView(
                          controller: _scrollController,
                          headerSliverBuilder:
                              (BuildContext context, bool isScroll) {
                            return [
                              SliverAppBar(
                                pinned: true,
                                backgroundColor: app_colors.sliverBackground,
                                bottom: PreferredSize(
                                    preferredSize: const Size.fromHeight(40),
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 20, left: 8),
                                      child: TabBar(
                                        indicatorPadding:
                                            const EdgeInsets.all(0),
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        labelPadding:
                                            const EdgeInsets.only(right: 5),
                                        controller: _tabController,
                                        isScrollable: true,
                                        indicator: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: app_colors.botonAlbumDos
                                                    .withOpacity(1.0),
                                                blurRadius: 16,
                                                offset: const Offset(0, 0),
                                              )
                                            ]),
                                        tabs: [
                                          AppTabs(
                                              color: app_colors.modernoDos,
                                              text: "Popular"),
                                          AppTabs(
                                              color: app_colors.modernoTres,
                                              text: "Radio"),
                                          AppTabs(
                                              color: app_colors.modernoCuatro,
                                              text: "Tendencias"),
                                        ],
                                      ),
                                    )),
                              )
                            ];
                          },
                          body: FutureBuilder<dynamic>(
                              future: obtenerPopular(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshoto) {
                                if (snapshoto.hasData) {
                                  return TabBarView(
                                      controller: _tabController,
                                      children: [
                                        ListView.builder(
                                          itemCount: snapshoto.data!.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  top: 10,
                                                  bottom: 10),
                                              color: app_colors.tabVarViewColor,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 2,
                                                            offset:
                                                                const Offset(
                                                                    0, 0),
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2))
                                                      ]),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            width: 90,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    image:
                                                                        DecorationImage(
                                                                      image: NetworkImage(
                                                                          '${snapshoto.data![index]['artist']['picture_medium']}'),
                                                                    ))),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // crossAxisAlignment: CrossAxisAlignment.start

                                                              Row(children: [
                                                                Icon(Icons.star,
                                                                    size: 24,
                                                                    color: app_colors
                                                                        .starColor),
                                                                const SizedBox(
                                                                    width: 5),
                                                                Text(
                                                                    '${snapshoto.data![index]['rank']}',
                                                                    style: TextStyle(
                                                                        color: app_colors
                                                                            .menu2Color))
                                                              ]),
                                                              Text(
                                                                  '${snapshoto.data![index]['title']}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontFamily:
                                                                          "Avenir",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              Text(
                                                                  '${snapshoto.data![index]['artist']['name']}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontFamily:
                                                                          "Avenir",
                                                                      color: app_colors
                                                                          .subTitleText)),
                                                              Container(
                                                                width: 60,
                                                                height: 15,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3),
                                                                  color: app_colors
                                                                      .botonAlbum,
                                                                ),
                                                                child: Text(
                                                                    '${snapshoto.data![index]['album']['type']}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            11,
                                                                        fontFamily:
                                                                            "Avenir",
                                                                        color: Colors
                                                                            .white)),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                              )
                                                            ])
                                                      ],
                                                    ),
                                                  )),
                                            );
                                          },
                                        ),
                                        Material(
                                          child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.grey,
                                              ),
                                              title: Text("Content")),
                                        ),
                                        Material(
                                          child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.grey,
                                              ),
                                              title: Text("Content")),
                                        )
                                      ]);
                                } else if (snapshoto.hasError) {
                                  return Center(
                                    child: Text('${snapshoto.error}'),
                                  );
                                }
                                return const Center(
                                    child: CircularProgressIndicator(
                                  backgroundColor: Colors.yellow,
                                ));
                              }),
                        )),
                      ],
                    ),
                  )
                ]);
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.yellow,
                ),
              );
            }),
        floatingActionButton: FabCircularMenu(
          ringColor: app_colors.barraModerna,
          fabColor: app_colors.background,
          ringWidth: 80,
          children: [
            IconButton(
                onPressed: null, icon: Icon(Icons.home, color: Colors.white)),
            IconButton(
                onPressed: null,
                icon: Icon(Icons.music_note_outlined, color: Colors.white)),
            IconButton(
                onPressed: null, icon: Icon(Icons.search, color: Colors.white)),
            IconButton(
                onPressed: null,
                icon: Icon(Icons.favorite, color: Colors.white)),
          ],
        ),
      )),
    );
  }

  obtenerPopular() async {
    var url = Uri.parse('http://api.deezer.com/chart');
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      var artistas = jsonDecode(respuesta.body);
      return artistas["tracks"]["data"];
    } else {
      throw Exception('No se encontro o se obtuvo información del artista');
    }
  }

  obtenerEditorial() async {
    var url = Uri.parse('http://api.deezer.com/editorial');
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      var r = jsonDecode(respuesta.body);
      return r["data"];
    } else {
      throw Exception('No se obtuvo información');
    }
  }
}
