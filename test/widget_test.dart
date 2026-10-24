import 'package:flutter_test/flutter_test.dart';
import 'package:frontendorangtua/main.dart';

void main() {
  testWidgets('App loads successfully test', (WidgetTester tester) async {
    // Memuat FoodDeliveryApp
    await tester.pumpWidget(const FoodDeliveryApp());

    // Memastikan FoodDeliveryApp berhasil dirender
    expect(find.byType(FoodDeliveryApp), findsOneWidget);
  });
}