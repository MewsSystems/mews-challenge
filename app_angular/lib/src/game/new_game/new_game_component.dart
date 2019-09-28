import 'package:angular/angular.dart';
import 'package:core/core.dart';

@Component(
  selector: 'new-game',
  template: '<div class="loader">Loading...</div>',
)
class NewGameComponent implements OnInit {
  NewGameComponent(this._gameService, this._authService);

  final GameService _gameService;
  final AuthService _authService;

  @Input()
  String gameId;

  @override
  void ngOnInit() {
    _gameService.startGame(_authService.currentUser.uid, gameId);
  }
}
