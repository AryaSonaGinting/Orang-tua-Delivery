import 'package:flutter/material.dart';
import '../app_state.dart';
import '../data/restaurant_data.dart';
import '../data/menu_data.dart';
import '../models/restaurant.dart';
import '../models/menu.dart';
import '../widgets/category_item.dart';
import '../widgets/restaurant_card.dart';
import 'order_page.dart';
import 'ai_page.dart';
import 'profile_page.dart';
import 'cart_page.dart';
import 'restaurant_detail_page.dart';

class HomePage extends StatefulWidget { const HomePage({super.key}); @override State<HomePage> createState()=>_HomePageState(); }
class _HomePageState extends State<HomePage> {
  int currentIndex=0;
  @override Widget build(BuildContext context) {
    final app=AppState.instance;
    return AnimatedBuilder(animation: app, builder: (context, _) {
      final pages = [app.isOwner ? const OwnerDashboard() : const HomeContent(), const OrdersPage(), const AiPage(), const ProfilePage()];
      return Scaffold(body: pages[currentIndex], bottomNavigationBar: NavigationBar(selectedIndex: currentIndex, onDestinationSelected:(i)=>setState(()=>currentIndex=i), destinations: [const NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:'Beranda'), const NavigationDestination(icon:Icon(Icons.receipt_long_outlined),selectedIcon:Icon(Icons.receipt_long),label:'Pesanan'), const NavigationDestination(icon:Icon(Icons.smart_toy_outlined),selectedIcon:Icon(Icons.smart_toy),label:'Asisten AI'), const NavigationDestination(icon:Icon(Icons.person_outline),selectedIcon:Icon(Icons.person),label:'Profil')]));
    });
  }
}

class HomeContent extends StatefulWidget { const HomeContent({super.key}); @override State<HomeContent> createState()=>_HomeContentState(); }
class _HomeContentState extends State<HomeContent> {
  String selectedCategory='Semua'; String query='';
  final categories = const [('Semua', Icons.apps), ('Nasi', Icons.rice_bowl), ('Mi', Icons.ramen_dining), ('Ayam', Icons.lunch_dining), ('Burger', Icons.fastfood), ('Minuman', Icons.local_cafe)];
  @override Widget build(BuildContext context) {
    final filtered=restaurants.where((r){final menuText=menus.where((m)=>m.restaurantId==r.id).map((m)=>'${m.name} ${m.description}').join(' ').toLowerCase();final categoryOk=selectedCategory=='Semua'||r.category.toLowerCase().contains(selectedCategory.toLowerCase())||menuText.contains(selectedCategory.toLowerCase());return categoryOk&&('${r.name} ${r.category} $menuText'.toLowerCase().contains(query.toLowerCase()));}).toList();
    return Scaffold(appBar:AppBar(title:const Text('Orangtua Delivery',style:TextStyle(fontWeight:FontWeight.bold)), actions:[AnimatedBuilder(animation:AppState.instance,builder:(context,_)=>Stack(children:[IconButton(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const CartPage())),icon:const Icon(Icons.shopping_cart_outlined)),if(AppState.instance.itemCount>0) Positioned(right:5,top:4,child:CircleAvatar(radius:9,backgroundColor:Colors.orange,child:Text('${AppState.instance.itemCount}',style:const TextStyle(fontSize:10,color:Colors.white))))]))]),
      body:ListView(padding:const EdgeInsets.all(16),children:[const Text('Halo 👋',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold)),const SizedBox(height:5),const Text('Mau makan apa hari ini?',style:TextStyle(color:Colors.grey)),const SizedBox(height:18),TextField(onChanged:(v)=>setState(()=>query=v),decoration:InputDecoration(hintText:'Cari makanan atau restoran...',prefixIcon:const Icon(Icons.search),filled:true,fillColor:Colors.white,border:OutlineInputBorder(borderRadius:BorderRadius.circular(14),borderSide:BorderSide.none))),const SizedBox(height:24),const Text('Kategori',style:TextStyle(fontSize:19,fontWeight:FontWeight.bold)),const SizedBox(height:12),SizedBox(height:92,child:ListView(scrollDirection:Axis.horizontal,children:categories.map((c)=>Padding(padding:const EdgeInsets.only(right:10),child:ChoiceChip(avatar:Icon(c.$2,size:18,color:selectedCategory==c.$1?Colors.white:Colors.deepOrange),label:Text(c.$1),selected:selectedCategory==c.$1, onSelected:(_)=>setState(()=>selectedCategory=c.$1),selectedColor:Colors.deepOrange,labelStyle:TextStyle(color:selectedCategory==c.$1?Colors.white:Colors.black87)))).toList())),const SizedBox(height:14),Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[const Text('Restoran untukmu',style:TextStyle(fontSize:19,fontWeight:FontWeight.bold)),Text('${filtered.length} ditemukan',style:const TextStyle(color:Colors.grey))]),const SizedBox(height:10),if(filtered.isEmpty) const Padding(padding:EdgeInsets.all(24),child:Center(child:Text('Tidak ada restoran untuk pencarian ini.'))) else ...filtered.map((r)=>RestaurantCard(restaurant:r))]));
  }
}

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({super.key});
  @override State<OwnerDashboard> createState() => _OwnerDashboardState();
}
class _OwnerDashboardState extends State<OwnerDashboard> {
  @override Widget build(BuildContext context) => AnimatedBuilder(animation:AppState.instance,builder:(context,_)=>Scaffold(
    appBar:AppBar(title:const Text('Dashboard Pemilik')),
    floatingActionButton:FloatingActionButton.extended(onPressed:()=>_editMenu(context),icon:const Icon(Icons.add),label:const Text('Tambah menu')),
    body:ListView(padding:const EdgeInsets.fromLTRB(16,16,16,90),children:[
      Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(color:Colors.deepOrange,borderRadius:BorderRadius.circular(18)),child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(Icons.storefront,color:Colors.white,size:34),SizedBox(height:10),Text('Kelola restoranmu',style:TextStyle(color:Colors.white,fontSize:22,fontWeight:FontWeight.bold)),Text('Atur menu dan pantau pesanan dalam satu tempat.',style:TextStyle(color:Colors.white))]),),
      const SizedBox(height:16),Row(children:[Expanded(child:_StatCard(title:'Pesanan',value:'${AppState.instance.orders.length}',icon:Icons.receipt_long)),const SizedBox(width:10),Expanded(child:_StatCard(title:'Menu tersedia',value:'${menus.length}',icon:Icons.restaurant_menu))]),
      const SizedBox(height:22),const Text('Kelola menu',style:TextStyle(fontWeight:FontWeight.bold,fontSize:20)),const SizedBox(height:8),
      ...menus.map((m)=>Card(child:ListTile(leading:const CircleAvatar(backgroundColor:Color(0xFFFFE7D2),child:Icon(Icons.fastfood,color:Colors.deepOrange)),title:Text(m.name),subtitle:Text('Rp${_money(m.price)} • ${m.description}'),isThreeLine:true,trailing:IconButton(tooltip:'Edit menu',icon:const Icon(Icons.edit_outlined),onPressed:()=>_editMenu(context,menu:m))))),
      const SizedBox(height:20),const Text('Pesanan masuk',style:TextStyle(fontWeight:FontWeight.bold,fontSize:20)),const SizedBox(height:8),
      if(AppState.instance.orders.isEmpty) const Card(child:Padding(padding:EdgeInsets.all(18),child:Text('Belum ada pesanan. Pesanan pembeli akan tampil di sini.'))) else ...AppState.instance.orders.map((o)=>Card(child:ListTile(leading:const Icon(Icons.receipt,color:Colors.deepOrange),title:Text('Pesanan #${o.id.toString().substring(o.id.toString().length-5)}'),subtitle:Text('${o.status} • Rp${_money(o.total)}'),trailing:PopupMenuButton<String>(onSelected:(v)=>AppState.instance.updateOrderStatus(o.id,v),itemBuilder:(_)=>const [PopupMenuItem(value:'Diterima restoran',child:Text('Terima pesanan')),PopupMenuItem(value:'Sedang disiapkan',child:Text('Sedang disiapkan')),PopupMenuItem(value:'Selesai',child:Text('Tandai selesai'))]))))
    ])));
  Future<void> _editMenu(BuildContext context,{dynamic menu}) async {
    final name=TextEditingController(text:menu?.name??'');final price=TextEditingController(text:menu==null?'':menu.price.toString());final desc=TextEditingController(text:menu?.description??'');final form=GlobalKey<FormState>();
    final result=await showDialog<bool>(context:context,builder:(ctx)=>AlertDialog(title:Text(menu==null?'Tambah menu':'Edit menu'),content:Form(key:form,child:SingleChildScrollView(child:Column(mainAxisSize:MainAxisSize.min,children:[TextFormField(controller:name,decoration:const InputDecoration(labelText:'Nama menu'),validator:(v)=>v==null||v.trim().isEmpty?'Nama wajib diisi':null),TextFormField(controller:price,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Harga (angka)'),validator:(v)=>int.tryParse(v??'')==null||int.parse(v!)<=0?'Harga tidak valid':null),TextFormField(controller:desc,decoration:const InputDecoration(labelText:'Deskripsi'),maxLines:2)]))),actions:[TextButton(onPressed:()=>Navigator.pop(ctx,false),child:const Text('Batal')),FilledButton(onPressed:(){if(form.currentState!.validate())Navigator.pop(ctx,true);},child:const Text('Simpan'))]));
    if(result==true){setState((){if(menu==null){final id=menus.fold<int>(0,(max,m)=>m.id>max?m.id:max)+1;menus.add(Menu(id:id,restaurantId:1,name:name.text.trim(),price:int.parse(price.text),description:desc.text.trim()));}else{menu.name=name.text.trim();menu.price=int.parse(price.text);menu.description=desc.text.trim();}});await AppState.instance.saveMenus();}
    name.dispose();price.dispose();desc.dispose();
  }
  String _money(int n)=>n.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'),(_)=>'.');
}
class _StatCard extends StatelessWidget { final String title,value; final IconData icon; const _StatCard({required this.title,required this.value,required this.icon}); @override Widget build(BuildContext context)=>Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(icon,color:Colors.deepOrange),const SizedBox(height:8),Text(value,style:const TextStyle(fontWeight:FontWeight.bold,fontSize:23)),Text(title,style:const TextStyle(color:Colors.grey))]))); }
