import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:core/core.dart';

@Component(
  selector: 'logout',
  templateUrl: 'logout_component.html',
  styleUrls: ['logout_component.css'],
  directives: [MaterialButtonComponent, MaterialIconComponent],
)
class LogoutComponent {
  LogoutComponent(this._authService);

  final AuthService _authService;

  void logout() {
    _authService.logout();
    onClose();
  }

  @Input()
  void Function() onClose;

  void close() {
    onClose();
  }
}
