import 'dart:async';

import 'base_scope_container.dart';

mixin ScopeStateStreamable<Scope> on ScopeStateHolder<Scope> {
  Stream<Scope> get stream {
    late StreamController<Scope> controller;
    late RemoveStateListener removeStateListener;

    void onListen() {
      removeStateListener = listen((scope) {
        controller.add(scope);
      });
    }

    void onCancel() async {
      removeStateListener();
      await controller.close();
    }

    controller = StreamController<Scope>(
      onListen: onListen,
      onCancel: onCancel,
    );

    return controller.stream;
  }
}
