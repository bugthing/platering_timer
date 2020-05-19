//
//import 'package:flutter/material.dart';
//
//class Item extends StatelessWidget {
//  String title = 'Timed Stage';
//  String description = 'An item that is timed.';
//  int total = 60;
//
//  @override
//  Widget build(BuildContext context) {
//    return Text('Hello');
//  }
//}
//
//class TimerModel extends ChangeNotifier {
//  /// Internal, private state of the cart.
//  final List<Item> _items = [];
//
//  /// An unmodifiable view of the items in the cart.
//  ListView get items => ListView(children: _items);
//
//  /// The current total time of all items
//  int get totalTime => _items.length * 12;
//
//  void add(Item item) {
//    _items.add(item);
//    // This call tells the widgets that are listening to this model to rebuild.
//    notifyListeners();
//  }
//
//  void removeAll() {
//    _items.clear();
//    notifyListeners();
//  }
//}