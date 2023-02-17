// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (_, child) => Portal(child: child!),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();

  final List<Map<String, dynamic>> mentions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text(widget.title!),
      ),
      backgroundColor: Colors.grey.shade600,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: const Text('Get Text'),
            onPressed: () {
              print(key.currentState!.controller!.markupText);
    String slashCommand = "";
    List ids = [];
    String keyvalue = key.currentState!.controller!.markupText;
              for (int i = 0; i < keyvalue.length; i++) {
      if (keyvalue[i] == "@") {
        if (keyvalue[i + 1] == "[") {
          String value = "";
          for (int b = 4; b < keyvalue.length; b++) {
            if (keyvalue[i + b] != "_") {
              value += keyvalue[i + b];
            } else {
              ids.add(value);
              break;
            }
          }
        } else {
          try {
            String value = "";
            for (int b = 1; b < keyvalue.length; b++) {
              String character1 = keyvalue[i + b];
              if (character1 == " ") {
                if ((i + b + 1) == keyvalue.length) {
                  var estateSelected =
                      mentions.firstWhere((data) => data['display'] == value);
                  ids.add(estateSelected['id']);
                  value = "";
                  break;
                } else {
                  if (keyvalue[i + b + 1] == "@") {
                    var estateSelected =
                        mentions.firstWhere((data) => data['display'] == value);
                    ids.add(estateSelected['id']);
                    value = "";
                    break;
                  } else {
                    value += character1;
                  }
                }
              } else {
                value += character1;
              }
            }
          } catch (e) {
            print(e);
          }
        }
      }
      if (keyvalue[i] == "/") {
        for (int b = 1; b < keyvalue.length; b++) {
          if (keyvalue[i + b] != " ") {
            slashCommand += keyvalue[i + b];
          } else {
            break;
          }
        }
      }
    }
    print(ids);
    print(slashCommand);
            },
          ),
          FlutterMentions(
            key: key,
            suggestionPosition: SuggestionPosition.Top,
            maxLines: 5,
  style: const TextStyle(color: Colors.white),
            minLines: 1,
            decoration: const InputDecoration(hintText: 'hello'),
            mentions: [
              Mention(
                  trigger: '@',
                  style: const TextStyle(
                    color: Colors.amber,
                  ),
                  data: [
                    {
                      'id': 'id1',
                      'display': 'Can',
                      'full_name': 'Test4',
                      'photo':
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                    },
                    {
                      'id': 'id2',
                      'display': 'Jack',
                      'full_name': 'Test3',
                      'style': const TextStyle(color: Colors.purple),
                      'photo':
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                    },
                    {
                      'id': 'id3',
                      'display': 'Kim',
                      'full_name': 'Test2',
                      'photo':
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                    },
                    {
                      'id': 'id4',
                      'display': 'Any Person',
                      'full_name': 'Test1',
                      'photo':
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                    },
                  ],
                  matchAll: false,
                  suggestionBuilder: (data) {
                    return Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              data['photo'],
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: <Widget>[
                              Text(data['full_name']),
                              Text('@${data['display']}'),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
              Mention(
                trigger: '/',
                disableMarkup: true,
                style: const TextStyle(
                  color: Colors.deepOrange,
                ),
                data: [
                  {'id': 'reactjs', 'display': 'reactjs'},
                  {'id': 'javascript', 'display': 'javascript'},
                ],
                matchAll: true,
              )
            ],
          ),
        ],
      ),
    );
  }
}


  /*  for (int i = 0; i < keyvalue.length; i++) {
      if (keyvalue[i] == "@") {
        if (keyvalue[i + 1] == "[") {
          String value = "";
          for (int b = 4; b < keyvalue.length; b++) {
            if (keyvalue[i + b] != "_") {
              value += keyvalue[i + b];
            } else {
              ids.add(value);
              break;
            }
          }
        } else {
          try {
            String value = "";
            for (int b = 1; b < keyvalue.length; b++) {
              String character1 = keyvalue[i + b];
              if (character1 == " ") {
                if ((i + b + 1) == keyvalue.length) {
                  var estateSelected =
                      mentions.firstWhere((data) => data['display'] == value);
                  ids.add(estateSelected['id']);
                  value = "";
                  break;
                } else {
                  if (keyvalue[i + b + 1] == "@") {
                    var estateSelected =
                        mentions.firstWhere((data) => data['display'] == value);
                    ids.add(estateSelected['id']);
                    value = "";
                    break;
                  } else {
                    value += character1;
                  }
                }
              } else {
                value += character1;
              }
            }
          } catch (e) {
            print(e);
          }
        }
      }
      if (keyvalue[i] == "/") {
        for (int b = 1; b < keyvalue.length; b++) {
          if (keyvalue[i + b] != " ") {
            slashCommand += keyvalue[i + b];
          } else {
            break;
          }
        }
      }
    }*/