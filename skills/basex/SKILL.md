---
name: basex
description: How to build Flutter screens, controllers, API calls and app setup with the private baseX framework (GetX + Dio). Use when writing or changing code in an app that depends on `baseX` (imports `package:baseX/base_x.dart`), e.g. adding a page, a controller, a service/API call, navigation, error handling, social login, or using XCachedImage / XSkeleton / XPicker.
---

# baseX

baseX wraps GetX (state, DI, routing) and Dio (HTTP) into a fixed set of patterns. When an app depends on baseX, follow these patterns instead of using GetX/Dio directly.

See [references/basex-framework.md](references/basex-framework.md) for the feature overview and version requirements.

## Imports

```dart
import 'package:baseX/base_x.dart';
```

This re-exports `package:get/get.dart` (minus `Response`, `FormData`, `MultipartFile`) and Dio's `MultipartFile`, so don't import `get` separately.

Some APIs are **not** exported from `base_x.dart` and need a direct import:

| API | Import |
|---|---|
| `SocialLogin` mixin | `package:baseX/controller/social_login_service.dart` |
| `KeyboardDismissOnTap`, `IgnoreKeyboardDismiss` | `package:baseX/x_widget/x_keyboard_dismiss_on_tap.dart` |
| `openXMaps`, `openXGoogleMaps`, `openXAppleMaps`, `openXWazeMaps`, `openXPlatformMaps`, `showXMapSelection` | `package:baseX/x_widget/x_open_map.dart` |

Lint: in the app's `analysis_options.yaml` use `include: package:baseX/x_lint/x_lint.yaml`. It enforces `always_use_package_imports`, `prefer_single_quotes`, `avoid_print` (use `XLogger`), and required named parameters first.

## App entry: `runXApp`

```dart
void main() => runXApp<AppLabel, AppLanguage>(
      title: 'My App',
      lightTheme: AppTheme.light,
      darkTheme: AppTheme.dark,
      liveBaseUrl: 'https://api.example.com',
      staginBaseUrl: 'https://staging-api.example.com', // note the spelling
      sharedPref: () => X = AppSharePref(),             // assign the global X
      getPages: AppPages.pages,
      initialPage: SplashPage(),
      initialBinding: AppBinding(),
      onFailed: (context, code, msg, {tryAgain}) => false, // true = handled; false = show default dialog
      currentEnv: Environment.Staging,
      constantConfig: AppConstant(),   // optional subclass of DefaultBaseConstant
      langController: AppLangController(), // optional XLangController
    );
```

- Base URL: debug builds use `staginBaseUrl`, release builds use `liveBaseUrl`.
- `required200: true` when the backend always returns HTTP 200 with `code`/`status` in the body; non-success codes are then turned into errors by the interceptor.
- `customHttp`: subclass `BaseXHttp` to remap status codes (e.g. a different force-update code).
- Globals available after startup: `baseConstant`, `defaultService` (the `ApiXService`), `defaultLangController`, `X` (`BaseXSharePref`).

### App constant

Subclass `DefaultBaseConstant` to override defaults: `defaultBackgroundColor`, `defaultLoadingWidget` (shown while `isLoading` is true), `envBar`, `position` (where the staging env bar shows), `additionalHeader` (extra headers on every request), `floatingAction`, `drawerAction`, `defaulOnFailedDialog`.

### Shared preferences

Implement `BaseXSharePref` (`accessToken`, `languageCode`, `saveKeyWithValue`) and assign it to the global `X`. The interceptor reads `X?.accessToken` for the `Authorization: Bearer` header.

## Pages: `BaseXController` + `BaseXWidget`

Every screen is a controller/widget pair.

```dart
class ProfileController extends BaseXController<ProfilePage> {
  final name = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // page (the ProfilePage instance) holds the navigation arguments
    loadProfile(page.userId);
  }

  Future<void> loadProfile(int id) async {
    isLoading.value = true;
    final user = await UserService().getUser(id, onFailed);
    isLoading.value = false;
    if (user != null) name.value = user.name;
  }
}

class ProfilePage extends BaseXWidget<ProfileController> {
  ProfilePage({this.userId = 0});
  final int userId;

  @override
  String get routeName => '/profile';

  @override
  bool get topSafeArea => true;

  @override
  Widget? appBar(BuildContext context) => AppBar(title: Text('Profile'));

  @override
  Widget? body(BuildContext context) => Obx(() => Text(c.name.value));
}
```

Rules:
- `BaseXWidget` builds the `Scaffold` itself. Put content in `appBar()` / `body()`, not your own `Scaffold`. Use `overlayChild()` for overlays.
- Access the controller via `c`.
- `page` in the controller is the widget instance passed as the route argument. Pass data to a screen through the widget's constructor fields, and never reassign `page`.
- Set `isLoading.value = true` to show the global loader; `onFailed` resets it to false.
- Pass the controller's own `onFailed` as the `OnFail` to API calls. It calls the global handler, then falls back to the default dialog.
- Block back navigation with `isAllowBack.value = false`, or override `onBack()`.
- Drawer/FAB: set `hasDrawer.value = true` / `hasFloatingButton.value = true` and override `drawerAction` / `floatingAction` on the page (or in the app constant).
- Layout options: `topSafeArea`, `bottomSafeArea`, `resizeToAvoidBottomInset`, `backgroundColor`, `stackedAppBar` (body overlaps the app bar by N px).
- The scaffold already wraps the body in `KeyboardDismissOnTap`.

## Routing

Register pages with `cGetPage` (and `cGetPageInitial` for the initial page) so that the widget instance is the route argument:

```dart
class AppPages {
  static final pages = [
    cGetPageInitial(SplashPage(), binding: BindingsBuilder(() => Get.lazyPut(() => SplashController()))),
    cGetPage(ProfilePage(), binding: BindingsBuilder(() => Get.lazyPut(() => ProfileController()))),
  ];
}
```

Navigate with the page instance, not with route strings:

| Function | Use |
|---|---|
| `await loadPage(ProfilePage(userId: 1))` | Push; returns the result passed to `Get.back(result: ...)` |
| `loadPageWithRemovePrevious(to, from)` | Push and pop back to `from` |
| `loadPageWithRemoveAllPrevious(HomePage())` | Replace the whole stack (e.g. after login/logout) |
| `backTo(HomePage())` | Pop until that page |
| `getController<HomeController>()` | `Get.find` that returns null if not registered |

## API calls

Create a singleton service class with `ApiServiceMixin`, using the global `defaultService`:

```dart
class UserService with ApiServiceMixin {
  static final UserService _service = UserService._();
  UserService._();

  factory UserService({ApiXService? apiXService}) {
    _service.defaultServ = apiXService ?? defaultService;
    return _service;
  }

  Future<User?> getUser(int id, OnFail onFailed) async {
    return await defaultServ.get<JSON>(
      'users',
      onFailed,
      pathParam: '$id',
      create: (JSON data) => User.fromJson(data),
    );
  }

  Future<List<Country>?> getCountries(OnFail onFailed) async {
    return await defaultServ.get<JSONLIST>(
      'countries',
      onFailed,
      requiredToken: false,
      create: (JSONLIST data) => Country.listFromJson(data),
    );
  }
}
```

`ApiXService` methods:
- `get<T>(endpoint, onFailed, {required create, requiredToken, pathParam, queryParam})`
- `post<T>(endpoint, body, onFailed, {create, onSuccess, requiredToken, uploadProgress, downloadProgress})`: the body is sent as `FormData`, so pass `MultipartFile` values directly for uploads.
- `put(endpoint, body, onFailed, {onSuccess, requiredToken})`
- `delete(endpoint, pathParam, onFailed, {create, onSuccess, requiredToken, queryParam})`
- `setNewEndpoint(url)`: change the base URL at runtime.

Behaviour to rely on:
- The endpoint has no leading slash (`'users'`, not `'/users'`); the service adds it.
- Responses must be shaped `{ "message": ..., "data": ... }`. `create` receives `data` (a `JSON` map or `JSONLIST`), and the call returns what `create` returns.
- `requiredToken` defaults to `true` and adds `Authorization: Bearer <X.accessToken>`. Use `false` for public endpoints.
- On error the call returns `null` and invokes `onFailed(code, message, null)`. Always null-check the result.
- Standard headers (`App-Version`, `Os-Type`, `Device-Model`, `Device-ID`, `Os-Version`, `Accept-Language`, `Label-Version`) are added automatically, plus `baseConstant.additionalHeader`.

### Error codes passed to `onFailed`

| Exception | Code |
|---|---|
| `InvalidRequestException` | 400 |
| `UnauthorizedException` | 401 |
| `NotFoundException` | 404 |
| `ForceUpdateException` | 409 |
| `ValidationException` | 422 |
| `TooManyRequestException` | 429 |
| `InternalServerErrorException` | 500 |
| `MaintenanceException` | 503 |
| `NoConnectionException` / `TimeOutException` | -1 |
| Anything else | 520 (release) / -99999 (debug) |

Handle app-wide cases (401 → logout, 409 → force update, 503 → maintenance) in the global `onFailed` given to `runXApp`. Return `true` when handled, otherwise `false` to show the default dialog.

## Social login

Mix `SocialLogin` into a controller. Each method returns `(token, SocialData)?` and reports failures through `OnFail` (`CANCELLED` 10001, `IN_PROGRESS` 10002, `NETWORK_ERROR` 10003, `FAILED` 10009).

```dart
class LoginController extends BaseXController<LoginPage> with SocialLogin {
  Future<void> google() async {
    final result = await loginGoogle(onFailed);
    if (result == null) return;
    final (token, user) = result;
    // send token to backend
  }
}
```

`loginApple` works only on iOS/macOS and throws elsewhere. `loginFacebook` and `loginGoogle` also exist.

## Widgets

- `XCachedImage(imageUrl: ..., width:, height:, boxDecoration:, hasSkeleton: true, fit:)` / `XCachedImage.round(...)`: a network image with a cache, placeholder and error icon. `borderRadius` is deprecated; use `boxDecoration`.
- `XSkeleton(height:, width:, borderRadius:)`: a shimmering placeholder. Also `XSkeleton.round(size:)`, `XSkeleton.square(size:)`, `XSkeleton.ratio(aspectRatio:, height:)`, and `XSkeleton.skeletonList(child: Row(...), count:)` for list placeholders.
- `showXPicker<T extends XPickerItem>(items, selectedItem)`: a bottom-sheet picker that returns the selected item or null. Items are `XPickerItem(id, value)` or subclasses.
- `showXMapSelection(latitude:, longitude:, ...)`: lets the user pick an installed map app. Use `openXMaps(coords: LocationCoords(lat, lng, title: ...), mapType: MapApp.google)` to open a specific one.

## Utilities

- `XLogger.info/success/warning/error(msg)`: use instead of `print`.
- `baseConstant.isHMS()` / `isGMS()`: detect Huawei vs. Google services before using platform services.
- `XLangController<T extends XLabel, K extends XLanguage>`: server-driven labels. Use `translate(key)` and `changeLanguage(locale)`.
