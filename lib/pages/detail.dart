import 'package:flutter/material.dart';
import 'package:flutter_application_recipe/models/item.dart';
import 'package:flutter_application_recipe/theme.dart';
import 'package:flutter_application_recipe/widget/nutrition.dart';
import 'package:flutter_application_recipe/database/db_helper.dart';

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  Item item;
  Detail(this.item);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Item> itemList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF800733),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            "Resep",
            textAlign: TextAlign.center,
            style: def6.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      widget.item.name,
                      style: def6.copyWith(
                        fontSize: 39,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD8CDB9),
                      ),
                      // D8CDB9
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "so irresistibly delicious",
                      style: def1.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC28C2E),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 310,
              padding: EdgeInsets.only(left: 16),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5, left: 15),
                        child: Text(
                          "Details",
                          style: def1.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      Nutrition(
                          value: widget.item.kalori,
                          title: "Calories",
                          subTitle: "Kcal"),
                      SizedBox(
                        height: 19,
                      ),
                      Nutrition(
                          value: widget.item.kalori,
                          title: "Protein",
                          subTitle: "g"),
                      SizedBox(
                        height: 19,
                      ),
                      Nutrition(
                          value: widget.item.time,
                          title: "Time",
                          subTitle: "minute"),
                    ],
                  ),
                  Positioned(
                    right: -90,
                    top: 25,
                    child: Hero(
                      tag: widget.item.image,
                      child: Container(
                        height: 290,
                        width: 350,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.item.image),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 80),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 14),
                      child: Text("Ingredients",
                          style: def1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFFECA049))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(widget.item.ingridients,
                          style: def1.copyWith(
                              fontSize: 16, color: Colors.grey[500])),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.only(bottom: 14),
                      child: Text("Method",
                          style: def1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFFECA049))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 1),
                      child: Text(
                        widget.item.step,
                        style: def1.copyWith(
                            fontSize: 16, color: Colors.grey[500]),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
