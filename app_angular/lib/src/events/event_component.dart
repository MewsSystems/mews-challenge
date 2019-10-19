import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/events/route_paths.dart';
import 'package:app_angular/src/game/game_list/game_list_component.dart';

@Component(
  selector: 'event',
  template: '<game-list *ngIf="eventId != null" [eventId]="eventId"></game-list>',
  directives: [GameListComponent, NgIf],
)
class EventComponent implements OnActivate {
  String eventId;

  @override
  void onActivate(RouterState previous, RouterState current) {
    eventId = current.parameters[eventIdParam];
  }
}
