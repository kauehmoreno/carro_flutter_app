import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Event{
  String action;
  String identifier;
}

class EventBus{

  // broadcast permite que a stream seja ouvida mais deu ma vez
  final _streamCtrl  = StreamController<Event>.broadcast();

  Stream<Event> get stream => _streamCtrl.stream;

  sendEvent(Event event) => _streamCtrl.add(event);
  dispose() => _streamCtrl.close();

  static EventBus getEvent(BuildContext ctx) => Provider.of<EventBus>(ctx, listen: false);
}