import 'dart:convert';

import 'package:final_mobile/service/loginservice.dart';
import 'package:flutter/material.dart';
import 'package:final_mobile/pages/edit.dart';
import 'package:final_mobile/pages/register.dart';
import 'package:http/http.dart' as http;
import 'package:final_mobile/service/global.dart';
import 'package:final_mobile/service/loginservice.dart';
import '../model/category_model.dart';

import 'package:final_mobile/service/crud.dart';

import 'login.dart';

class ListPage extends StatefulWidget {
  const ListPage({
    super.key,
  });

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  List listCategory = [];
  String name = '';
  List<String> user = [];
  List<Category> categories = [];
  int selectedIndex = 0;
  int currentPage = 1;
  int lastPage = 0;
  bool isLoading = true;
  final ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  // getKategori() async {
  //   final response = await CrudHelper().getKategori();
  //   var dataResponse = jsonDecode(response.body);
  //   setState(() {
  //     var listRespon = dataResponse['data'];
  //     for(var i=0; i< listRespon.length; i++){
  //       listCategory.add(Category.fromJson(listRespon[i]));
  //     }
  //   });
  // }
  fetchData() {
    CrudHelper.getCategories(currentPage.toString()).then((resultList) {
      setState(() {
        categories = resultList[0];
        lastPage = resultList[1];
        isLoading = false;
      });
    });
  }

  logoutPressed() async {
    http.Response response = await AuthServices.logout();

    if (response.statusCode == 204) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginPage(),
        ),
        (route) => false,
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const ListPage(),
          ));
    }
  }

  doAddCategory() async {
    final name = txtAddCategory.text;
    final response = await CRUD().addCategory(name);
    print(response.body);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListPage()),
    );
  }

  addMoreData() {
    CrudHelper.getCategories(currentPage.toString()).then((resultList) {
      setState(() {
        categories.addAll(resultList[0]);
        lastPage = resultList[1];
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (currentPage < lastPage) {
          setState(() {
            isLoading = true;
            currentPage++;
            addMoreData();
          });
        }
      }
    });

    fetchData();
  }

  getKategori() async {
    final response = await AuthServices().getKategori();
    var dataResponse = jsonDecode(response.body);
    setState(() {
      var listRespon = dataResponse['data'];
      for (var i = 0; i < listRespon.length; i++) {
        listCategory.add(Category.fromJson(listRespon[i]));
      }
    });
  }

  final TextEditingController txtAddCategory = TextEditingController();
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
                    Text('List Kategori', style: TextStyle(fontSize: 30)),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: txtAddCategory,
                            decoration:
                                InputDecoration(labelText: 'Masukkan Kategori'),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            //minWidth: double.infinity,
                            onPressed: () {
                              doAddCategory();
                            },
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
                        logoutPressed();
                      },
                      child: Text('Logout'),
                      color: Colors.teal,
                      textColor: Colors.white,
                    ),
                    Expanded(
                        child: ListView.builder(
                            controller: scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                  key: UniqueKey(),
                                  background: Container(
                                    color: Colors.blue,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        children: const <Widget>[
                                          Icon(Icons.favorite,
                                              color: Colors.white),
                                          Text('Edit',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  secondaryBackground: Container(
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const <Widget>[
                                          Icon(Icons.delete,
                                              color: Colors.white),
                                          Text('Hapus',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onDismissed:
                                      (DismissDirection direction) async {
                                    if (direction ==
                                        DismissDirection.startToEnd) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return EditPage(
                                                category: categories[index]);
                                          });
                                    } else {
                                      final response = await CrudHelper()
                                          .deleteCategori(categories[index]);
                                      print(response.body);
                                      // Navigator.pushNamed(context, "/main");

                                    }
                                  },
                                  child: Container(
                                    height: 100,
                                    child: ListTile(
                                        title: Text(
                                      categories[index].name,
                                      style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    )),
                                  ));
                            }))
                  ],
                ))));
  }
}
