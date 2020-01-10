library memory_provider;

import 'dart:collection';

import 'package:flutter/material.dart';

abstract class StaticProvider {
  static ProviderData _providerData = new ProviderData();

  static T of<T extends StaticChangeNotifier>(BuildContext context) {
    String className = T.toString();

    List<BuildContext> list = _providerData.listeners
        .putIfAbsent(className, () => new List<BuildContext>());
    if (!list.contains(context)) list.add(context);

    return _providerData.instances[className];
  }

  static addProvider(StaticChangeNotifier provider) {
    String className = provider.runtimeType.toString();
    if (!_providerData.instances.containsKey(className)) {
      _providerData.listeners
          .putIfAbsent(className, () => new List<BuildContext>());
      _providerData.instances.putIfAbsent(className, () => provider);
    }
  }

  static disposeListeners<T extends StaticChangeNotifier>(
      BuildContext context) {
    _providerData.listeners[T.toString()].remove(context);
  }
}

class StaticChangeNotifier implements StaticProvider {
  notifyListeners() {
    StaticProvider._providerData.listeners[this.runtimeType.toString()]
        .forEach((c) => (c as StatefulElement).markNeedsBuild());
  }
}

class ProviderData {
  static ProviderData instance = ProviderData._internal();
  HashMap<String, List<BuildContext>> listeners;
  HashMap<String, StaticChangeNotifier> instances;

  ProviderData._internal() {
    listeners = new HashMap();
    instances = new HashMap();
  }
  factory ProviderData() {
    return instance;
  }
}