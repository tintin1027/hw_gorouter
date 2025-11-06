import 'package:flutter/foundation.dart';
import '../auth/authentication_bloc.dart';

class BlocGoRouterListenable extends ChangeNotifier {
  BlocGoRouterListenable(Stream<AuthState> stream) {
    stream.listen((_) => notifyListeners());
  }
}
