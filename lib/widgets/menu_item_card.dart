import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models/menu.dart';

class MenuItemCard extends StatelessWidget {
  final Menu menu;
  const MenuItemCard({super.key, required this.menu});
  @override Widget build(BuildContext context) => Card(margin:const EdgeInsets.only(bottom:12),child:Padding(padding:const EdgeInsets.all(12),child:Row(children:[Container(width:68,height:68,decoration:BoxDecoration(color:Colors.orange.shade100,borderRadius:BorderRadius.circular(12)),child:const Icon(Icons.fastfood,color:Colors.deepOrange,size:34)),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(menu.name,style:const TextStyle(fontWeight:FontWeight.bold)),const SizedBox(height:5),Text(menu.description,style:const TextStyle(color:Colors.grey,fontSize:12)),const SizedBox(height:6),Text('Rp${_money(menu.price)}',style:const TextStyle(color:Colors.deepOrange,fontWeight:FontWeight.bold))])),IconButton(tooltip:'Tambah ke keranjang',onPressed:(){AppState.instance.addToCart(menu);ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('${menu.name} ditambahkan ke keranjang'),duration:const Duration(seconds:1)));},icon:const Icon(Icons.add_circle,color:Colors.deepOrange,size:30))])));
  String _money(int n)=>n.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'),(_)=>'.');
}
