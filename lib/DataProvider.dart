
import 'package:flutter/material.dart';
import 'package:random_jok_app/JokeModal.dart';
import 'ListModal.dart';

class DataProvider extends ChangeNotifier {
  List<ListModal> favList = [];
  RandomjokeModal? randomjokeModal;

  void addToFav(ListModal listModal) {
    favList.add(listModal);
    notifyListeners();
  }

  void removeToFav(int index) {
    favList.removeAt(index);
    notifyListeners();
  }

  void modalData(RandomjokeModal? randomJokeModal){
    randomjokeModal = randomJokeModal;
    notifyListeners();
  }

}
