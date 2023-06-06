# Change Log

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