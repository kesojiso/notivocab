class NoticeSchedule {
  int? hour;
  int? minute;
  NoticeSchedule({this.hour, this.minute});

  // インスタンスの比較を行うため、==演算子をオーバーライド
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NoticeSchedule) return false;
    return hour == other.hour && minute == other.minute;
  }

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;
}
