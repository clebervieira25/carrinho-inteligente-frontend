import 'package:flutter/material.dart';

class EscolhaLeitorDialog extends StatelessWidget {
  const EscolhaLeitorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Como deseja adicionar?'),
      content: const Text('Escolha a forma de inserir o código do produto'),
      actions: [
        // Botão Cancelar
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        // Botão Digitar
        ElevatedButton.icon(
          onPressed: () => Navigator.pop(context, 'digitar'),
          icon: const Icon(Icons.keyboard),
          label: const Text('Digitar'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
        // Botão Câmera
        ElevatedButton.icon(
          onPressed: () => Navigator.pop(context, 'camera'),
          icon: const Icon(Icons.camera_alt),
          label: const Text('Câmera'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}