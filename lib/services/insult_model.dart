import 'package:flutter/material.dart';

import 'network_helper.dart';

class InsultModel {
  Future<dynamic> getEvilInsult(String lang) async {
    var url = Uri.https('evilinsult.com', '/generate_insult.php', {
      'lang': '$lang',
      'type': 'json',
    });

    NetworkHelper networkHelper = NetworkHelper(url);

    var insultData = await networkHelper.getData();
    print(insultData);
    return insultData;
  }
}
