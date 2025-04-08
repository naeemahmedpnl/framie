import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/busket_data_model.dart';

class BasketSession {
  static final BasketSession _instance = BasketSession._internal();
  BasketSession._internal();
  factory BasketSession() => _instance;

  static RxList<CombinedBasketModel> basketItems = <CombinedBasketModel>[].obs;

  Future<List<CombinedBasketModel>> getBasketItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? basketData = prefs.getString('basket_items');

    if (basketData != null && basketData.isNotEmpty) {
      try {
        List<dynamic> decodedData = jsonDecode(basketData);
        List<CombinedBasketModel> items = [];

        for (var item in decodedData) {
          try {
            items.add(CombinedBasketModel.fromJson(item));
          } catch (e) {
            log('Error parsing item: $e');
            // Continue with next item
          }
        }

        basketItems.value = items;
        return items;
      } catch (e) {
        log('Error parsing basket items: $e');
        return [];
      }
    } else {
      return [];
    }
  }

  // Add a new item to the basket
  Future<void> addBasketItem(CombinedBasketModel basketItem) async {
    try {
      basketItems.add(basketItem);
      await _saveBasketItems();
      log('Item added to basket: ${basketItem.id}');
    } catch (e) {
      log('Error adding item to basket: $e');
    }
  }

  // Remove an item from basket by ID
  Future<bool> removeBasketItem(String id) async {
    try {
      await getBasketItems();

      int initialLength = basketItems.length;
      basketItems.removeWhere((item) => item.id == id);

      if (basketItems.length < initialLength) {
        await _saveBasketItems();
        log('Item removed from basket: $id');
        return true;
      } else {
        log('Item not found in basket: $id');
        return false;
      }
    } catch (e) {
      log('Error removing item from basket: $e');
      return false;
    }
  }

  // Update an existing basket item
  Future<bool> updateBasketItem(CombinedBasketModel updatedItem) async {
    try {
      await getBasketItems();

      int index = basketItems.indexWhere((item) => item.id == updatedItem.id);
      if (index != -1) {
        basketItems[index] = updatedItem;
        await _saveBasketItems();
        log('Item updated in basket: ${updatedItem.id}');
        return true;
      } else {
        log('Item not found for update: ${updatedItem.id}');
        return false;
      }
    } catch (e) {
      log('Error updating item in basket: $e');
      return false;
    }
  }

  // Clear all items from basket
  Future<void> clearBasket() async {
    try {
      basketItems.clear();
      await _saveBasketItems();
      log('Basket cleared');
    } catch (e) {
      log('Error clearing basket: $e');
    }
  }

  // Helper method to save basket items to SharedPreferences
  Future<void> _saveBasketItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final itemsJson = basketItems.map((item) => item.toJson()).toList();
      final basketJson = jsonEncode(itemsJson);
      await prefs.setString('basket_items', basketJson);
    } catch (e) {
      log('Error saving basket items: $e');
    }
  }

  // Debug method to print current basket contents
  void debugPrintBasketContents() {
    log('Current basket items (${basketItems.length}):');
    for (var item in basketItems) {
      log('- Item ID: ${item.id}');
      log('  Salon: ${item.salon.title}');
      log('  Salon: ${item.salon.text}');
      log('  Employee: ${item.employee.employeeName}');
    }
  }
}
