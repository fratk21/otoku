import 'package:flutter/material.dart';
import 'package:otoku/utils/colors.dart';

class AnimatedDropdown extends StatefulWidget {
  final List<String> dropdownItems;
  final Function(String) onChanged;
  final String label;

  AnimatedDropdown({
    required this.dropdownItems,
    required this.onChanged,
    required this.label,
  });

  @override
  _AnimatedDropdownState createState() => _AnimatedDropdownState();
}

class _AnimatedDropdownState extends State<AnimatedDropdown> {
  String selectedValue = 'Seçiniz';
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return buildDropdownButton();
  }

  Widget buildDropdownButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                isDropdownOpen = !isDropdownOpen;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.gblue,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                '${widget.label} : $selectedValue',
                style: TextStyle(color: AppColors.gblue),
              ),
            ),
          ),
          if (isDropdownOpen)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 200,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.gblue,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: widget.dropdownItems
                    .map(
                      (item) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedValue = item;
                            isDropdownOpen = false;
                          });
                          widget.onChanged(selectedValue);
                        },
                        child: Container(
                          width: 200,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.gblue,
                              ),
                            ),
                          ),
                          child: Text(item),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
