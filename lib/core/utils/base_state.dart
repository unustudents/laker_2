enum StatusState { initial, loading, success, error }

class BaseState<T> {
  StatusState status;
  T? data;
  dynamic msg;
  BaseState({this.status = StatusState.initial, this.data, this.msg});
  BaseState<T> copyWith({StatusState? status, T? data, dynamic msg}) {
    return BaseState<T>(
        status: status ?? this.status,
        data: data ?? this.data,
        msg: msg ?? this.msg);
  }
}
