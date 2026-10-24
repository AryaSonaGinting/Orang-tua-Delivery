import '../models/restaurant.dart';

final List<Restaurant> restaurants = [
  Restaurant(
    id: 1,
    restaurantId:1,
    name: 'Mie gacoan',
    rating: '4.8',
    deliveryTime: '20-30 min',
    category: 'Mie',
    imagePath:'assets/mie gacoan.jfif',
  ),
  Restaurant(
    id: 2,
    restaurantId:2,
    name: 'McDonalds',
    rating: '4.7',
    deliveryTime: '15-25 min',
    category: 'Burger',
    imagePath:'assets/McDonalds.jfif',
  ),
  Restaurant(
    id: 3,
    restaurantId:3,
    name: 'KFC',
    rating: '4.9',
    deliveryTime: '20-35 min',
    category: 'Ayam',
    imagePath:'assets/KFC.jfif',
  ),
];