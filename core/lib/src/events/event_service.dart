import 'package:core/src/events/event.dart';
import 'package:firebase/firebase.dart';

class EventService {
  Future<Event> getEvent(String eventId) => firestore()
      .collection('events')
      .doc(eventId)
      .get()
      .then((s) => s.data())
      .then(Event.fromJson);
}
