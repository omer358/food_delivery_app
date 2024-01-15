import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:food_delivery_app/bloc/provider.dart';
import 'package:food_delivery_app/model/food_item.dart';
import 'package:rxdart/rxdart.dart';

class CardListBloc extends BlocBase {
  CardListBloc();

  var _listController = BehaviorSubject<List<FoodItem>>.seeded([]);

  CartProvider provider = CartProvider();

  // output
  Stream<List<FoodItem>> get listStream => _listController.stream;

  //input
  Sink<List<FoodItem>> get listSink => _listController.sink;

  //business logic
  addToList(FoodItem foodItem) {
    listSink.add(provider.addToList(foodItem));
  }

  removeFromList(FoodItem foodItem){
    listSink.add(provider.removeFromList(foodItem));
  }
}
