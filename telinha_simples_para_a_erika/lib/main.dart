import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final List<String> _itens = [];

  void _adicionar() {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      _itens.add(texto);
      _controller.clear();
    });
  }

  void _remover(int index) {
    setState(() => _itens.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minha lista')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Digite algo...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _adicionar(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _adicionar,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: _itens.isEmpty
                ? const Center(child: Text('Nada por aqui ainda'))
                : ListView.builder(
                    itemCount: _itens.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_itens[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => _remover(index),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
