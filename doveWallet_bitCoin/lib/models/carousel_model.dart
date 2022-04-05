class CarouselModel {
  String image;

  CarouselModel(this.image);
}

List<CarouselModel> carousels = carouselsData
    .map((item) => CarouselModel(item['image'] as String))
    .toList();

var carouselsData = [
  {"image": "assets/top_image_slide_01.jpg"},
  {"image": "assets/top_image_slide_02.jpg"},
  {"image": "assets/top_image_slide_03.jpg"},
];
