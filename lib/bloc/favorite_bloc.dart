import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repositories/database_repository.dart';

class FavoriteList extends Equatable {
  const FavoriteList({this.favoriteList = const <dynamic>[]});

  final List<dynamic> favoriteList;

  @override
  List<Object?> get props => [favoriteList];
}

class FavoriteBloc extends Cubit<List<dynamic>> {
  FavoriteBloc({
    required this.databaseRepository,
  }) : super(<dynamic>[]) {
    _streamSubscription =
        databaseRepository.favoriteProductStream.listen((event) {
          _favorites = FavoriteList(favoriteList: event);
          emit(_favorites.favoriteList);
        });
  }

  late StreamSubscription<List<dynamic>> _streamSubscription;
  final DatabaseRepository databaseRepository;
  FavoriteList _favorites = const FavoriteList();

  void removeDoc(String documentID) {
    print("data removed");
    _favorites.favoriteList.remove(documentID);
    emit([..._favorites.favoriteList]);
  }

  void addDoc(String documentID) {
    print("data added");
    _favorites.favoriteList.add(documentID);
    emit([..._favorites.favoriteList]);
  }
}
