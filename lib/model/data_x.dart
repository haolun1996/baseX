part of 'index.dart';

/// [XData] is a base model to make sure extended classes have these method implmented
abstract class XData {
  XData();

  JSON toJson();
}
