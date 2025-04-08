import 'dart:io';

class HairServiceModel {
  String title;
  String description;
  double price;
  File? image;

  HairServiceModel({
    this.title = '',
    this.description = '',
    this.price = 0.0,
    this.image,
  });
}
