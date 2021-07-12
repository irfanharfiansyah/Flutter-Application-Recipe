class Tips {
  int _id;
  String _title;
  String _name;
  String _deskripsi;
  String _image;

  // Setter and Getter
  String get name => this._name;

  set name(String value) => this._name = value;



  String get image => this._image;

  set image(String value) => this._image = value;

  int get id => this._id;

  set id(int value) => this._id = value;

  String get title => this._title;

  set title(String value) => this._title = value;

  String get deskripsi => this._deskripsi;

  set deskripsi(String value) => this._deskripsi = value;

  Tips(this._name, this._title, this._deskripsi, this._image);

  Tips.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._title = map['title'];
    this._deskripsi = map['deskripsi'];
    this._image = map['image'];
  }
// Konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['title'] = title;
    map['deskripsi'] = deskripsi;
    map['image'] = image;
    return map;
  }
}
