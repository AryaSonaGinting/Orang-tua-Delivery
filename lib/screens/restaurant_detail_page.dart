import 'package:flutter/material.dart';
import '../data/menu_data.dart';
import '../models/restaurant.dart';
import '../widgets/menu_item_card.dart';
import 'cart_page.dart';
import '../app_state.dart';

class RestaurantDetailPage extends StatelessWidget {
 final Restaurant restaurant;
 const RestaurantDetailPage({super.key,required this.restaurant});
 @override Widget build(BuildContext context){final list=menus.where((m)=>m.restaurantId==restaurant.id).toList();return Scaffold(appBar:AppBar(title:Text(restaurant.name),actions:[IconButton(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const CartPage())),icon:const Icon(Icons.shopping_cart_outlined))]),body:ListView(padding:const EdgeInsets.all(16),children:[Container(height:160,decoration:BoxDecoration(color:Colors.orange.shade100,borderRadius:BorderRadius.circular(18)),child:const Icon(Icons.restaurant,size:76,color:Colors.deepOrange)),const SizedBox(height:16),Text(restaurant.name,style:const TextStyle(fontSize:24,fontWeight:FontWeight.bold)),const SizedBox(height:6),Text('⭐ ${restaurant.rating} • ${restaurant.deliveryTime} • ${restaurant.category}',style:const TextStyle(color:Colors.grey)),const SizedBox(height:22),const Text('Menu restoran',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),const SizedBox(height:12),if(list.isEmpty) const Text('Menu restoran ini sedang diperbarui.') else ...list.map((m)=>MenuItemCard(menu:m)),const SizedBox(height:10),AnimatedBuilder(animation:AppState.instance,builder:(context,_)=>Text('Keranjang: ${AppState.instance.itemCount} item',style:const TextStyle(color:Colors.grey))) ]));}
}
