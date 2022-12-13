import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));
String orderToJson(Order data) => json.encode(data.toJson());

class Order {

  int idLineaPedido = 0;
  String nombre = "";
  String direccion = "";
  String toping = "";
  List<Order> toList = [];
  
  Order({
    this.idLineaPedido = 0,
    this.nombre = "",
    this.direccion = "",
    this.toping = ""
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    idLineaPedido: json["IDLineaPedido"],
    nombre: json["Nombre"].toString(),
    direccion: json["Direccion"].toString(),
    toping: json["Toping"].toString()
  );

  Map<String, dynamic> toJson() => {
    "idLineaPedido": idLineaPedido,
    "nombre": nombre,
    "direccion": direccion,
    "toping": toping
  };


  Order.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      // var lstProducts = json.decode(item['0']);
      // item['products'] = lstProducts;
      Order order = Order.fromJson(item);
      toList.add(order);
    });
  }
}
