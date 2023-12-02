import 'package:flutter/material.dart';

class MultiSelectChip<T> extends StatefulWidget {
  final List<T> items;
  final Function(List<T>)? onSelectionChanged;
  final String Function(T)? mapLabels;

  const MultiSelectChip(this.items, {this.onSelectionChanged, this.mapLabels});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState<T>();
}

class _MultiSelectChipState<T> extends State<MultiSelectChip<T>> {
  // String selectedChoice = "";
  List<T> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];

    for (var item in widget.items) {
      choices.add(
        Container(
          padding: const EdgeInsets.all(2),
          child: ChoiceChip(
            label: Text(widget.mapLabels!(item)),
            selected: selectedChoices.contains(item),
            onSelected: (selected) {
              setState(() {
                selectedChoices.contains(item)
                    ? selectedChoices.remove(item)
                    : selectedChoices.add(item);

                widget.onSelectionChanged!(selectedChoices);
              });
            },
          ),
        ),
      );
    }

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
