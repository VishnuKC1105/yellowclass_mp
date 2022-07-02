import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:video_player/video_player.dart';
import 'package:yellowclass_mp/json_datamodel.dart';
import 'package:yellowclass_mp/video_items.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YellowClass project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yellow Class MP'),
        backgroundColor: Colors.black12,
      ),
      backgroundColor: Color.fromARGB(255, 33, 30, 30),
      body: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var items = data.data as List<VideoDataModel>;
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.black12,
                      elevation: 5,
                      margin: EdgeInsets.all(20),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 300,
                              height: 250,
                              // child: Image(
                              //   image: NetworkImage(
                              //       items[index].coverPicture.toString()),
                              //   fit: BoxFit.cover,
                              // ),
                              child: VideoItems(
                                videoPlayerController:
                                    VideoPlayerController.network(
                                        items[index].videoUrl.toString()),
                                autoplay: true,
                                looping: true,
                              ),
                            ),
                            Expanded(
                                child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    items[index].title.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                                //Text(items[index].title.toString()),
                              ],
                            ))
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<List<VideoDataModel>> ReadJsonData() async {
    //statement which will help us to read data from json
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/dataset.json');

    //we need to convert the data into a list.
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => VideoDataModel.fromJson(e)).toList();
  }
}
