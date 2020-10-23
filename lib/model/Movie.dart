import 'dart:convert';
import 'package:bymyeyefe/constant/ConstantVar.dart';
import 'package:bymyeyefe/constant/UrlConstant.dart';
import 'package:http/http.dart' as http;

class Movie {
  final int id;
  final String name;
  final String trailer;
  final String poster;
  final bool status;
  final double ratePoint;
  final String timeLimit;
  final String premiere;
  final String artist;
  final String director;
  final String content;
  final String nation;
  final List genres;

  Movie({
  this.id,
  this.name,
  this.trailer,
  this.poster,
  this.status,
  this.ratePoint,
  this.timeLimit,
  this.premiere,
  this.artist,
  this.director,
  this.content,
  this.nation,
  this.genres});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      name: json['name'],
      trailer: json['trailer'],
      poster: json['poster'],
      status: json['status'],
      ratePoint: json['ratePoint'],
      timeLimit: json['timeLimit'],
      premiere: json['premiere'],
      artist: json['artist'],
      director: json['director'],
      content: json['content'],
      nation: json['nation'],
      genres: json['genres'],
    );
  }






}
