import 'package:flutter/material.dart';

class BrilloDropDown extends StatelessWidget {
  const BrilloDropDown({
    Key? key,
    required this.sportList,
    required this.onchaged,
    required this.selectedItem,
  }) : super(key: key);

  final List sportList;
  final void Function(Object?) onchaged;
  final String selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField(
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  //<-- SEE HERE
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  //<-- SEE HERE
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              hint: Text(selectedItem),
              items: sportList
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onchaged),
        ),
      ),
    );
  }
}
