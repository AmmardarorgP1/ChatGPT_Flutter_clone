import '../models/Network.dart';
import 'package:flutter/material.dart';

import '../models/Model.dart';

class ProviderModel with ChangeNotifier {
  String? _currentModel = "whisper-1";

  void setCurrentModel(String model) {
    _currentModel = model;
    notifyListeners();
  }

  String? get getCurrentModel {
    return _currentModel;
  }

  Future<API_MODEL> getDataFromApiProvider() async {
    final apiData = await ApiService().getModel();

    return apiData;
  }







// // extra work for any case in future if needed list of all models is generated

//
//
//
// final List<String?> allModels = [];
//
// final apiData = ApiService().getModel();
//
  // List<String?> get listGenerate {
  //   apiData.then((value) {
  //     List.generate(value.data!.length, (index) {
  //       return allModels.add(value.data[index].id);
  //     });
  //   });
  //
  //   return allModels;
  // }
  //
  // List<String?> get getListModels {
  //   return allModels;
  // }
}
