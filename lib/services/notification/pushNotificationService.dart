import 'package:flutter/material.dart';

class PushNotificationService with ChangeNotifier{
    List<Notification> _itens = [];

    List<Notification> get itens {
      return [..._itens];
    }

    int get itensCount {
      return _itens.length;
    }
    void add(Notification notification){
      _itens.add(notification);
      notifyListeners();
    }

    void remove(int i){
      _itens.removeAt(i);
    }
}