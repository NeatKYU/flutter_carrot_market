import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  String _selectedCategory = 'none';

  String get currentCategory => _selectedCategory;

  void setNewCategoryWithKey(String newCategory) {
    if (categoryMapEngToKor.keys.contains(newCategory)) {
      _selectedCategory = newCategory;
      notifyListeners();
    }
  }

  void setNewCategoryWithValue(String newCategory) {
    if (categoryMapEngToKor.values.contains(newCategory)) {
      _selectedCategory = newCategory;
      notifyListeners();
    }
  }
}

const Map<String, String> categoryMapEngToKor = {
  'none': '선택',
  'top': '상의',
  'bottom': '하의',
  'outer': '아우터',
  'shoes': '신발',
  'cap': '모자',
};

const Map<String, String> categoryMapKorToEng = {
  '선택': 'none',
  '상의': 'top',
  '하의': 'bottom',
  '아우터': 'outer',
  '신발': 'shoes',
  '모자': 'cap',
};
