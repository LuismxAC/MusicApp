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
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 67),
                                child: Text("Music Player",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700,
                                        color: app_colors.barraModerna)))
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
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                blurRadius: 7,
                                                offset: Offset(0, 0),
                                              )
                                            ]),
                                        tabs: [
                                          AppTabs(
                                              color: app_colors.modernoDos,
                                              text: "Nuevo"),
                                          AppTabs(
                                              color: app_colors.modernoTres,
                                              text: "Popular"),
                                          AppTabs(
                                              color: app_colors.modernoCuatro,
                                              text: "Tendencias"),
                                        ],
                                      ),
                                    )),
                              )
                            ];
                          },
                          body: TabBarView(
                              controller: _tabController,
                              children: const [
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
                                ),
                                Material(
                                  child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.grey,
                                      ),
                                      title: Text("Content")),
                                )
                              ]),
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
}

obtenerArtista() async {
  var url = Uri.parse('http://api.deezer.com/search?q=queen');
  var respuesta = await http.get(url);

  if (respuesta.statusCode == 200) {
    var r = jsonDecode(respuesta.body);
    return r["data"];
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
