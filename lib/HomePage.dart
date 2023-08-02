import 'dart:convert';

import 'package:apiproject2/model.dart';
import 'package:apiproject2/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Model> datalist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Example2"),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: datalist.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getText(
                                index, 'ID : ', datalist[index].id.toString()),
                            getText(index, 'Name : ',
                                datalist[index].name.toString()),
                            getText(index, 'username : ',
                                datalist[index].username.toString()),
                            getText(index, 'mobile : ',
                                datalist[index].phone.toString()),
                            getText(index, 'Email : ',
                                datalist[index].email.toString()),
                            getText(index, 'website : ',
                                datalist[index].website.toString()),
                            getText(
                              index,
                              'address : ',
                              '\n${datalist[index].address.suite.toString()},'
                                  '${datalist[index].address.street.toString()},\n'
                                  '${datalist[index].address.city.toString()},\n'
                                  'latitude: ${datalist[index].address.geo.lat.toString()}\n'
                                  'longitude: ${datalist[index].address.geo.lng.toString()}\n'
                                  'Zip-Code : ${datalist[index].address.zipcode.toString()}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator(
              color: Colors.white,
            );
          }
        },
      ),
    );
  }

  Text getText(int index, String fieldName, String content) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: fieldName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      TextSpan(
          text: content,
          style: TextStyle(
            fontSize: 16,
          )),
    ]));
  }

  Future<List<Model>> getData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        datalist.add(Model.fromJson(index));
      }
      return datalist;
    } else {
      return datalist;
    }
  }
}
