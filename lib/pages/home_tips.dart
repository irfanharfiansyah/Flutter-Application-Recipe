import 'package:flutter/material.dart';
import 'package:flutter_application_recipe/models/tips.dart';
import 'package:flutter_application_recipe/theme.dart';
import 'package:flutter_application_recipe/widget/slideLeft.dart';
import 'package:flutter_application_recipe/widget/slideRight.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:readmore/readmore.dart';
import 'package:flutter_application_recipe/database/db_helper.dart';
import 'entry_form_tips.dart';
import 'home.dart';

class HomeTips extends StatefulWidget {
  @override
  _HomeTipsState createState() => _HomeTipsState();
}

class _HomeTipsState extends State<HomeTips> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Tips> tipsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (tipsList == null) {
      tipsList = List<Tips>();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Text(
              "Tips in Cook",
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
                var tips = await navigateToEntryFormTips(context, null);
                if (tips != null) {
                  // TODO 2 panggil fungsi untuk insert ke DB
                  int result1 = await dbHelper.insertTips(tips);
                  if (result1 > 0) {
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

  Future<Tips> navigateToEntryFormTips(BuildContext context, Tips tips) async {
    var result1 = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EntryFormTips(tips);
        },
      ),
    );
    return result1;
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
                            "Apakah kamu yakin untuk menghapus Tips ${tipsList[index].title}?"),
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
                              deleteListView(tipsList[index]);
                              // TODO: Delete the tips from DB
                              setState(() {
                                tipsList.removeAt(index);
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
                return res;
              } else {
                var tips = await navigateToEntryFormTips(
                    context, this.tipsList[index]);
                if (tips != null) {
                  editListView(tips);
                }
                // Panggil Fungsi untuk Edit data
                // TODO: Navigate to edit page;
              }
            },
            onDismissed: (direction) => setState(() {}),
            background: SlideRight(),
            secondaryBackground: SlideLeft(),
            key: ObjectKey(tipsList),
            child: Container(
              margin: EdgeInsets.only(top: 9, left: 15, right: 15),
              child: Container(
                child: Card(
                  color: Color(0xFFDFD7CC),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Container(
                        child: Image.network(
                          '${this.tipsList[index].image}',
                          height: 150,
                          width: 355,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          '${this.tipsList[index].title}',
                          style: def1.copyWith(
                              color: Colors.black38,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15, left: 15),
                        child: ReadMoreText(
                          '${this.tipsList[index].deskripsi}',
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.black87),
                          trimLines: 3,
                          colorClickableText: Colors.red,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: "Show More",
                          trimExpandedText: "Show less",
                          moreStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text(
                                '${this.tipsList[index].name}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
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
        Future<List<Tips>> tipsListFuture = dbHelper.getTipsList();
        tipsListFuture.then(
          (tipsList) {
            setState(
              () {
                this.tipsList = tipsList;
                this.count = tipsList.length;
              },
            );
          },
        );
      },
    );
  }

// Fungsi untuk menghapus List item
  void deleteListView(Tips object) async {
    int result = await dbHelper.deleteTips(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  // Fungsi untuk mengedit List item
  void editListView(Tips object) async {
    int result = await dbHelper.updateTips(object);
    if (result > 0) {
      updateListView();
    }
  }
}
