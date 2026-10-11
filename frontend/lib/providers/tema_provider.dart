import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemaProvider extends ChangeNotifier {
  bool _modoEscuro = false;
  static const String _chaveTema = 'modo_escuro';

  bool get modoEscuro => _modoEscuro;

  TemaProvider() {
    _carregarTema();
  }

  ThemeData get temaAtual => _modoEscuro ? _temaEscuro : _temaClaro;

  static final ThemeData _temaClaro = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
    cardTheme: const CardThemeData(  // Corrigido: removido 'const' do construtor
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );

  static final ThemeData _temaEscuro = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xFF1E1E1E),
    ),
    cardTheme: const CardThemeData(  // Corrigido
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      color: Color(0xFF2C2C2C),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
  );

  Future<void> _carregarTema() async {
    final prefs = await SharedPreferences.getInstance();
    _modoEscuro = prefs.getBool(_chaveTema) ?? false;
    notifyListeners();
  }

  Future<void> alternarTema() async {
    _modoEscuro = !_modoEscuro;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_chaveTema, _modoEscuro);
    notifyListeners();
  }
}