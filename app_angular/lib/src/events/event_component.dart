import 'package:angular/angular.dart';
import 'package:angular/security.dart';
import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/events/route_paths.dart';
import 'package:app_angular/src/game/game_list/game_list_component.dart';
import 'package:core/core.dart';

@Component(
  selector: 'event',
  templateUrl: 'event_component.html',
  directives: [GameListComponent, NgIf],
)
class EventComponent implements OnActivate {
  EventComponent(this._eventService, this._sanitizationService);

  final EventService _eventService;
  final DomSanitizationService _sanitizationService;

  String eventId;

  Event event;

  SafeHtml winnersDescription;

  @override
  void onActivate(RouterState previous, RouterState current) {
    eventId = current.parameters[eventIdParam];
    _eventService.getEvent(eventId).then((e) {
      event = e;
      winnersDescription = event.winnersDescription == null
          ? null
          : _sanitizationService
              .bypassSecurityTrustHtml(event.winnersDescription);
    });
  }
}
