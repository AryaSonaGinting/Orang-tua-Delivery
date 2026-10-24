import 'package:flutter/material.dart';
import '../app_state.dart';
import 'order_detail_page.dart';

class OrdersPage extends StatelessWidget { const OrdersPage({super.key});
 @override Widget build(BuildContext context)=>AnimatedBuilder(animation:AppState.instance,builder:(context,_) {final orders=AppState.instance.orders;return Scaffold(appBar:AppBar(title:const Text('Pesanan Saya')),body:orders.isEmpty?Center(child:Padding(padding:const EdgeInsets.all(24),child:Column(mainAxisSize:MainAxisSize.min,children:[Icon(Icons.receipt_long_outlined,size:70,color:Colors.grey.shade400),const SizedBox(height:12),const Text('Belum ada pesanan',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),const SizedBox(height:6),const Text('Pesanan yang kamu buat akan muncul di sini.')]))):ListView(padding:const EdgeInsets.all(16),children:orders.map((o)=>Card(child:ListTile(leading:const CircleAvatar(backgroundColor:Color(0xFFFFE7D2),child:Icon(Icons.restaurant,color:Colors.deepOrange)),title:Text('Pesanan #${o.id.toString().substring(o.id.toString().length-5)}'),subtitle:Text('${o.status}\nTotal Rp${_money(o.total)}'),isThreeLine:true,trailing:const Icon(Icons.chevron_right),onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>OrderDetailPage(orderId:o.id)))))).toList()));});
 String _money(int n)=>n.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'),(_)=>'.');
}
