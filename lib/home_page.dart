import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';

enum OurDateConverter { convertToEng, convertToNep }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _option = OurDateConverter.convertToNep;
  DateTime defaultDate = DateTime(1990, 05, 14);

  String finalResult = "";

  Future<void> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: defaultDate,
        firstDate: DateTime(1980),
        lastDate: DateTime(2025));

    if (_datePicker != null && _datePicker != defaultDate) {
      setState(() {
        defaultDate = _datePicker;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nepali Date Converter'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: RadioListTile<OurDateConverter>(
                    title: Text("Convert to English "),
                    value: OurDateConverter.convertToEng,
                    groupValue: _option,
                    onChanged: (OurDateConverter? val) {
                      setState(() {
                        _option = val!;
                      });
                    }),
              ),
              Expanded(
                child: RadioListTile<OurDateConverter>(
                    title: Text("Convert to Nepali"),
                    value: OurDateConverter.convertToNep,
                    groupValue: _option,
                    onChanged: (OurDateConverter? val) {
                      setState(() {
                        _option = val!;
                      });
                    }),
              ),
            ],
          ),
          _option == OurDateConverter.convertToEng
              ? Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.green,
                  child: Text("Enter Nepali Date"),
                )
              : Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.yellow,
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text('Choose English Date')),
                      Text(
                        'Selected Date: ${DateFormat.yMMMMEEEEd().format(defaultDate)}',
                        style: TextStyle(fontSize: 22),
                      )
                    ],
                  ),
                ),
          ElevatedButton.icon(
              onPressed: () {
                if (_option == OurDateConverter.convertToNep) {
                  setState(() {
                    finalResult = "Successful";
                    NepaliDateTime nt = DateTime(defaultDate.year,
                            defaultDate.month, defaultDate.day)
                        .toNepaliDateTime();

                    finalResult =
                        "Converted Date: ${nt.toString().substring(0, 10)}";
                  });
                } else {
                  //TODO: Convert to English

                }
              },
              icon: Icon(Icons.calculate),
              label: Text("Convert")),
          Text(
            finalResult,
            style: TextStyle(fontSize: 22),
          )
        ],
      ),
    );
  }
}
