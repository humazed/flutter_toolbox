import 'package:flutter/material.dart';
import 'package:flutter_toolbox/generated/i18n.dart';

class SearchItemPicker<T> extends StatefulWidget {
  SearchItemPicker({
    Key key,
    @required this.items,
    @required this.onChanged,
    @required this.hint,
    this.initialValue,
    this.disabledHint,
    this.prefixIcon,
    this.suffixIcon,
    this.border,
    this.elevation = 0,
    this.borderRadius = 0,
    this.color = Colors.white,
  })  : assert(items == null ||
            items.isEmpty ||
            initialValue == null ||
            items
                    .where((ListItem<T> item) => item.value == initialValue)
                    .length ==
                1),
        super(key: key);

  /// The list of items the user can select.
  ///
  /// If the [onChanged] callback is null or the list of items is null
  /// then the dropdown button will be disabled, i.e. its arrow will be
  /// displayed in grey and it will not respond to input. A disabled button
  /// will display the [disabledHint] widget if it is non-null.
  final List<ListItem<T>> items;

  /// The value of the currently selected [ListItem], or null if no
  /// item has been selected. If `value` is null then the menu is popped up as
  /// if the first item were selected.
  final T initialValue;

  /// Displayed if [initialValue] is null.
  final String hint;

  /// A message to show when the dropdown is disabled.
  ///
  /// Displayed if [items] or [onChanged] is null.
  final Widget disabledHint;

  /// Called when the user selects an item.
  ///
  /// If the [onChanged] callback is null or the list of [items] is null
  /// then the dropdown button will be disabled, i.e. its arrow will be
  /// displayed in grey and it will not respond to input. A disabled button
  /// will display the [disabledHint] widget if it is non-null.
  final ValueChanged<T> onChanged;

  final Widget prefixIcon;

  final Widget suffixIcon;

  final double elevation;

  final double borderRadius;

  final Color color;

  final InputBorder border;

  @override
  SearchItemPickerState<T> createState() => SearchItemPickerState<T>();
}

class SearchItemPickerState<T> extends State<SearchItemPicker<T>> {
  final itemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      itemController.text = widget.items
          .firstWhere((item) => item.value == widget.initialValue)
          .text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevation,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      color: widget.color,
      child: InkWell(
        onTap: () async {
          ListItem<T> pickedItem =
              await ItemsList.pickItem(context, widget.items, widget.hint);
          itemController.text = pickedItem.text;

          widget.onChanged(pickedItem.value);
        },
        child: ItemTextField(
          controller: itemController,
          hint: widget.hint,
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          border: widget.border,
        ),
      ),
    );
  }
}

class ItemsList<T> extends StatefulWidget {
  ItemsList({
    Key key,
    @required List<ListItem<T>> items,
    @required this.hint,
  })  : items = items.where((item) => item.text?.isNotEmpty == true).toList(),
        super(key: key);

  final List<ListItem<T>> items;
  final String hint;

  static Future<ListItem<T>> pickItem<T>(
    BuildContext context,
    List<ListItem<T>> items,
    String hint,
  ) async {
    dynamic results = await Navigator.of(context).push(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return ItemsList(
            items: items,
            hint: hint,
          );
        },
      ),
    );

    if (results != null && results.containsKey('pickedItem')) {
      return results['pickedItem'];
    } else {
      return null;
    }
  }

  @override
  State createState() => ItemsListState<T>();
}

class ItemsListState<T> extends State<ItemsList> {
  List<ListItem<T>> items;

  TextEditingController controller = TextEditingController();
  String filter;

  @override
  void initState() {
    super.initState();
    items = widget.items;
    //fill items with objects
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hint),
      ),
      body: Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 8, left: 16, right: 16),
                child: TextField(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        controller.clear();
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                    hintText: S.of(context)?.search ?? 'Search...',
                  ),
                  controller: controller,
                )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 8),
                child: _buildListView(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        if (filter == null || filter == "") {
          return InkWell(
            onTap: () =>
                Navigator.of(context).pop({'pickedItem': items[index]}),
            child: items[index],
          );
        } else {
          if (items[index].text.toLowerCase().contains(filter.toLowerCase())) {
            return InkWell(
              onTap: () =>
                  Navigator.of(context).pop({'pickedItem': items[index]}),
              child: items[index],
            );
          } else {
            return Container();
          }
        }
      },
    );
  }
}

/// An item in a menu created by a [DropdownButton].
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
class ListItem<T> extends StatelessWidget {
  /// Creates an item for a dropdown menu.
  ///
  /// The [text] argument is required.
  const ListItem({
    Key key,
    this.value,
    @required this.text,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Text] widget.
  final String text;

  /// The value to return if the user selects this menu item.
  ///
  /// Eventually returned in a call to [DropdownButton.onChanged].
  final T value;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(text));
  }
}

class ItemTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final int maxLines;
  final String initialValue;
  final InputBorder border;

  ItemTextField({
    this.hint,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.border,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      initialValue: initialValue,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hint,
        border: border,
      ),
      enabled: false,
    );
  }
}
