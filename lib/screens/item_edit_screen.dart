import 'package:flutter/material.dart';
import 'package:item_tracker/models/item.dart';
import 'package:item_tracker/providers/item_provider.dart';
import 'package:provider/provider.dart';

class ItemEditScreen extends StatefulWidget {
  final int? index;
  final Item? item;

  ItemEditScreen({this.index, this.item});

  @override
  _ItemEditScreenState createState() => _ItemEditScreenState();
}

class _ItemEditScreenState extends State<ItemEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name ?? '';
    _description = widget.item?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.index == null ? 'Add Item' : 'Edit Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) {
                  _name = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _description = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.index == null) {
                      Provider.of<ItemProvider>(context, listen: false)
                          .addItem(_name, _description);
                    } else {
                      Provider.of<ItemProvider>(context, listen: false)
                          .editItem(widget.index!, _name, _description);
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text(widget.index == null ? 'Add' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}