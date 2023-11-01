part of 'index.dart';

/// [SocialData] used to insert data from social platform and use on api calling

class SocialData extends XData {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final String providerName;

  SocialData(this.id, this.name, this.email, this.imageUrl, this.providerName);

  SocialData.google(
    this.id,
    this.name,
    this.email,
    this.imageUrl,
  ) : providerName = 'google';

  SocialData.facebook(
    this.id,
    this.name,
    this.email,
    this.imageUrl,
  ) : providerName = 'facebook';

  SocialData.apple(
    this.id,
    this.name,
    this.email,
    this.imageUrl,
  ) : providerName = 'apple';

  @override
  JSON toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'imageUrl': imageUrl,
        'providerName': providerName,
      };
}
