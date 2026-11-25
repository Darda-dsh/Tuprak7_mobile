import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, String>> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void hapusItem(int index) {
    final removed = widget.cartItems[index];

    setState(() {
      widget.cartItems.removeAt(index); // hapus item, tampilan ikut diperbarui
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removed['nama']} dihapus'),
        action: SnackBarAction(
          label: 'Batal',
          onPressed: () {
            setState(() {
              widget.cartItems.insert(index, removed); // kembalikan item
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text('Keranjang kosong'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: Image.network(
                      item['gambar']!,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['nama']!),
                    subtitle: Text(item['lokasi']!),
                    trailing: ElevatedButton.icon(
                      onPressed: () => hapusItem(index),
                      icon: const Icon(Icons.delete),
                      label: const Text('Hapus'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}