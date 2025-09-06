
class Notification {
  late String message;
  late DateTime timestamp;
  Notification(this.message, this.timestamp);
  Notification.forNow(this.message) {
    timestamp = DateTime.now();
  }
}

class Observable {
  late List<Observer> _observers;

  Observable([List<Observer>? observers]) {
    _observers = observers ?? [];
  }

  void registerObserver(Observer observer) {
    _observers.add(observer);
  }

  void notify_observers(Notification notification) {
    for (var observer in _observers) {
      observer.notify(notification);
    }
  }
}

class Observer {
  late String name;

  Observer(this.name);

  void notify(Notification notification) {
    print(
        "[${notification.timestamp.toIso8601String()}] Hey $name, ${notification.message}!");
  }
}

class CoffeeMaker extends Observable {
  CoffeeMaker([super.observers]);
  void brew() {
    print("Brewing the coffee...");
    notify_observers(Notification.forNow("coffee's done"));
  }
}

// void main() {
//   var me = Observer("Tyler");
//   var mrCoffee = CoffeeMaker(List.from([me]));
//   var myWife = Observer("Kate");
//   mrCoffee.registerObserver(myWife);
//   mrCoffee.brew();
//   /*
//     Brewing the coffee...
//     [2019-06-18T07:30:04.397518] Hey Tyler, coffee's done!
//     [2019-06-18T07:30:04.397518] Hey Kate, coffee's done!
//   */
// }


abstract class State {
  void handler(Stateful context);
  @override
  String toString();
}

class StatusOn implements State {
  @override
  handler(Stateful context) {
    print("  Handler of StatusOn is being called!");
    context.state = StatusOff();
  }

  @override
  String toString() {
    return "on";
  }
}

class StatusOff implements State {
  @override
  handler(Stateful context) {
    print("  Handler of StatusOff is being called!");
    context.state = StatusOn();
  }

  @override
  String toString() {
    return "off";
  }
}

class Stateful {
  State _state;

  Stateful(this._state);

  State get state => _state;
  set state(State newState) => _state = newState;

  void touch() {
    print("  Touching the Stateful...");
    _state.handler(this);
  }
}

void main() {
  var lightSwitch = Stateful(StatusOff());
  print("The light switch is ${lightSwitch.state}.");
  print("Toggling the light switch...");
  lightSwitch.touch();
  print("The light switch is ${lightSwitch.state}.");
}