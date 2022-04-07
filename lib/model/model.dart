enum Cinsiyet { FEMALE, MALE, OTHER }

enum Renkler { YELLOW, BLUE, GREEN, PINK }

class UserInformation {
  final String name;
  final Cinsiyet gender;
  final List<String> colors;
  final bool ogrenciMi;

  UserInformation(this.name, this.gender, this.colors, this.ogrenciMi);
}
