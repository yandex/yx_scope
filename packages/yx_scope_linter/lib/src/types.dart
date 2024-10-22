import 'package:custom_lint_builder/custom_lint_builder.dart';

const baseScopeContainerType = TypeChecker.fromName(
  'BaseScopeContainer',
  packageName: 'yx_scope',
);

const depValueType = TypeChecker.fromName(
  'Dep',
  packageName: 'yx_scope',
);
const asyncDepValueType = TypeChecker.fromName(
  'AsyncDep',
  packageName: 'yx_scope',
);

const asyncLifecycleType = TypeChecker.fromName(
  'AsyncLifecycle',
  packageName: 'yx_scope',
);

const anyDepValueTypes = TypeChecker.any([depValueType, asyncDepValueType]);
