import 'package:flutter/material.dart';
import '../app_state.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final app = AppState.instance;
        return Scaffold(
          appBar: AppBar(title: Text('Keranjang (${app.itemCount})')),
          body: app.cart.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shopping_cart_outlined, size: 70, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        const Text('Keranjang masih kosong', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        const Text('Pilih makanan dari restoran untuk mulai memesan.'),
                        const SizedBox(height: 16),
                        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Cari makanan')),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: app.cart.map((entry) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                const CircleAvatar(backgroundColor: Color(0xFFFFE7D2), child: Icon(Icons.fastfood, color: Colors.deepOrange)),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(entry.menu.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text('Rp${_money(entry.menu.price * entry.quantity)}', style: const TextStyle(color: Colors.deepOrange)),
                                    ],
                                  ),
                                ),
                                IconButton(onPressed: () => app.changeQuantity(entry.menu, -1), icon: const Icon(Icons.remove_circle_outline)),
                                Text('${entry.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                IconButton(onPressed: () => app.changeQuantity(entry.menu, 1), icon: const Icon(Icons.add_circle_outline, color: Colors.deepOrange)),
                                IconButton(tooltip: 'Hapus item', onPressed: () => app.removeFromCart(entry.menu), icon: const Icon(Icons.delete_outline, color: Colors.red)),
                              ],
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
                      child: Column(
                        children: [
                          _priceRow('Subtotal', app.subtotal),
                          const SizedBox(height: 8),
                          _priceRow('Ongkir', 8000),
                          const Divider(height: 22),
                          _priceRow('Total', app.total, bold: true),
                          const SizedBox(height: 14),
                          SizedBox(width: double.infinity, height: 50, child: FilledButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutPage())), child: const Text('LANJUT KE CHECKOUT'))),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _priceRow(String label, int value, {bool bold = false}) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: bold ? 17 : 14)),
      Text('Rp${_money(value)}', style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: bold ? 18 : 14)),
    ],
  );

  String _money(int n) => n.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '.');
}
