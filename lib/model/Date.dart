
enum DateEnum {
  mon,
  tue,
  wed,
  thu,
  fri,
  sat,
  sun
}


class Date{
  DateEnum getDateEnum(int num){
    switch(num){
      case 0:
        return DateEnum.mon;
      case 1:
        return DateEnum.tue;
      case 2:
        return DateEnum.wed;
      case 3:
        return DateEnum.thu;
      case 4:
        return DateEnum.fri;
      case 5:
        return DateEnum.sat;
    }
    return DateEnum.sun;
  }


  int getCode(DateEnum date){
    switch(date){
      case DateEnum.mon:
        return 0;
      case DateEnum.tue:
        return 1;
      case DateEnum.wed:
        return 2;
      case DateEnum.thu:
        return 3;
      case DateEnum.fri:
        return 4;
      case DateEnum.sat:
        return 5;
      case DateEnum.sun:
        return 6;

    }
    return 6;
  }

  int getCodeByString(String date){
    switch(date){
      case 'mon':
        return 0;
      case 'tue':
        return 1;
      case 'wed':
        return 2;
      case 'thu':
        return 3;
      case 'fri':
        return 4;
      case 'sat':
        return 5;
    }
    return 6;
  }
}