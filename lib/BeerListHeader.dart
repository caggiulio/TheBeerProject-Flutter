import 'package:flutter/material.dart';

class BeerListHeader extends StatelessWidget {
  const BeerListHeader({
    Key key,
    this.onTapCell,
    this.checkSelected,
  }) : super(key: key);

  final Function onTapCell;
  final Function checkSelected;

  static const categories = <String>[
    "Pilsner",
    "Lager",
    "Ale",
    "Amber",
    "Dark",
    "Brown",
    "Cream",
    "Red",
    "Golden",
    "Fruit",
    "Honey"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 1 + categories.length,
          // ignore: missing_return
          itemBuilder: (BuildContext context, i) {
            String key = i == 0 ? "" : categories[i - 1];
            return new BeerCategoryItem(
                search: key,
                name: i == 0 ? "All" : categories[i - 1],
                onTapCell: onTapCell,
                isSelected: checkSelected(key));
          }),
    );
  }
}

class BeerCategoryItem extends StatelessWidget {
  const BeerCategoryItem({
    Key key,
    this.search,
    this.name,
    this.onTapCell,
    this.isSelected,
  }) : super(key: key);

  final String search;
  final String name;
  final Function onTapCell;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
      child: ChoiceChip(
        label: Text(name),
        selected: isSelected,
        onSelected: (sel) {
          if (sel) onTapCell(search);
        },
      ),
    );
  }
}
