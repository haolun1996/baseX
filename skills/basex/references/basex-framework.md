# baseX Framework Reference

This document provides detailed documentation for the baseX framework used in this project.

**Repository:** https://github.com/haolun1996/baseX  
**Version:** 0.8.0

## Overview

baseX is a private Flutter framework built on top of GetX (v4.7.3) and Dio (v5.11.1) that provides standardized patterns for API services, navigation, UI components, and authentication.

## Core Architecture

- Built on GetX for state management and dependency injection
- Dio-based HTTP client with interceptors and logging
- Base classes for structured development: `BaseXController<T>`, `BaseXWidget<T>`
- Navigation wrapper: `XNavigation`
- Shared preferences abstraction
- Custom lint rules: `XLint` (used via `package:baseX/x_lint/x_lint.yaml`)

## UI Components

- `XSkeleton` - Loading state placeholders
- `XCachedImage` - Optimized image loading with caching
- `XPicker` - Dropdown selection widget
- `KeyboardDismissOnTap` - Dismiss keyboard on tap gesture
- Customizable scaffold with drawer and FAB support

## Authentication

- Google Sign-In integration
- Apple Sign-In (iOS/macOS)
- Facebook Login

## Device & Platform

- HMS (Huawei Mobile Services) detection via `huawei_hmsavailability`
- GMS (Google Mobile Services) detection via `gms_check`
- Device info utilities (`device_info_plus`, `android_id`, `ios_utsname_ext`)
- Map launcher supporting multiple navigation apps

## API Features

- Environment-based base URLs (staging/live)
- Request/response interceptors with logging
- Custom header support (v0.6.0: `additionalHeader`)
- Error handling with `OnFail` callbacks

## Requirements

- Flutter >=3.47.7
- Dart SDK >=3.13.5 <4.0.0
