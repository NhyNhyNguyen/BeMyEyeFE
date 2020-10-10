import 'package:intl/intl.dart';
class DateTimeUtil{
  static String formatDate(DateTime date){
    if(date == null){
      date = DateTime.now();
    }
    return new DateFormat("dd-MM-yyyy").format(date);
  }

//
//  Future<Null> _selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePicker(
//        context: context,
//        initialDate: selectedDate,
//        firstDate: DateTime(2015, 8),
//        lastDate: DateTime(2101));
//    if (picked != null && picked != selectedDate)
//      setState(() {
//        selectedDate = picked;
//      });
//  }
//
//  Row add_radio_button(int btnValue, String title) {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.start,
//      children: <Widget>[
//        Radio(
//          activeColor: Colors.green,
//          value: btnValue,
//          groupValue: -1,
//        ),
//        Text(title)
//      ],
//    );
//  }
//
//  Widget _genderAndDatetime() {
//    return Container(
//      child: Row(
//        mainAxisSize: MainAxisSize.min,
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        children: <Widget>[
//          Column(
//            children: <Widget>[
//              Text(
//                StringConstant.GENDER,
//                style: StyleConstant.normalTextStyle,
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  add_radio_button(0, 'Male'),
//                  add_radio_button(1, 'Female'),
//                ],
//              ),
//            ],
//          ),
//          Column(
//            children: <Widget>[
//              IconButton(
//                onPressed: () => _selectDate(context),
//                icon: Icon(Icons.date_range),
//              ),
//              Text("${selectedDate.toLocal()}".split(' ')[0]),
//            ],
//          )
//        ],
//      ),
//    );
//  }
}