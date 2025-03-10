import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';

class TagInputWidget extends StatefulWidget {
  final String label;
  final String hint;
  final List<String> initialItems;
  final ValueChanged<List<String>> onChanged;

  const TagInputWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.initialItems,
    required this.onChanged,
  });

  @override
  State<TagInputWidget> createState() => _TagInputWidgetState();
}

class _TagInputWidgetState extends State<TagInputWidget> {
  late List<String> _items;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.initialItems);
  }

  void _addItem() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _items.add(text);
      });
      widget.onChanged(_items);
      _controller.clear();
    }
  }

  void _removeItem(String item) {
    setState(() {
      _items.remove(item);
    });
    widget.onChanged(_items);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style:  TextStyle(fontWeight: FontWeight.bold, )),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            ..._items.map((item) => Chip(
              label: Text(item, style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold),),
              backgroundColor: Colors.grey,
              deleteIcon:  JRoundedContainer( backgroundColor: Colors.white, child: Icon(Icons.close, size: 20, color: Colors.black,)),
              onDeleted: () => _removeItem(item),
            )),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                  onPressed: _addItem,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
