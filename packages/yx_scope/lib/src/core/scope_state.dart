enum ScopeState {
  none,
  initializing,
  available,
  disposing,
}

extension ScopeStateExt on ScopeState {
  bool get none => this == ScopeState.none;

  bool get available => this == ScopeState.available;
}
