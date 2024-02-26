// import 'package:flutter/material.dart';

// class ThemeProvider extends ChangeNotifier{
//   ThemeData _selectedTheme;
//   ThemeData light = ThemeData.light().copyWith(
//     primaryColorDark: Colors.grey,
//   );
//   ThemeData dark = ThemeData.dark().copyWith(
//     primaryColor: Colors.black,
//   );
  
//   // ThemeProvider(bool isDarkMode){
//   //   this._selectedTheme = isDarkMode ? dark: light;

//   // }
//   ThemeProvider(bool isDarkMode) {
//     this._selectedTheme = isDarkMode ? dark : light;
//   }
//   ThemeData get getTheme => _selectedTheme;
// }


import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _selectedTheme;
  ThemeData light = ThemeData.light().copyWith(
    primaryColorDark: Colors.grey,
  );
  ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: Colors.black,
  );
  
  // Constructor
  ThemeProvider({required bool isDarkMode}) {
    this._selectedTheme = isDarkMode ? dark : light;
  }
  void swaTheme(){
    _selectedTheme = _selectedTheme == dark ? light : dark;
    notifyListeners();
  }

  ThemeData get getTheme => _selectedTheme;
}
