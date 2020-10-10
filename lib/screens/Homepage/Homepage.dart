//import 'package:bymyeyefe/constant/StringConstant.dart';
//import 'package:bymyeyefe/screens/Bloc/homepage_bloc.dart';
//import 'package:bymyeyefe/screens/Bloc/homepage_event.dart';
//import 'package:bymyeyefe/screens/Bloc/homepage_state.dart';
//import 'package:bymyeyefe/screens/ButtonGradient.dart';
//import 'package:bymyeyefe/screens/Homepage/CategoryMovie.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:bymyeyefe/constant/UrlConstant.dart';
//import 'package:bymyeyefe/model/Movie.dart';
//import 'package:bymyeyefe/screens/Homepage/BannerImage.dart';
//import 'package:flutter/widgets.dart';
//import 'package:bymyeyefe/constant/ColorConstant.dart';
//import 'package:bymyeyefe/layout/mainLayout.dart';
//import '../../constant/ColorConstant.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert' show utf8;
//import 'dart:convert';
//
//class MyHomepage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MultiBlocProvider(
//        providers: [
//          BlocProvider<HomepageBloc> (
//            builder: (context) => HomepageBloc(),
//          )
//        ],
//        child: Homepage()
//    );
//  }
//}
//
//class Homepage extends StatefulWidget {
//  @override
//  _HomepageState createState() => _HomepageState();
//}
//
//class _HomepageState extends State<Homepage>  {
//  String url;
//  List<Movie> data;
//
//  @override
//  Widget build(BuildContext context) {
//    final HomepageBloc homepageBloc = BlocProvider.of<HomepageBloc>(context);
//        return Container(
//          color: ColorConstant.VIOLET,
//          child: Column(
//            children: <Widget>[
//              Container(
//                height: MediaQuery.of(context).size.height * 0.77,
//                child: ListView(
//                  children: <Widget>[
//                    //BannerImage(),
//                    //OptionTab('now-showing'),
//                    BlocBuilder<HomepageBloc, HomepageState>(
//                      bloc: homepageBloc,
//                      builder: (context, state) {
//
//                        List<Movie> _getData(String type) {
//                          url = UrlConstant.URL_FILM + type;
//                          {
//                            http.get(url).then((http.Response response) {
//                              setState(() {
//                                data = new List<Movie>();
//                                json.decode(response.body).forEach((json) {
//                                  data.add(Movie.fromJson(json));
//                                });
//                              });
//                            });
//                          };
//                          return data;
//                        }
//                        return Column(
//                          children: <Widget>[
//                            Container(
//                              //padding: EdgeInsets.symmetric(vertical: 10),
//                              padding: EdgeInsets.only(bottom: 8),
//                              width: double.infinity,
//                              child: Row(
//                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                children: <Widget>[
//                                  ButtonGradient('${state.firstType}', "now-showing", StringConstant.NOW_SHOWING, () => homepageBloc.dispatch(ChangeType("now-showing"))),
//                                  ButtonGradient('${state.firstType}', "coming-soon", StringConstant.COMMING_SOON, () => homepageBloc.dispatch(ChangeType("coming-soon"))),
//                                ],
//                              ),
//                            ),
//                            Container(
//                              height: MediaQuery.of(context).size.height * 0.675,
//                              child: CategoryMovie(_getData('${state.firstType}')),
//                              //child: Text(_getData('${state.firstType}')[1].name),
//                            ),
//                          ],
//                        );
//                      },
//                    ),
////                    Container(
////                      // height: 435,
////                        height: MediaQuery.of(context).size.height * 0.675,
////                        child: CategoryMovie(data)),
//                  ],
//                ),
//              )
//            ],
//          ));
//
//  }
//}
//
//
