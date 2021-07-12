class Item {
  int _id;
  int _time;
  int _kalori;
  String _name;
  String _ingridients;
  String _step;
  String _image;


// Setter Getter
 String get image => this._image;

 set image(String value) => this._image = value;

 int get id => this._id;

 set id(int value) => this._id = value;

 int get time => this._time;

 set time( int value) => this._time = value;

 int get kalori => this._kalori;

 set kalori(int value) => this._kalori = value;

 String get name => this._name;

 set name(String value) => this._name = value;

 String get ingridients => this._ingridients;

 set ingridients(String value) => this._ingridients = value;

 String get step => this._step;

 set step(String value) => this._step = value;



// Konstruktor
Item(this._name, this._time, this._kalori, this._ingridients, this._step, this._image);

// Konstruktor konversi dari Map ke Item
Item.fromMap(Map<String, dynamic> map) {
  this._id = map ['id'];
  this._name = map ['name'];
  this._time = map ['time'];
  this._kalori = map ['kalori'];
  this._ingridients = map ['ingridients'];
  this._step = map ['step'];
  this._image = map['image'];
  }
// Konversi dari Item ke Map
Map<String, dynamic> toMap() {
  Map<String, dynamic> map = Map<String, dynamic>();
  map['id'] = this._id;
  map['name'] = name;
  map['time'] = time;
  map['kalori'] = kalori;
  map['ingridients'] = ingridients;
  map['step'] = step;
  map['image'] = image;
  return map;
  }
}