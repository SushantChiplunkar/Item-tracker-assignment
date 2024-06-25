import 'package:flutter/material.dart';
import 'package:item_tracker/providers/item_provider.dart';
import 'package:item_tracker/screens/item_edit_screen.dart';
import 'package:provider/provider.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Item Tracker'),
      ),
      body: ListView.builder(
        itemCount: itemProvider.items.length,
        itemBuilder: (context, index) {
          final item = itemProvider.items[index];
          final key = GlobalKey();

          return Container(
            key: key,
            child: ListTile(
              title: Text(item.name),
              subtitle: Text(item.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ItemEditScreen(
                            index: index,
                            item: item,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      itemProvider.removeItem(index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      _showItemPosition(context, key);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ItemEditScreen(), 
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void _showItemPosition(BuildContext context, GlobalKey key) {
  final RenderBox renderBox =
      key.currentContext!.findRenderObject() as RenderBox;
  final size = renderBox.size;
  final position = renderBox.localToGlobal(Offset.zero);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text('Size: $size\nPosition: $position'),
      );
    },
  );
}
