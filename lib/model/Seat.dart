class Seat{
  String seatId;
  int status;

  Seat(this.seatId, this.status);

  @override
  String toString() {
    return 'Seat{seatId: $seatId, status: $status}';
  }


}