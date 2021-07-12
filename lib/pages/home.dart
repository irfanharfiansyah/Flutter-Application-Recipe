import 'package:flutter/material.dart';
import 'package:flutter_application_recipe/models/tips.dart';
import 'package:flutter_application_recipe/models/item.dart';
import 'package:flutter_application_recipe/pages/detail.dart';
import 'package:flutter_application_recipe/pages/home_tips.dart';
import 'package:flutter_application_recipe/theme.dart';
import 'package:flutter_application_recipe/widget/slideLeft.dart';
import 'package:flutter_application_recipe/widget/slideRight.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:flutter_application_recipe/database/db_helper.dart';
import 'entry_form.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Item> itemList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = List<Item>();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Text(
              "Daftar Menu",
              textAlign: TextAlign.center,
              style: def6.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          leading: Icon(
            Icons.sort,
            color: Colors.black,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add_box_outlined,
                color: Colors.black,
              ),
              onPressed: () async {
                // Respond to button press
                var item = await navigateToEntryForm(context, null);
                if (item != null) {
                  // TODO 2 panggil fungsi untuk insert ke DB
                  int result = await dbHelper.insert(item);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ],
        ),
        
        body: createListView(),
        
        backgroundColor: Color(0xFF800733));
  }

  Future<Item> navigateToEntryForm(BuildContext context, Item item) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EntryForm(item);
        },
      ),
    );
    return result;
  }

  ListView createListView() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                final bool res = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                            "Apakah kamu yakin untuk menghapus resep ${itemList[index].name}?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              deleteListView(itemList[index]);
                              // TODO: Delete the item from DB
                              setState(() {
                                itemList.removeAt(index);
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
                return res;
              } else {
                var item =
                    await navigateToEntryForm(context, this.itemList[index]);
                if (item != null) {
                  editListView(item);
                }
                // Panggil Fungsi untuk Edit data
                // TODO: Navigate to edit page;
              }
            },
            onDismissed: (direction) => setState(() {}),
            background: SlideRight(),
            secondaryBackground: SlideLeft(),
            key: ObjectKey(itemList),
            child: Container(
              margin: EdgeInsets.only(top: 9, left: 15, right: 15),
              height: 150,
              child: Container(
                child: Card(
                  color: Color(0xFFDFD7CC),
                  elevation: 0.2,
                  // DFD7CC
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detail(itemList[index]),
                        ),
                      );
                    },
                    child: Container(
                      height: 120,
                      padding: const EdgeInsets.all(0),
                      child: Row(children: [
                        Expanded(
                          flex: 10,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        this.itemList[index].image),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 14,
                          child: Container(
                            padding: const EdgeInsets.only(top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(this.itemList[index].name,
                                    style: def2.copyWith(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.alarm_sharp,
                                      color: Colors.orangeAccent,
                                      size: 20,
                                    ),
                                    Text(
                                      '${this.itemList[index].time.toString()} min',
                                      style: def1.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.whatshot_outlined,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    Text(
                                      '${this.itemList[index].kalori.toString()} cal',
                                      style: def1.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: 10, bottom: 10),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: wit),
                                          child: Container(
                                            padding: EdgeInsets.all(7),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 17,
                                                  color: Colors.yellow[700],
                                                ),
                                                Text("4.5",
                                                    style: def2.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.grey[600])),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then(
      (database) {
        // TODO 1 select data dari DB
        Future<List<Item>> itemListFuture = dbHelper.getItemList();
        itemListFuture.then(
          (itemList) {
            setState(
              () {
                this.itemList = itemList;
                this.count = itemList.length;
              },
            );
          },
        );
      },
    );
  }

// Fungsi untuk menghapus List item
  void deleteListView(Item object) async {
    int result = await dbHelper.delete(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  // Fungsi untuk mengedit List item
  void editListView(Item object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      updateListView();
    }
  }
}
