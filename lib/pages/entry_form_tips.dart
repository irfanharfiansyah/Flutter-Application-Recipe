import 'package:flutter/material.dart';
import 'package:flutter_application_recipe/models/tips.dart';
import 'package:flutter_application_recipe/theme.dart';

class EntryFormTips extends StatefulWidget {
  final Tips tips;
  EntryFormTips(this.tips);

  @override
  _EntryFormTipsState createState() => _EntryFormTipsState(this.tips);
}

class _EntryFormTipsState extends State<EntryFormTips> {
  Tips tips;

  _EntryFormTipsState(this.tips);

  TextEditingController titleController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Kondisi
    if (tips != null) {
      titleController.text = tips.title;
      deskripsiController.text = tips.deskripsi;
      nameController.text = tips.name;
      imageController.text = tips.image;
    }
    // rubah
    return Scaffold(
      backgroundColor: Color(0xFFDFD7CC),
      body: Padding(
        padding: EdgeInsets.only(top: 15, left: 30, right: 30),
        child: ListView(
          children: [
            tips == null
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
                    labelText: "Your name",
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
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    labelText: "Title on tips",
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
              child: TextField(
                controller: deskripsiController,
                maxLines: null,
                decoration: InputDecoration(
                    labelText: "Description tips",
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
              child: TextField(
                controller: imageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Link Image tips",
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
                      if (tips == null) {
                        // menambahkan data
                        tips = Tips(nameController.text, titleController.text,
                            deskripsiController.text, imageController.text);
                      } else {
                        // merubah data
                        tips.name = nameController.text;
                        tips.title = titleController.text;
                        tips.deskripsi = deskripsiController.text;
                        tips.image = imageController.text;
                      }

                      // kembali ke halaman/layar sebelumnya dengan membawa objek item
                      Navigator.pop(context, tips);
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
