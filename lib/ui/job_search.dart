import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';
import 'package:quik_work/model/job.dart';

class JobSearch extends StatefulWidget {
  @override
  _JobSearch createState() => _JobSearch();
}

class _JobSearch extends State<JobSearch> {
  var _list = const [
    'Cashier',
    'Promoter',
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new MaterialSearch<String>(
          placeholder: 'Search',
          //placeholder of the search bar text input
          //or

          results: _list
              .map((name) => new MaterialSearchResult<String>(
                    value: name,
                    text: name, //The value must be of type <String>
                  ))
              .toList(),

          //optional. default filter will look like this:

          //optional

          //callback when some value is selected, optional.

          //callback when the value is submitted, optional.
          onSelect: (dynamic value) => Navigator.of(context).pop(value)),
    );
  }
}
