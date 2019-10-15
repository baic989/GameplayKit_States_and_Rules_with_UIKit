import UIKit
import GameplayKit
import PlaygroundSupport

extension Notification.Name {
    static let first = Notification.Name("first")
    static let second = Notification.Name("second")
    static let third = Notification.Name("third")
}

final class FirstState: GKState {

    weak var stateController: StateViewController?

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == SecondState.self
    }

    override func didEnter(from previousState: GKState?) {
        print("Entered \(FirstState.self)")
    }

    override func willExit(to nextState: GKState) {
        // Next
    }
}

final class SecondState: GKState {

    weak var stateController: StateViewController?

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == ThirdState.self
    }

    override func didEnter(from previousState: GKState?) {
        // Previous
    }

    override func willExit(to nextState: GKState) {
        // Next
    }
}

final class ThirdState: GKState {

    weak var stateController: StateViewController?

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == FirstState.self
    }

    override func didEnter(from previousState: GKState?) {
        // Previous
    }

    override func willExit(to nextState: GKState) {
        // Next
    }
}

final class FirstRule: GKRule {

}

final class SecondRule: GKRule {

}

final class ThirdRule: GKRule {

}

final class RuleSystem: GKRuleSystem {

}

final class StateMachine: GKStateMachine {

    let ruleSystem = RuleSystem()

    override init(states: [GKState]) {
        super.init(states: states)

        registerForEvents()
        setupRuleSystem()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func enterInitialState() {
        enter(FirstState.self)
    }

    private func setupRuleSystem() {



    }

    private func registerForEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(received(event:)), name: .first, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(received(event:)), name: .second, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(received(event:)), name: .third, object: nil)
    }

    @objc func received(event: Notification) {
        print(event.name)
    }
}

final class StateViewController: UIViewController {

    var stateMachine: StateMachine?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "State Controller"
        view.backgroundColor = .white

        setupStateMachine()
    }

    private func setupStateMachine() {

        let first = FirstState()
        first.stateController = self

        let second = SecondState()
        second.stateController = self

        let third = ThirdState()
        third.stateController = self

        stateMachine = StateMachine(states: [first, second, third])

        // Force first state
        stateMachine?.enterInitialState()
    }
}

let navigationController = UINavigationController(rootViewController: StateViewController())
PlaygroundPage.current.liveView = navigationController

NotificationCenter.default.post(Notification(name: .first))
NotificationCenter.default.post(Notification(name: .second))
NotificationCenter.default.post(Notification(name: .third))
NotificationCenter.default.post(Notification(name: .second))
NotificationCenter.default.post(Notification(name: .third))
NotificationCenter.default.post(Notification(name: .second))
