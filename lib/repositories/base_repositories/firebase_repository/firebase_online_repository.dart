import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:galaxy/repositories/base_repositories/base_online_repository.dart';
import 'package:galaxy/repositories/base_repositories/repository_states.dart';

abstract class FirebaseOnlineRepository<ObjectType>
    extends BaseOnlineRepository<String, ObjectType> {
  @override
  Future<RepositoryState> fetchItem() async {
    Completer<RepositoryState> completer = new Completer<RepositoryState>();
    String url = getUrl();
    FirebaseDatabase.instance
        .reference()
        .child(url)
        .onValue
        .handleError((onError) {
      completer.complete(new SyncDataFailureState(onError.message));
    }).listen((Event event) {
      final data = getObject(event.snapshot.value.cast<String, dynamic>()); 
      completer.complete(new SyncDataSucceedState(data));
    });
    return completer.future;
  }

  @override
  Future<RepositoryState> fetchList() {
    Completer<RepositoryState> completer = new Completer<RepositoryState>();
    String url = getUrl();
    FirebaseDatabase.instance
        .reference()
        .child(url)
        .onValue
        .handleError((onError) {
      completer.complete(new SyncDataFailureState(onError.message));
    }).listen((Event event) {
      List<dynamic> l = event.snapshot.value;
      final data =
          l.map((item) => getObject(item.cast<String, dynamic>())).toList();
      completer.complete(new SyncDataSucceedState(data));
    });

    return completer.future;
  }

  @override
  void pushData(Object data) {
    // TODO: implement pushData
  }
 
 
}
