import 'dart:io';

import 'package:baseX/base_x.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

const int CANCELLED = 10001;
const int IN_PROGRESS = 10002;
const int NETWORK_ERROR = 10003;
const int FAILED = 10009;
const int UNKNOWN = 404;

const List<String> scopes = <String>[
  'email',
  // 'https://www.googleapis.com/auth/contacts.readonly',
];

mixin SocialLogin {
  Future<(String, SocialData)?> loginFacebook(OnFail onfailed) async {
    final accessToken = await FacebookAuth.instance.accessToken;

    if (accessToken != null) {
      await FacebookAuth.instance.logOut();
    }

    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;

      final userData = await FacebookAuth.instance.getUserData();
      XLogger.success('Facebook has logged in');

      return (
        accessToken.tokenString,
        SocialData.facebook(
            userData['id'], userData['name'], userData['email'], userData['picture']['data']['url'])
      );
    } else if (result.status == LoginStatus.cancelled) {
      onfailed(CANCELLED, result.message!, null);
    } else if (result.status == LoginStatus.operationInProgress) {
      onfailed(IN_PROGRESS, result.message!, null);
    } else if (result.status == LoginStatus.failed) {
      onfailed(FAILED, result.message!, null);
    } else {
      onfailed(UNKNOWN, 'Unknown error', null);
      return null;
    }
    return null;
  }

  Future<(String, SocialData)?> loginGoogle(OnFail onfailed) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: scopes);

    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }

    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleAuth = await googleSignInAccount?.authentication;

      if (googleSignInAccount != null && googleAuth != null) {
        return (
          googleAuth.accessToken!,
          SocialData.google(googleSignInAccount.id, googleSignInAccount.displayName ?? '',
              googleSignInAccount.email, googleSignInAccount.photoUrl ?? '')
        );
      }
    } on PlatformException catch (e) {
      if (e.code == GoogleSignIn.kNetworkError) {
        onfailed(NETWORK_ERROR, e.message!, null);
      } else if (e.code == GoogleSignIn.kSignInCanceledError) {
        onfailed(CANCELLED, e.message!, null);
      } else if (e.code == GoogleSignIn.kSignInFailedError) {
        onfailed(FAILED, e.message!, null);
      } else {
        onfailed(UNKNOWN, 'Unknown error', null);
      }
      return null;
    }
    return null;
  }

  Future<(String, SocialData)?> loginApple(OnFail onfailed) async {
    if (Platform.isIOS || Platform.isMacOS) {
      try {
        AuthorizationCredentialAppleID credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        return (
          credential.identityToken!,
          SocialData.apple(credential.userIdentifier ?? '', credential.familyName ?? '',
              credential.email ?? '', '')
        );
      } on SignInWithAppleAuthorizationException catch (e) {
        if (e.code == AuthorizationErrorCode.notInteractive) {
          onfailed(NETWORK_ERROR, e.message, null);
        } else if (e.code == AuthorizationErrorCode.canceled) {
          onfailed(CANCELLED, 'Cancelled', null);
        } else if (e.code == AuthorizationErrorCode.failed) {
          onfailed(FAILED, e.message, null);
        } else {
          onfailed(UNKNOWN, 'Unknown error', null);
        }
        return null;
      }
    } else {
      onfailed(-1, 'Not implementing Apple Sign In other than iOS and macOS', null);
      throw UnimplementedError('Not implementing Apple Sign In other than iOS and macOS');
    }
  }
}
