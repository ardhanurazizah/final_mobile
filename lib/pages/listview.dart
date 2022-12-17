import 'package:flutter/material.dart';
import 'package:final_mobile/pages/edit.dart';
import 'package:final_mobile/pages/register.dart';

import 'login.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('List Screen'),
          ),
          body: Container(
            width: double.infinity,
            // decoration: BoxDecoration(
            //   color: Colors.lightBlue
            // ),
            child: Column(
              children: [
                Text('List Kategori'),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Masukkan Kategori'),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        //minWidth: double.infinity,
                        onPressed: () {},
                        child: Text('Add'),
                        color: Colors.teal,
                        textColor: Colors.white,
                      ),
                    )
                  ],
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: Text('Logout'),
                  color: Colors.teal,
                  textColor: Colors.white,
                ),
                Expanded(
                    child: ListView(
                  children: [
                    Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: const <Widget>[
                                Icon(Icons.favorite, color: Colors.white),
                                Text('Edit',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const <Widget>[
                                Icon(Icons.delete, color: Colors.white),
                                Text('Hapus',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        onDismissed: (DismissDirection direction) {
                          if (direction == DismissDirection.startToEnd) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditPage()),
                            );
                          } else {}
                        },
                        child: Column(
                          children: [
                            ListTile(title: Text('data')),
                          ],
                        ))
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
