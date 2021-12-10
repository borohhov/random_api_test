import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_number_test_project/services/firebase/firebase.dart';
import 'package:random_number_test_project/services/random_number_api/random_number_api.dart';

class RandomNumberWidget extends StatefulWidget {
  const RandomNumberWidget({Key? key}) : super(key: key);

  @override
  _RandomNumberWidgetState createState() => _RandomNumberWidgetState();
}

class _RandomNumberWidgetState extends State<RandomNumberWidget> {
  Future<int> randomNumberFuture = RandomNumberApi.getRandomNumberFromApi();
  List<int> previousNumbers = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: FutureBuilder(
            future: randomNumberFuture,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              String result = "Loading...";

              if (snapshot.connectionState != ConnectionState.waiting && snapshot.hasData) {
                result = snapshot.data.toString();
              }
              return Column(
                children: [
                  ElevatedButton(
                      onPressed: snapshot.connectionState == ConnectionState.waiting
                          ? null
                          : () {
                              setState(() {
                                previousNumbers.add(snapshot.data!);
                                FirebaseApi().addData(snapshot.data!);
                                randomNumberFuture = RandomNumberApi.getRandomNumberFromApi();
                              });
                            },
                      child: Text("Get New Random Number")),
                  Text(
                    result,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text(previousNumbers.isNotEmpty ? "Previous numbers" : "", style: TextStyle(fontSize: 24),),
                  Column(children: previousNumbers.map<Widget>((int element) => Text(element.toString())).toList(),)
                ],
              );
            }));
  }
}
