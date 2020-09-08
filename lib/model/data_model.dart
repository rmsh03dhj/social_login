
class DataModel{
  final String serviceName;
  final String date;
  final String time;

  DataModel({this.serviceName, this.date, this.time});
}

class OrderedItem{
  final int id;
  final String name;
  final String image;
  final int quantity;
  final double price;

  OrderedItem({this.id, this.name, this.image, this.quantity, this.price});
}

class Categories{
  final int id;
  final String name;
  final List<OrderedItem> items;

  Categories({this.id, this.name, this.items});
}