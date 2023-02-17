part of model;

/// [XData] is a base model to make sure extended classes have these method implmented
abstract class XData {
  XData();

  JSON toJson();
}
