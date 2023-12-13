import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class ListCategories extends StatefulWidget {
  const ListCategories({
    super.key,
    required this.callback,
  });

  final Function(String) callback;

  @override
  State<ListCategories> createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
  int _selected = 0;

  List<String> specialty = Specialty.values.map((e) => e.name).toList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dimensWidth() * 5.5,
      child: ListView.builder(
        itemCount: specialty.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(top: dimensWidth()),
        itemBuilder: (context, index) => InkWell(
          splashColor: transparent,
          highlightColor: transparent,
          onTap: () => setState(() {
            _selected = index;
            widget.callback(specialty[index]);
          }),
          child: Container(
            margin: EdgeInsets.only(
              left: index == 0 ? dimensWidth() * 3 : dimensWidth(),
              right: index == specialty.length - 1
                  ? dimensWidth() * 3
                  : dimensWidth(),
            ),
            padding: EdgeInsets.symmetric(
                vertical: dimensWidth(), horizontal: dimensWidth() * 2.5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _selected == index ? primary : null,
              border: Border.all(color: primary, width: 1),
              borderRadius: BorderRadius.circular(
                dimensWidth() * 3,
              ),
            ),
            child: Text(
              translate(context, specialty[index]),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: _selected == index ? white : primary),
            ),
          ),
        ),
      ),
    );
  }
}
