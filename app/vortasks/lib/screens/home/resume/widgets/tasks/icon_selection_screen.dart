import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/core/data/Icon_manager.dart';
import 'package:vortasks/models/tasks/task.dart';
import 'package:vortasks/stores/shop/purchased_items_store.dart';

class IconSelectionScreen extends StatefulWidget {
  final Task task;

  const IconSelectionScreen({super.key, required this.task});

  @override
  State<IconSelectionScreen> createState() => _IconSelectionScreenState();
}

class _IconSelectionScreenState extends State<IconSelectionScreen> {
  final PurchasedItemsStore _purchasedItemsStore =
      GetIt.I<PurchasedItemsStore>();

  String? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _selectedIcon =
        widget.task.icon; // Define o ícone atual da tarefa como o selecionado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Ícone'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _purchasedItemsStore.purchasedItems.length +
            1, // +1 para incluir o ícone padrão
        itemBuilder: (context, index) {
          // O primeiro item é o ícone padrão
          if (index == 0) {
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedIcon =
                      ''; // Define como string vazia para usar o ícone padrão
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _selectedIcon ==
                            '' // Verifica se _selectedIcon é uma string vazia
                        ? Colors.blue
                        : Colors.transparent,
                    width: 2.0,
                  ),
                ),
                child: const Icon(Icons.task, size: 40), // Ícone padrão
              ),
            );
          } else {
            // Os outros itens são os ícones comprados
            final item = _purchasedItemsStore.purchasedItems[index - 1];
            if (item.icon.isNotEmpty) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedIcon = item.icon;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _selectedIcon == item.icon
                          ? Colors.blue
                          : Colors.transparent,
                      width: 2.0,
                    ),
                  ),
                  child: FutureBuilder<String?>(
                    future: IconManager().getLocalIconPath(item.icon),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData && snapshot.data != null) {
                        return Image.file(File(snapshot.data!));
                      } else {
                        return const Icon(Icons.error);
                      }
                    },
                  ),
                ),
              );
            } else {
              return Container();
            }
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Retorna o ícone selecionado para a tela anterior
            Navigator.pop(context, _selectedIcon);
          },
          child: const Text('Salvar'),
        ),
      ),
    );
  }
}
