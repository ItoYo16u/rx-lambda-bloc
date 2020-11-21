
class Address {
  Address(
      {this.postalCode, this.prefecture, this.city, this.area, this.residence});

  final String postalCode;
  final String prefecture;
  final String city;

  // 番地まで
  final String area;

  // それ以降(アパート名、部屋番号)
  final String residence;
}
