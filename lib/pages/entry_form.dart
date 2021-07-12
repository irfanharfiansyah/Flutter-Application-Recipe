import 'package:flutter/material.dart';
import 'package:flutter_application_recipe/models/item.dart';
import 'package:flutter_application_recipe/theme.dart';

class EntryForm extends StatefulWidget {
  final Item item;
  EntryForm(this.item);

  @override
  _EntryFormState createState() => _EntryFormState(this.item);
}

class _EntryFormState extends State<EntryForm> {
  Item item;

  _EntryFormState(this.item);

  TextEditingController nameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController kaloriController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController stepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Kondisi
    if (item != null) {
      nameController.text = item.name;
      timeController.text = item.time.toString();
      kaloriController.text = item.kalori.toString();
      imageController.text = item.image;
      ingredientsController.text = item.ingridients;
      stepController.text = item.step;
    }
    // rubah
    return Scaffold(
      backgroundColor: Color(0xFFDFD7CC),
      body: Padding(
        padding: EdgeInsets.only(top: 15, left: 30, right: 30),
        child: ListView(
          children: [
            item == null
                ? Text(
                    "Input Data",
                    style: def1.copyWith(
                        fontSize: 29, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    "Edit Data",
                    style: def1.copyWith(
                        fontSize: 29, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              // Judul
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: def5.copyWith(color: Colors.black),
                    filled: true,
                    fillColor: wit2,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none)),
                onChanged: (value) {},
              ),
            ),
            // Waktu
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: TextField(
                controller: timeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Time",
                    labelStyle: def5.copyWith(color: Colors.black),
                    suffix: Text("Min"),
                    filled: true,
                    fillColor: wit2,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none)),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              // Judul
              child: TextField(
                controller: kaloriController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "KKAL",
                    labelStyle: def5.copyWith(color: Colors.black),
                    suffix: Text("gr"),
                    filled: true,
                    fillColor: wit2,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none)),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              // Judul
              child: TextField(
                controller: imageController,
                decoration: InputDecoration(
                    labelText: "Link Image",
                    labelStyle: def5.copyWith(color: Colors.black),
                    filled: true,
                    fillColor: wit2,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none)),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              // Judul
              child: Container(
                child: TextField(
                  controller: ingredientsController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      labelText: "Ingredients",
                      labelStyle: def5.copyWith(color: Colors.black),
                      filled: true,
                      fillColor: wit2,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none)),
                  onChanged: (value) {},
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              // Judul

              child: TextField(
                controller: stepController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    labelText: "Step",
                    labelStyle: def5.copyWith(color: Colors.black),
                    filled: true,
                    fillColor: wit2,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none)),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 90, bottom: 20),
              child: Row(children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Color(0xFF800733),
                    textColor: Colors.white,
                    child: Text(
                      "Simpan",
                      style: def5.copyWith(
                          fontSize: 19, fontWeight: FontWeight.w800),
                    ),
                    onPressed: () {
                      if (item == null ) {
                        // menambahkan data
                        item = Item(
                            nameController.text,
                            int.parse(timeController.text),
                            int.parse(kaloriController.text),
                            ingredientsController.text,
                            stepController.text,
                            imageController.text);

                      } else {
                        // merubah data
                        item.name = nameController.text;
                        item.time = int.parse(timeController.text);
                        item.kalori = int.parse(kaloriController.text);
                        item.image = imageController.text;
                        item.ingridients = ingredientsController.text;
                        item.step = stepController.text;
                      }
                      
                      // kembali ke halaman/layar sebelumnya dengan membawa objek item
                      Navigator.pop(context, item);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                Container(width: 25),
                // tombol untuk batal
                Expanded(
                  child: RaisedButton(
                    color: Colors.black26,
                    textColor: Colors.white,
                    splashColor: Colors.white,
                    child: Text(
                      "Batal",
                      style: def5.copyWith(
                          fontSize: 19, fontWeight: FontWeight.w800),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
