import 'package:flutter/material.dart';
import '../models/carrinho.dart';
import '../models/produto.dart';

class CarrinhoProvider extends ChangeNotifier {
  final Carrinho _carrinho = Carrinho();

  Carrinho get carrinho => _carrinho;

  void adicionarProduto(Produto produto) {
    _carrinho.adicionarItem(produto);
    notifyListeners();
  }

  void removerProduto(String codigoBarras) {
    _carrinho.removerItem(codigoBarras);
    notifyListeners();
  }

  void removerProdutoCompleto(String codigoBarras) {
    _carrinho.removerItemCompleto(codigoBarras);
    notifyListeners();
  }

  void limparCarrinho() {
    _carrinho.limpar();
    notifyListeners();
  }
}