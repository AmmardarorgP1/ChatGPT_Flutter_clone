// ignore_for_file: prefer_const_constructors

import '../models/Model.dart';
import '../models/Network.dart';
import '../provider/Provider.dart';
import 'package:provider/provider.dart';
import '../consts/consts.dart';


import 'package:flutter/material.dart';



class DropDownMenu extends StatefulWidget {
  const DropDownMenu({super.key});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {

  late String? model;
   late  String? selectedModel = null;
  late List<Data>? data;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderModel>(context,listen: false);
    return FutureBuilder(future:provider.getDataFromApiProvider(), builder: (context,snapshot){
      if(snapshot.hasData)
        {

           data = snapshot.data?.data;
           //Initialize selectedModel only if it's null
           if(selectedModel == null)
          {
            selectedModel = provider.getCurrentModel;
            model = selectedModel;
          }
          return  DropdownButton(
            dropdownColor: scaffoldBackgroundColor,
            style: TextStyle(color: Colors.white),
            items: [
              ...?data?.map((value) {
                return DropdownMenuItem<String>(value: value.id,child: Text(value.id.toString()),);
              }).toList()
            ],
            value: selectedModel,
            onChanged:(value) {
              setState(() {
                selectedModel = value.toString();
              });

              provider.setCurrentModel(value.toString());


            },);

        }
      else if(snapshot.hasError)
        {
          return Center(
            child: Text(snapshot.error.toString()),
          );
          
        }
      else
        {
          return SizedBox.shrink();
        }

    });
  }
}

/**/