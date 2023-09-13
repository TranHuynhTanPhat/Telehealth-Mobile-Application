import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class ListCategories extends StatefulWidget {
  const ListCategories({
    super.key,
    required this.categories,
    required this.chooseCategory,
    required this.selected,
  });

  final List<String> categories;
  final int selected;
  final Function(int) chooseCategory;

  @override
  State<ListCategories> createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dimensWidth() * 5.5,
      child: ListView.builder(
        itemCount: widget.categories.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(top: dimensWidth()),
        itemBuilder: (context, index) => InkWell(
          splashColor: transparent,
          highlightColor: transparent,
          onTap: () => widget.chooseCategory(index),
          child: Container(
            margin: EdgeInsets.only(
              left: index == 0 ? dimensWidth() * 3 : dimensWidth(),
              right: index == widget.categories.length - 1
                  ? dimensWidth() * 3
                  : dimensWidth(),
            ),
            padding: EdgeInsets.symmetric(
                vertical: dimensWidth(), horizontal: dimensWidth() * 2.5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.selected == index ? primary : null,
              border: Border.all(color: primary, width: 1),
              borderRadius: BorderRadius.circular(
                dimensWidth() * 3,
              ),
            ),
            child: Text(
              AppLocalizations.of(context).translate(widget.categories[index]),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: widget.selected == index ? white : primary),
            ),
          ),
        ),
      ),
    );
  }
}
