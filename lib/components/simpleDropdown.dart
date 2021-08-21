import 'package:flutter/material.dart';


DropdownButton<String> simpleDropdown(choseValue,list,hinttext,Function onChage) {
    var _dchosenValue;
    List<dynamic> itemsList;
    String hintText;
    Function onchaged; 
    _dchosenValue = choseValue;
    itemsList = list;
    hintText = hinttext;
    onchaged = onChage;
    
    return DropdownButton<String>(

      focusColor: Colors.black,
      value: _dchosenValue,
      style: TextStyle(color: Colors.grey),
      iconEnabledColor: Colors.black,
      underline: SizedBox(),
      isExpanded: true,
      items: itemsList != null && itemsList.length > 0
          ? itemsList.map<DropdownMenuItem<String>>((dynamic value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList()
          : null,
      hint: Text(
        hintText,
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      onChanged: (String value) {
        onchaged(value);
      },
    );
  }