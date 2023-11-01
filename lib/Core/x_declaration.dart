import 'package:flutter/material.dart';

typedef GeneralErrorHandle = bool Function(BuildContext context, int code, String msg,
    {Function? tryAgain});
typedef GeneralErrorHandleConfig = bool Function(BuildContext context, int code, String msg);
typedef OnFailed = bool Function(int code, String message, dynamic data, {Function() tryAgain});
typedef OnFail = bool Function(int code, String message, dynamic result);
typedef OnGenericCallBack = void Function(String message, dynamic result);
typedef FromJsonM<T> = Function(T);
typedef JSON = Map<String, dynamic>;
typedef JSONLIST = List<dynamic>;
typedef AddtionalWidget = Widget Function(Widget child);

GeneralErrorHandle onFailed = ((BuildContext context, code, msg, {tryAgain}) => true);

typedef OnDoneCallBack<T> = void Function(T item);
