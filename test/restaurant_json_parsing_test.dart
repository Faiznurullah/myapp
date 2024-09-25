import 'package:flutter_test/flutter_test.dart';
import '../models/restaurant.dart';

void main() {
  test('JSON Parsing Restaurant', () {
    const json = {
      'id': 'rqdv5juczeskfw1e867',
      'name': 'Melting Pot',
      'city': 'Medan',
      'pictureId': '14',
    };

    final restaurant = Restaurant.fromMap(json);

    expect(restaurant.id, 'rqdv5juczeskfw1e867');
    expect(restaurant.name, 'Melting Pot');
    expect(restaurant.city, 'Medan');
  });
}
