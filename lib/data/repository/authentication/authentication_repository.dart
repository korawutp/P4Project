import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workproject/data/repository/user/user_repository.dart';
import 'package:workproject/features/authentication/screens/login/login.dart';
import 'package:workproject/features/authentication/screens/onboarding/onboarding.dart';
import 'package:workproject/features/authentication/screens/signup/verify_email.dart';
import 'package:workproject/features/navigationmenu/navigation_menu.dart';
import 'package:workproject/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:workproject/utils/exceptions/format_exceptions.dart';
import 'package:workproject/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  /// Called from main.dart on app launch
  @override
  void onReady() {
    // Remove the native splash screen
    FlutterNativeSplash.remove();
    // Redirect to the appropriate screen
    screenRedirect();
  }

  /// Function to show Relevent Screen
  screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      // Local Storage
      deviceStorage.writeIfNull('IsFirstTime', true);
      // Check if it's the first time launching the app
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnBoardingScreen());
    }
  }

/* ----------------------------- Email & Password sign in --------------------------------*/

  /// [EmailAuthentication] - LOGIN
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFormatException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFormatException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailVerification] - VERIFY EMAIL
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFormatException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFormatException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [ReAuthenticate] - Re-Authenticate User
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      // Create a new credential
      AuthCredential credentials = EmailAuthProvider.credential(email: email, password: password);

      // Re-Authenticate
      await _auth.currentUser!.reauthenticateWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFormatException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

/* ----------------------------- Federated identity & social sign in --------------------------------*/

  /// [GoogleAuthentication] - GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the auth details from request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      // Create a new credential
      final credentials =
          GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFormatException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }

  /// [FacebookAuthentication] - FACEBOOK

/* ----------------------------- ./end Federated identity & social sign in --------------------------------*/

  /// [LogoutUser] - Valid for any authentication.
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFormatException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [DeleteUser] - Remove user Auth and Firestore Account.
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
      await GoogleSignIn().signOut();
    } on FirebaseAuthException catch (e) {
      throw MyAppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyAppFormatException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
