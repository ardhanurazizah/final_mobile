import 'package:flutter/material.dart';
import 'package:final_mobile/pages/listview.dart';
import 'package:final_mobile/pages/register.dart';
import 'package:final_mobile/service/crud.dart';
import 'package:final_mobile/model/category_model.dart';

class EditPage extends StatefulWidget {
  Category category;
  EditPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController txtEditCategory = TextEditingController();
  @override
  void initState() {
    super.initState();
    txtEditCategory.text = widget.category.name;
  }

  doEditCategory() async {
    final name = txtEditCategory.text;
    final response = await CrudHelper().editCategori(widget.category, name);
    print(response.body);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListPage()),
    );
  }

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
                      controller: txtEditCategory,
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const RegisterPage()),
                    // );
                    doEditCategory();
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
