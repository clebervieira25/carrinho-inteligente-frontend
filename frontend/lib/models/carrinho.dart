import 'produto.dart';

class Carrinho {
  final List<Produto> _itens = [];

  List<Produto> get itens => List.unmodifiable(_itens);

  // Calcular total do carrinho
  double get total {
    return _itens.fold(0, (sum, item) => sum + item.subtotal);
  }

  // Calcular total de itens
  int get totalItens {
    return _itens.fold(0, (sum, item) => sum + item.quantidade);
  }

  // Adicionar item (ou incrementar quantidade)
  void adicionarItem(Produto novoProduto) {
    final index = _itens.indexWhere((p) => p.codigoBarras == novoProduto.codigoBarras);
    
    if (index >= 0) {
      _itens[index].quantidade++;
    } else {
      _itens.add(novoProduto);
    }
  }

  // Remover um item (ou decrementar quantidade)
  void removerItem(String codigoBarras) {
    final index = _itens.indexWhere((p) => p.codigoBarras == codigoBarras);
    
    if (index >= 0) {
      if (_itens[index].quantidade > 1) {
        _itens[index].quantidade--;
      } else {
        _itens.removeAt(index);
      }
    }
  }

  // Remover item completamente
  void removerItemCompleto(String codigoBarras) {
    _itens.removeWhere((p) => p.codigoBarras == codigoBarras);
  }

  // Limpar carrinho
  void limpar() {
    _itens.clear();
  }
}