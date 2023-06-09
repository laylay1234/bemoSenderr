import 'package:flutter_amplifysdk/utils.dart';

class Utils {
  DateTime _startTime = DateTime.now();

  static Json getCreateInput({required Json model}) {
    Json _createInput = {...model};
    // _createInput.remove('createdAt');
    _createInput.remove('updatedAt');
    return _createInput;
  }

  static Json getUpdateInput({required Json model, required Json input}) {
    Json _updateInput = {};
    if (model.keys.isNotEmpty) {
      for (var _item in input.entries) {
        // Ignore these fields
        if (_item.key != 'createdAt' && _item.key != 'updatedAt') model[_item.key] = _item.value;
      }
      input = model;
    }
    _updateInput = {...input};
    // _updateInput.remove('createdAt');
    _updateInput.remove('updatedAt');
    return _updateInput;
  }
}
