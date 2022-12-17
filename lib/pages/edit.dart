import 'package:flutter/material.dart';
import 'package:final_mobile/pages/listview.dart';
import 'package:final_mobile/pages/register.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Edit Screen'),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Edit Kategori'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: Text('Ubah'),
                  color: Colors.teal,
                  textColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ListPage()),
                    );
                  },
                  child: Text('Kembali'),
                  color: Colors.teal,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
