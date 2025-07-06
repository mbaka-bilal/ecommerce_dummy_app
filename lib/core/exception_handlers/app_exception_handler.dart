import '../constants/strings.dart';
import 'exception_types.dart';

class AppExceptionHandler {
  static String handleException(Object e) {
    switch (e.runtimeType) {
      case AppException:
        return (e as AppException).message ?? AppStrings.unknownError;
      case NetworkException:
        return (e as NetworkException).message;
      case UnknownException:
        return (e as UnknownException).message;
      case NoUserLoggedInException:
        return (e as NoUserLoggedInException).message;
      case FirebaseError:
        return (e as FirebaseError).message;
      default:
        return AppStrings.unknownError;
    }
  }
}
