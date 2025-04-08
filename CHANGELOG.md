# Change Log

## [v0.4.0](https://github.com/haolun1996/baseX/releases/tag/0.3.0) - 2025-04-08
- Changes
    - To use [gms_check](https://pub.dev/packages/gms_check) from flutter_hms_gms_availability at [line](https://github.com/haolun1996/baseX/blob/af2395ac3047372079f00001dc7f56d732145e71/pubspec.yaml#L20)
        - init [GmsCheck](https://github.com/haolun1996/baseX/blob/af2395ac3047372079f00001dc7f56d732145e71/lib/Core/x_get_app.dart#L56) at runXApp
        - trigger function [isGmsAvailable](https://github.com/haolun1996/baseX/blob/af2395ac3047372079f00001dc7f56d732145e71/lib/Core/x_constant.dart#L128)

- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)

<br />

***
<br />

## [v0.3.0](https://github.com/haolun1996/baseX/releases/tag/0.3.0) - 2025-01-07
- Changes
    - Update [flutter_version](https://github.com/haolun1996/baseX/blob/1d4dd8214531ca5e1c3ea5e725e823c0794a7fc5/pubspec.yaml#L10) to 3.27.x
    - Update [related plugin]((https://github.com/haolun1996/baseX/blob/main/pubspec.yaml)) to latest version
    - Add [topSafeArea and bottomSafeArea](https://github.com/haolun1996/baseX/blob/1d4dd8214531ca5e1c3ea5e725e823c0794a7fc5/lib/Core/x_base_widget.dart#L17-L18) to replace safeArea to be more flexible
    - Mark [safeArea](https://github.com/haolun1996/baseX/blob/1d4dd8214531ca5e1c3ea5e725e823c0794a7fc5/lib/Core/x_base_widget.dart#L15) to be deprecated and will remove in next version
    - [Open Map](https://github.com/haolun1996/baseX/blob/main/lib/x_widget/x_open_map.dart) Feature for app [Google Map](https://github.com/haolun1996/baseX/blob/1d4dd8214531ca5e1c3ea5e725e823c0794a7fc5/lib/x_widget/x_open_map.dart#L22), [Apple Map](https://github.com/haolun1996/baseX/blob/1d4dd8214531ca5e1c3ea5e725e823c0794a7fc5/lib/x_widget/x_open_map.dart#L34), [Waze](https://github.com/haolun1996/baseX/blob/1d4dd8214531ca5e1c3ea5e725e823c0794a7fc5/lib/x_widget/x_open_map.dart#L46), [default platform](https://github.com/haolun1996/baseX/blob/1d4dd8214531ca5e1c3ea5e725e823c0794a7fc5/lib/x_widget/x_open_map.dart#L10) Map and [Map Selection List](https://github.com/haolun1996/baseX/blob/1d4dd8214531ca5e1c3ea5e725e823c0794a7fc5/lib/x_widget/x_open_map.dart#L108) which app installed on device
    - [Social Login](https://github.com/haolun1996/baseX/blob/main/lib/controller/social_login_service.dart) Feature for [Google](https://github.com/haolun1996/baseX/blob/1d4dd8214531ca5e1c3ea5e725e823c0794a7fc5/lib/controller/social_login_service.dart#L54) Login, [Apple](https://github.com/haolun1996/baseX/blob/1d4dd8214531ca5e1c3ea5e725e823c0794a7fc5/lib/controller/social_login_service.dart#L87) Login(iOS, macOS) and [Facebook](https://github.com/haolun1996/baseX/blob/1d4dd8214531ca5e1c3ea5e725e823c0794a7fc5/lib/controller/social_login_service.dart#L21) Login

- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)

<br />

***
<br />

## [v0.2.8](https://github.com/haolun1996/baseX/releases/tag/0.2.8) - 2024-06-11
- Changes
    - Update [flutter_version](https://github.com/haolun1996/baseX/blob/main/pubspec.yaml) to 3.22.2
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.2.7](https://github.com/haolun1996/baseX/releases/tag/0.2.7) - 2023-11-14
- Changes
    - Add [DrawerAction](https://github.com/haolun1996/baseX/blob/main/lib/model/ui/drawer_action.dart) and [FloatingAction](https://github.com/haolun1996/baseX/blob/main/lib/model/ui/floating_action.dart) to [part of library](https://github.com/haolun1996/baseX/blob/3618639b184ef496c1419e1a3c81af44c4dbe34c/lib/model/index.dart#L13-L14) of model
    - Obtain more accurate iPhone [device model](https://github.com/haolun1996/baseX/blob/3618639b184ef496c1419e1a3c81af44c4dbe34c/lib/controller/x_controller.dart#L36) using library [ios_utsname_ext](https://pub.dev/packages/ios_utsname_ext)
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.2.6](https://github.com/haolun1996/baseX/releases/tag/0.2.6) - 2023-11-01
- Changes
    - show [MultipartFile](https://github.com/haolun1996/baseX/blob/25e26d2befa816f984fc46eae8a4751ab9f780a9/lib/base_x.dart#L25) from export of dio
    - XPicker widget
        - added [XPickerItem](https://github.com/haolun1996/baseX/blob/main/lib/model/picker_item_x.dart)
        - [Restructure](https://github.com/haolun1996/baseX/blob/main/lib/x_widget/x_picker.dart)
    - add new lint of [use_string_in_part_of_directives for error](https://github.com/haolun1996/baseX/blob/f6c3a34beadc28a98af9244750dbf05893148898/lib/x_lint/x_lint.yaml#L53)
    - All part of library to 'index.dart' eg: [part of 'index.dart';](https://github.com/haolun1996/baseX/blob/f6c3a34beadc28a98af9244750dbf05893148898/lib/model/data_x.dart#L1)
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.2.5](https://github.com/haolun1996/baseX/releases/tag/0.2.5) - 2023-10-24
- Changes
    - hide [MultipartFile](https://github.com/haolun1996/baseX/blob/62707651a3bb248eed29b0b1a88241d654cfcfc6/lib/base_x.dart#L23) from export of getX
    - XCachedImage widget
        - deprecated [borderRadius](https://github.com/haolun1996/baseX/blob/62707651a3bb248eed29b0b1a88241d654cfcfc6/lib/x_widget/x_cached_image.dart#L19) with message "Use BoxDecaration instead"
        - add [ClipBehaviour](https://github.com/haolun1996/baseX/blob/62707651a3bb248eed29b0b1a88241d654cfcfc6/lib/x_widget/x_cached_image.dart#L189) to container on XCacheImage
    - add new lint of [prefer_adjacent_string_concatenation](https://github.com/haolun1996/baseX/blob/62707651a3bb248eed29b0b1a88241d654cfcfc6/lib/x_lint/x_lint.yaml#L32) for [error](https://github.com/haolun1996/baseX/blob/62707651a3bb248eed29b0b1a88241d654cfcfc6/lib/x_lint/x_lint.yaml#L52)
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.2.4](https://github.com/haolun1996/baseX/releases/tag/0.2.4) - 2023-10-20
- Bug Fixes
    - put [code](https://github.com/haolun1996/baseX/blob/f009c67d70c4c5b29e9ac89baa30affe662c1567/lib/api_service/api_interceptor.dart#L51-L55) optional function paramter to last
- Changes
    - Update [flutter_lints](https://github.com/haolun1996/baseX/blob/f009c67d70c4c5b29e9ac89baa30affe662c1567/pubspec.yaml#L32C3-L32C16) to 3.0.0
    - export Class or Function ONLY from main class
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.2.3](https://github.com/haolun1996/baseX/releases/tag/0.2.3) - 2023-10-10
- Changes
    - Update [GetX](https://github.com/haolun1996/baseX/blob/912e4e3cb15380450f8a2c609dcd11a973f0e1d1/pubspec.yaml#L22) version to 4.6.6
    - add life cycle [onHidden()](https://github.com/haolun1996/baseX/blob/912e4e3cb15380450f8a2c609dcd11a973f0e1d1/lib/Core/x_base_controller.dart#L69-L74)
    - [export](https://github.com/haolun1996/baseX/blob/912e4e3cb15380450f8a2c609dcd11a973f0e1d1/lib/base_x.dart#L10) GetX to have same version on dependency
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.2.2](https://github.com/haolun1996/baseX/releases/tag/0.2.2) - 2023-09-25
- Bug Fixes
    - [XLoggerInterceptors](https://github.com/haolun1996/baseX/blob/main/lib/api_service/api_logger_interceptor.dart) will directly intercep on API request instead of Logger purpose
        - [onRequest](https://github.com/haolun1996/baseX/blob/fd5d2e94e2c85ca995d1fcca33d21877eafc2431/lib/api_service/api_logger_interceptor.dart#L61)
        - [onError](https://github.com/haolun1996/baseX/blob/fd5d2e94e2c85ca995d1fcca33d21877eafc2431/lib/api_service/api_logger_interceptor.dart#L83)
        - onResponse
            - [success200](https://github.com/haolun1996/baseX/blob/fd5d2e94e2c85ca995d1fcca33d21877eafc2431/lib/api_service/api_logger_interceptor.dart#L105)
            - [Not success200](https://github.com/haolun1996/baseX/blob/fd5d2e94e2c85ca995d1fcca33d21877eafc2431/lib/api_service/api_logger_interceptor.dart#L115)
- Changes
    - add "kDebugMode" to dio [baseUrl](https://github.com/haolun1996/baseX/blob/fd5d2e94e2c85ca995d1fcca33d21877eafc2431/lib/api_service/api.dart#L35) for handling endpoint purpose between debug for uatBaseUrl and release for baseUrl for both mode
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.2.1](https://github.com/haolun1996/baseX/releases/tag/0.2.1) - 2023-08-15
- Bug Fixes
    - status code >= 200 should check with status(true | false) at [api_interceptor](https://github.com/haolun1996/baseX/blob/3a16cab9e221aedd22afa3ffe4523be8f5383eff/lib/api_service/api_interceptor.dart#L86) and [api_logger_interceptor](https://github.com/haolun1996/baseX/blob/3a16cab9e221aedd22afa3ffe4523be8f5383eff/lib/api_service/api_logger_interceptor.dart#L90)

- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.2.0](https://github.com/haolun1996/baseX/releases/tag/0.2.0) - 2023-08-15
- New
    - [DefaultBaseXHttp](https://github.com/haolun1996/baseX/blob/1c724f1b1282603eead9e4652ccf6ee95026fc5c/lib/api_service/http_type_x.dart#L3) class added as abstract class cannot be declared 
- Changes
    - http code status > 200 to status >= 200 if required200 set to true at [api_interceptor](https://github.com/haolun1996/baseX/blob/1c724f1b1282603eead9e4652ccf6ee95026fc5c/lib/api_service/api_interceptor.dart#L86) and [api_logger_interceptor](https://github.com/haolun1996/baseX/blob/1c724f1b1282603eead9e4652ccf6ee95026fc5c/lib/api_service/api_logger_interceptor.dart#L90)
    - required200 set to [false](https://github.com/haolun1996/baseX/blob/1c724f1b1282603eead9e4652ccf6ee95026fc5c/lib/Core/x_get_app.dart#L45C8-L45C19) as default
    - [DefaultBaseXHttp](https://github.com/haolun1996/baseX/blob/1c724f1b1282603eead9e4652ccf6ee95026fc5c/lib/Core/x_get_app.dart#L90) declared as default

- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.1.7](https://github.com/haolun1996/baseX/releases/tag/0.1.6) - 2023-07-31
- Bug Fixes
    - c.page is null
    
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.1.6](https://github.com/haolun1996/baseX/releases/tag/0.1.6) - 2023-07-31
- Remove
    - Remove all firebase related
    
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.1.5](https://github.com/haolun1996/baseX/releases/tag/0.1.5) - 2023-07-31
- Bug Fixes
    - check page [runtimeType](https://github.com/haolun1996/baseX/blob/a2701d8b000555ea8969b30182bdecc299600b7a/lib/Core/x_base_widget.dart#L108C5-L122C1) is not integer/double/string/bool
    - handle if code != 40000 when request http 400, possible when http 400 then code have other than [40000](https://github.com/haolun1996/baseX/blob/a2701d8b000555ea8969b30182bdecc299600b7a/lib/api_service/mixin_api_interceptor.dart#L14C9-L26C10)
    
- New
    - reversed [stacked appbar](https://github.com/haolun1996/baseX/blob/a2701d8b000555ea8969b30182bdecc299600b7a/lib/Core/x_base_widget.dart#L147C1-L149C52)
- Changes
    - change iosinfo.model  to [iosinfo.utsname.machine](https://github.com/haolun1996/baseX/blob/a2701d8b000555ea8969b30182bdecc299600b7a/lib/controller/x_controller.dart#L34)
- On Going
    
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.1.4](https://github.com/haolun1996/baseX/releases/tag/0.1.4) - 2023-07-31
- Bug Fixes
    
- New
    
- Changes
    - update plugin to latest version in [pubspec.yaml](https://github.com/haolun1996/baseX/blob/53fbf4cd4de139d8b965fe5454a98071aca567b0/pubspec.yaml#L19C3-L19C39)
- On Going
    
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.1.3](https://github.com/haolun1996/baseX/releases/tag/0.1.3) - 2023-06-28
- Bug Fixes
    - change [defaultLangController](https://github.com/haolun1996/baseX/blob/04383ed5086f31c4660b67e5502669e3bb96d888/lib/Core/x_get_app.dart#L14) to nullable instead of late affected on
        - [xtr](https://github.com/haolun1996/baseX/blob/04383ed5086f31c4660b67e5502669e3bb96d888/lib/Core/x_extension.dart#L30)
        - [lr](https://github.com/haolun1996/baseX/blob/04383ed5086f31c4660b67e5502669e3bb96d888/lib/Core/x_extension.dart#L34C9-L34C9)
        - header api [ApiInterceptors](https://github.com/haolun1996/baseX/blob/04383ed5086f31c4660b67e5502669e3bb96d888/lib/api_service/api_interceptor.dart#L13) &
        [XLoggerInterceptors](https://github.com/haolun1996/baseX/blob/04383ed5086f31c4660b67e5502669e3bb96d888/lib/api_service/api_logger_interceptor.dart#L13)
- New
    - [uploadProgress & downloadProgress](https://github.com/haolun1996/baseX/blob/04383ed5086f31c4660b67e5502669e3bb96d888/lib/api_service/api.dart#L138C1-L139C41) at POST request to retrive download and upload information from dio
- Changes

- On Going
    
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.1.2](https://github.com/haolun1996/baseX/releases/tag/0.1.2) - 2023-06-06
- New
    - [onBack & onBackButton](https://github.com/haolun1996/baseX/blob/8246bdcc91f81614060b84f13518e3d49ea603e4/lib/Core/x_base_controller.dart#LL86C1-L96C4) to split out onBack use on WillPopScope and normal usage back
- Changes

- On Going
    
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.1.1](https://github.com/haolun1996/baseX/releases/tag/0.1.1) - 2023-06-01
- New
    - [Hide envBar when on nested page](https://github.com/haolun1996/baseX/blob/ae846ddfcb5f2dbb2464a8fddd3dc5dba8b6fa89/lib/Core/x_base_widget.dart#LL103C1-L107C6)
    - [Skeleton Widget List](https://github.com/haolun1996/baseX/blob/8443adceb25fc877127c59e36dd10b7b48ce41ea/lib/x_widget/x_skeleton.dart#LL115C2-L129C4)
- Changes

- On Going
    
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.1.0](https://github.com/haolun1996/baseX/releases/tag/0.1.0) - 2023-05-31
- Pump version to v0.1.0 as follow Semantic Versioning with MAJOR.MINOR.PATCH
    - MAJOR - Breaking change / restructure
    - MINOR - New feature / component
    - PATCH - Small Request / bug fix on existing feature or component
- New
    - Skeleton Widget named as [XSkeleton](https://github.com/haolun1996/baseX/blob/main/lib/x_widget/x_skeleton.dart) for round / square / ascpectratio
    - Image Widget named as [XcachedImage](https://github.com/haolun1996/baseX/blob/main/lib/x_widget/x_cached_image.dart)
        - error / placeholder / image builder
        - with skeleton when loading (optional)
    - Added none enum value to [Position](https://github.com/haolun1996/baseX/blob/e90c6a62feef99e6ea5b819f3703cac654c5074e/lib/Core/x_constant.dart#L14) for hiding envBar
    - Added className param on x_logger class in [warning / info / success / error](https://github.com/haolun1996/baseX/blob/e90c6a62feef99e6ea5b819f3703cac654c5074e/lib/Core/x_logger.dart#L24) method
- Changes
    - put kDebugMode to print
    - bool hasDrawer and hasFloatingButton moved to [BaseXController](https://github.com/haolun1996/baseX/blob/e90c6a62feef99e6ea5b819f3703cac654c5074e/lib/Core/x_base_controller.dart#LL17C1-L21C32) from BaseXWidget
    - Wrapped [Obx on Scaffold](https://github.com/haolun1996/baseX/blob/e90c6a62feef99e6ea5b819f3703cac654c5074e/lib/Core/x_base_widget.dart#LL195C14-L195C14) to listen changes of hasDrawer and hasFloatingButton
    - Rename x_pretty_logger to [x_logger](https://github.com/haolun1996/baseX/blob/main/lib/Core/x_logger.dart)
    - Changed FloatingActionButton to Widget in [FloatingAction](https://github.com/haolun1996/baseX/blob/main/lib/model/ui/floating_action.dart) UI model to be more customization

- On Going
    - Hide envBar when on nested page
    
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.0.5](https://github.com/haolun1996/baseX/releases/tag/0.0.5) - 2023-05-24
- Completed
    - Bug Fixes
        - [throw use wrong widget parent due to expanded did'nt put to normal page view](https://github.com/haolun1996/baseX/blob/596c7cb479f79a47109bee2c12d2a187c34dd35f/lib/Core/x_base_widget.dart#LL116C15-L126C17)
    - Changes
        - [put warning to print if did'nt remove on production](https://github.com/haolun1996/baseX/blob/596c7cb479f79a47109bee2c12d2a187c34dd35f/lib/x_lint/x_lint.yaml#LL5C1-L5C22)
- On Going
    
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.0.4](https://github.com/haolun1996/baseX/releases/tag/0.0.4) - 2023-05-23
- Completed
    - BaseX Scaffold Enhancement
        - [Drawer and floating icon can be pass into baseX scaffold for customization](https://github.com/haolun1996/baseX/blob/166788b3f466fe6fd99b46248cf4aa0f7342d033/lib/Core/x_base_widget.dart#LL202C7-L218C74)
    - New Added Model
        - [Drawer Action](https://github.com/haolun1996/baseX/blob/main/lib/model/ui/drawer_action.dart)
        - [FloatingAction](https://github.com/haolun1996/baseX/blob/main/lib/model/ui/floating_action.dart)
    - [Stacked appbar with body(experimental)](https://github.com/haolun1996/baseX/blob/cdcb65b8a8fa42da28f7cf1b4c26f8fb5fa3ff74/lib/Core/x_base_widget.dart#LL116C13-L153C17)
- On Going
    
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.0.3](https://github.com/haolun1996/baseX/releases/tag/0.0.3) - 2023-05-16
- Completed
    - [Migrate Flutter Version v3.10.0](https://github.com/haolun1996/baseX/pubspec.yaml)
    - [iOS Gesture Slide Back](https://github.com/haolun1996/baseX/lib/Core/x_base_widget.dart) -> Slide from left screen to right to go back last page
- On Going
    
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.0.2](https://github.com/haolun1996/baseX/releases/tag/0.0.2) - 2023-02-22
- Completed
    - [Api Service](https://github.com/haolun1996/baseX/tree/main/lib/api_service)
    - [XController](https://github.com/haolun1996/baseX/blob/main/lib/controller/x_controller.dart)
    - [Core with](https://github.com/haolun1996/baseX/tree/main/lib/Core)
        - [BaseXController<T\>](https://github.com/haolun1996/baseX/blob/main/lib/Core/x_base_controller.dart)
        - [BaseXWidget<T\>](https://github.com/haolun1996/baseX/blob/main/lib/Core/x_base_controller.dart)
        - [runXApp](https://github.com/haolun1996/baseX/blob/main/lib/Core/x_get_app.dart)
        - [XNavigation](https://github.com/haolun1996/baseX/blob/main/lib/Core/x_navigation.dart)
        - [BaseXSharePref](https://github.com/haolun1996/baseX/blob/main/lib/Core/x_share_pref.dart)
            -> Abstract class interface
    - [Scroll Behaviour](https://github.com/haolun1996/baseX/blob/main/lib/helper/scroll_behaviour.dart)
        -> hideScrollShadow(Widget) method to hide on Mobile Scrolling Shadow
    - [Drop Down Picker with <T\>](https://github.com/haolun1996/baseX/blob/main/lib/x_widget/x_picker.dart)
    - [XTranslation in Language Controller with <T\> <K\>](https://github.com/haolun1996/baseX/blob/main/lib/controller/x_lang_controller.dart)
    - [XLint](https://github.com/haolun1996/baseX/blob/main/lib/x_lint/x_lint.yaml)
        -> Custom lint 
- On Going
    
- TODO
    - API Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login

<br />

***
<br />

## [v0.0.1](https://github.com/haolun1996/baseX/releases/tag/0.0.1) - 2023-02-17
- Completed
    - [Api Service](https://github.com/haolun1996/baseX/tree/main/lib/api_service)
    - [XController](https://github.com/haolun1996/baseX/blob/main/lib/controller/x_controller.dart)
    - [Core with](https://github.com/haolun1996/baseX/tree/main/lib/Core)
        - [BaseXController<T\>](https://github.com/haolun1996/baseX/blob/main/lib/Core/x_base_controller.dart)
        - [BaseXWidget<T\>](https://github.com/haolun1996/baseX/blob/main/lib/Core/x_base_controller.dart)
        - [runXApp](https://github.com/haolun1996/baseX/blob/main/lib/Core/x_get_app.dart)
        - [XNavigation](https://github.com/haolun1996/baseX/blob/main/lib/Core/x_navigation.dart)
        - [BaseXSharePref](https://github.com/haolun1996/baseX/blob/main/lib/Core/x_share_pref.dart)
            -> Abstract class interface
    - [Scroll Behaviour](https://github.com/haolun1996/baseX/blob/main/lib/helper/scroll_behaviour.dart)
        -> hideScrollShadow(Widget) method to hide on Mobile Scrolling Shadow
- On Going
    - [Drop Down Picker with <T/>](https://github.com/haolun1996/baseX/blob/main/lib/Core/x_widget.dart)
- TODO
    - XTranslation
    - APi Caching
    - Endpoint Changing Method
    - Check Permission for Android(12/13)
    - Social Login