import 'dart:async';

import 'package:test/test.dart';
import 'package:yx_scope/yx_scope.dart';

void main() {
  test('scope state is valid according to updates', () async {
    final scopeHolder = _TestScopeHolder();

    final createCompleter = Completer();
    final dropCompleter = Completer();

    expect(scopeHolder.state, ScopeState.none);
    expect(scopeHolder.state.none, isTrue);
    scopeHolder.create().then((_) => createCompleter.complete());

    expect(scopeHolder.state, ScopeState.initializing);
    expect(scopeHolder.state.initializing, isTrue);
    await createCompleter.future;

    expect(scopeHolder.state, ScopeState.available);
    expect(scopeHolder.state.available, isTrue);

    scopeHolder.drop().then((_) => dropCompleter.complete());

    expect(scopeHolder.state, ScopeState.disposing);
    expect(scopeHolder.state.disposing, isTrue);

    await dropCompleter.future;

    expect(scopeHolder.state, ScopeState.none);
    expect(scopeHolder.state.none, isTrue);
  });
}

class _TestScopeHolder extends ScopeHolder<_TestScopeContainer> {
  @override
  _TestScopeContainer createContainer() => _TestScopeContainer();
}

class _TestScopeContainer extends ScopeContainer {
  @override
  List<Set<AsyncDep>> get initializeQueue => [
        {_asyncDep}
      ];

  late final _asyncDep = rawAsyncDep(
    () => Future.delayed(Duration.zero),
    init: (dep) async => await dep,
    dispose: (dep) async {},
  );
}
