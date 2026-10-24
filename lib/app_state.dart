import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/menu.dart';
import 'models/order.dart';
import 'data/menu_data.dart';

class CartEntry {
  final Menu menu;
  int quantity;
  CartEntry({required this.menu, this.quantity = 1});
  Map<String, dynamic> toJson() => {'id': menu.id, 'quantity': quantity};
}

class AppState extends ChangeNotifier {
  AppState._();
  static final AppState instance = AppState._();
  SharedPreferences? _prefs;
  final List<CartEntry> cart = [];
  final List<Order> orders = [];
  String name = 'Syahid Lukman';
  String email = 'syahid@email.com';
  String phone = '';
  String address = 'Jl. Universitas No. 10, Medan';
  bool isOwner = false;

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    name = _prefs!.getString('profile_name') ?? name;
    email = _prefs!.getString('profile_email') ?? email;
    phone = _prefs!.getString('profile_phone') ?? phone;
    address = _prefs!.getString('profile_address') ?? address;
    isOwner = _prefs!.getBool('is_owner') ?? false;
    final savedMenus = _prefs!.getString('menus');
    if (savedMenus != null) {
      try {
        final rows = jsonDecode(savedMenus) as List<dynamic>;
        for (final row in rows) {
          final id = row['id'] as int;
          final existing = menus.where((m) => m.id == id);
          if (existing.isNotEmpty) { existing.first.name = row['name'] as String; existing.first.price = row['price'] as int; existing.first.description = row['description'] as String; }
          else { menus.add(Menu(id: id, restaurantId: row['restaurantId'] as int, name: row['name'] as String, price: row['price'] as int, description: row['description'] as String)); }
        }
      } catch (_) {}
    }
    final savedOrders = _prefs!.getString('orders');
    if (savedOrders != null) {
      try {
        final rows = jsonDecode(savedOrders) as List<dynamic>;
        orders.addAll(rows.map((r) => Order(id: r['id'] as int, restaurantName: r['restaurantName'] as String, status: r['status'] as String, total: r['total'] as int)));
      } catch (_) { orders.clear(); }
    }
    final savedCart = _prefs!.getString('cart');
    if (savedCart != null) {
      try {
        final rows = jsonDecode(savedCart) as List<dynamic>;
        for (final row in rows) {
          final id = row['id'] as int;
          final qty = row['quantity'] as int;
          final menu = allMenus.cast<Menu?>().firstWhere((m) => m?.id == id, orElse: () => null);
          if (menu != null && qty > 0) cart.add(CartEntry(menu: menu, quantity: qty));
        }
      } catch (_) { cart.clear(); }
    }
  }

  static List<Menu> get allMenus => menus;
  Future<void> _saveCart() async { if (_prefs != null) { await _prefs!.setString('cart', jsonEncode(cart.map((e) => e.toJson()).toList())); } }
  Future<void> saveMenus() async { if (_prefs != null) { await _prefs!.setString('menus', jsonEncode(menus.map((m) => {'id': m.id, 'restaurantId': m.restaurantId, 'name': m.name, 'price': m.price, 'description': m.description}).toList())); } }
  Future<void> _saveOrders() async { if (_prefs != null) { await _prefs!.setString('orders', jsonEncode(orders.map((o) => {'id': o.id, 'restaurantName': o.restaurantName, 'status': o.status, 'total': o.total}).toList())); } }
  Future<void> saveProfile() async {
    await _prefs?.setString('profile_name', name);
    await _prefs?.setString('profile_email', email);
    await _prefs?.setString('profile_phone', phone);
    await _prefs?.setString('profile_address', address);
    notifyListeners();
  }
  Future<void> setOwner(bool value) async { isOwner = value; await _prefs?.setBool('is_owner', value); notifyListeners(); }
  void addToCart(Menu menu) {
    final index = cart.indexWhere((e) => e.menu.id == menu.id);
    if (index >= 0) { cart[index].quantity++; } else { cart.add(CartEntry(menu: menu)); }
    _saveCart(); notifyListeners();
  }
  void changeQuantity(Menu menu, int delta) {
    final index = cart.indexWhere((e) => e.menu.id == menu.id);
    if (index < 0) return;
    cart[index].quantity += delta;
    if (cart[index].quantity <= 0) cart.removeAt(index);
    _saveCart(); notifyListeners();
  }
  void removeFromCart(Menu menu) { cart.removeWhere((e) => e.menu.id == menu.id); _saveCart(); notifyListeners(); }
  int get itemCount => cart.fold(0, (sum, e) => sum + e.quantity);
  int get subtotal => cart.fold(0, (sum, e) => sum + e.menu.price * e.quantity);
  int get total => subtotal + (cart.isEmpty ? 0 : 8000);
  void placeOrder() {
    if (cart.isEmpty) return;
    orders.insert(0, Order(id: DateTime.now().millisecondsSinceEpoch, restaurantName: 'Orangtua Delivery', status: 'Menunggu konfirmasi', total: total));
    cart.clear(); _saveCart(); _saveOrders(); notifyListeners();
  }
  void updateOrderStatus(int id, String status) {
    final i = orders.indexWhere((o) => o.id == id);
    if (i >= 0) { orders[i] = Order(id: orders[i].id, restaurantName: orders[i].restaurantName, status: status, total: orders[i].total); _saveOrders(); notifyListeners(); }
  }
}
