import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_full_project/app_colors.dart' as app_colors;

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
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            //para que haya un espacio entre los iconos de izquierda y los otros de la derecha
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const ImageIcon(
                                AssetImage("imgs/menu_dos.png"),
                                size: 24,
                                color: Colors.black,
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.search),
                                  //separacion entre el icono de buscar y notificaciones
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.notifications)
                                ],
                              )
                            ],
                          ),
                        ),
                        //seperación de altura
                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 94),
                                child: const Text("Music Player",
                                    style: TextStyle(fontSize: 30)))
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
                                                    fontSize: 25.0)),
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
                                backgroundColor: Colors.white,
                                bottom: PreferredSize(
                                    preferredSize: const Size.fromHeight(40),
                                    child: Container(
                                      margin: const EdgeInsets.all(3.5),
                                      child: TabBar(
                                        indicatorPadding:
                                            const EdgeInsets.all(0),
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        labelPadding: const EdgeInsets.all(0),
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
                                          Container(
                                              width: 120,
                                              height: 50,
                                              child: const Text(
                                                "New",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.red,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      blurRadius: 7,
                                                      offset:
                                                          const Offset(0, 0),
                                                    )
                                                  ])),
                                          Container(
                                              width: 120,
                                              height: 50,
                                              child: const Text(
                                                "New",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      blurRadius: 7,
                                                      offset:
                                                          const Offset(0, 0),
                                                    )
                                                  ])),
                                          Container(
                                              width: 120,
                                              height: 50,
                                              child: const Text(
                                                "New",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      blurRadius: 7,
                                                      offset:
                                                          const Offset(0, 0),
                                                    )
                                                  ]))
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
                child: CircularProgressIndicator(),
              );
            }),
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
