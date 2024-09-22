// menu_model.dart

class Menus {
  List<Food> foods;
  List<Drink> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: List<Food>.from(json['foods'].map((food) => Food.fromJson(food))),
      drinks: List<Drink>.from(json['drinks'].map((drink) => Drink.fromJson(drink))),
    );
  }
}

class Food {
  String name;

  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
    );
  }
}

class Drink {
  String name;

  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      name: json['name'],
    );
  }
}
