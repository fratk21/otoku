import 'package:flutter/material.dart';

class CustomListView extends StatefulWidget {
  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  // Öğelerin sayısı ve seçilip seçilmediğini takip etmek için bir liste.
  List<ItemModel> items = List.generate(
    4,
    (index) => ItemModel(index, false), // Varsayılan olarak seçilmedi.
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal, // Yatay kaydırma
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                // Seçenek durumunu tersine çevir.
                item.isSelected = !item.isSelected;
              });
            },
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: item.isSelected ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Resim $index',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text(
                  item.isSelected ? 'Seçili' : 'Seçilmedi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ItemModel {
  final int index;
  bool isSelected;

  ItemModel(this.index, this.isSelected);
}
