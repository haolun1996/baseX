part of 'index.dart';

/// implements [ApiServiceMixin] and make your service class as singleton
/// with singleton example method below
mixin ApiServiceMixin {
  late ApiXService defaultServ;
  late String apiPath;

  // static final AuthServiceImpl service = AuthServiceImpl._();

  // AuthServiceImpl._() {
  //   print('AuthService had created!');
  // }

  // factory AuthServiceImpl({ApiXService? apiXService}) {
  //   if (apiXService == null) {
  //     service.defaultServ = defaultService;
  //   } else {
  //     service.defaultServ = apiXService;
  //   }

  //   return service;
  // }
}
