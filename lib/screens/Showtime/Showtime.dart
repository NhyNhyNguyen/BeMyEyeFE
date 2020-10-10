//import 'package:bymyeyefe/constant/StringConstant.dart';
//import 'package:bymyeyefe/constant/StyleConstant.dart';
//import 'package:bymyeyefe/screens/Bloc/homepage_bloc.dart';
//import 'package:bymyeyefe/screens/Bloc/homepage_event.dart';
//import 'package:bymyeyefe/screens/Bloc/homepage_state.dart';
//import 'package:bymyeyefe/screens/Bloc/showtime_bloc.dart';
//import 'package:bymyeyefe/screens/Bloc/showtime_event.dart';
//import 'package:bymyeyefe/screens/Bloc/showtime_state.dart';
//import 'package:bymyeyefe/screens/ButtonGradient.dart';
//import 'package:bymyeyefe/screens/Homepage/CategoryMovie.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:bymyeyefe/constant/UrlConstant.dart';
//import 'package:bymyeyefe/model/Movie.dart';
//import 'package:flutter/widgets.dart';
//import 'package:bymyeyefe/constant/ColorConstant.dart';
//import 'package:bymyeyefe/layout/mainLayout.dart';
//import 'package:intl/intl.dart';
//import 'package:provider/provider.dart';
//import '../../constant/ColorConstant.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
//
//import 'CategoryShowtimeMovie.dart';
//import 'DateItem.dart';
//import 'ShowtimeMovieItem.dart';
//
//class MyShowtime extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MultiBlocProvider(
//            providers: [
//              BlocProvider<ShowtimeBloc> (
//                builder: (context) => ShowtimeBloc(),
//              )
//            ],
//            child: Showtime()
//        );
//  }
//}
//
//class Showtime extends StatefulWidget {
//  @override
//  _ShowtimeState createState() => _ShowtimeState();
//}
//
//class _ShowtimeState extends State<Showtime> {
//  DateTime date = DateTime.now();
//  List<int> listDuration = [0, 1, 2, 3, 4, 5, 6];
//
//  String url;
//  List<dynamic> data;
//
//  @override
//  Widget build(BuildContext context) {
//    final ShowtimeBloc showtimeBloc = BlocProvider.of<ShowtimeBloc>(context);
//    return Container(
//        color: ColorConstant.VIOLET,
//        child: BlocBuilder<ShowtimeBloc, ShowtimeState>(
//            bloc: showtimeBloc,
//            builder: (context, state) {
//
//              List<dynamic> _getData(String duration) {
//                DateTime newDate = date.add(Duration(days: int.parse(duration)));
//                String dd = DateFormat('dd').format(newDate).toString();
//                String mm = DateFormat('MM').format(newDate).toString();
//                String yyyy = DateFormat('yyyy').format(newDate).toString();
//                String dateShowime = dd + "/" + mm + "/" + yyyy;
//                print(dateShowime);
//                url = UrlConstant.URL_GET_SHOWTIME + dateShowime;
//                    if(data == null){
//                  http.get(url).then((http.Response response) {
//                    setState(() => data = json.decode(response.body) );
//                  });
//                };
//                return data;
//              }
//
//               _getData('${state.firstDate}');
//              return Column(
//                  children: <Widget>[
//                    Container(
//                      height: 65,
//                      margin: EdgeInsets.all(10),
//                      //padding: EdgeInsets.only(top: 8, left: 20),
//                      decoration: BoxDecoration(
//                          color: ColorConstant.LIGHT_VIOLET,
//                          borderRadius: BorderRadius.all(Radius.circular(20))
//                      ),
//                      child: GridView.count(
//                          crossAxisCount: 7,
//                          childAspectRatio: 0.75,
//                          children:
//                          listDuration.map(
//                                (item) =>
//                                InkWell(
//                                    onTap: () =>showtimeBloc.dispatch(ChangeDate(item)),
//                                    child: DateItem(date, item, '${state.firstDate}')),
//                          ).toList()
//                      ),
//                    ),
//                    Container(
//                      height: MediaQuery.of(context).size.height * 0.65,
//                      child: CategoryShowtimeMovie(_getData('${state.firstDate}')),
//                    ),
//                  ]);
//            }
//        )
//    );
//  }
//}
