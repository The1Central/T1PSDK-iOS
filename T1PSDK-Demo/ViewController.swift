import T1PSDK
import UIKit

class ViewController: UIViewController {
    var redirectURL = ""
    var clientId = ""
    var debug = true

    let t1p = T1P()

    @IBOutlet private var clientIdTextField: UITextField!
    @IBOutlet private var environmentSegmentControl: UISegmentedControl!
    @IBOutlet private var languageSegmentControl: UISegmentedControl!
    @IBOutlet private var redirectUrlTextField: UITextField!
    @IBOutlet private var titleLabel: UILabel!

    @IBOutlet private var accountRecoveryButton: UIButton!
    @IBOutlet private var demoLoadingButton: UIButton!
    @IBOutlet private var getAccessTokenButton: UIButton!
    @IBOutlet private var initialButton: UIButton!
    @IBOutlet private var reloadButton: UIButton!
    @IBOutlet private var signInButton: UIButton!
    @IBOutlet private var signUpButton: UIButton!
    @IBOutlet private var signoutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

        initialButton.setTitle("Setup", for: .normal)
        signInButton.setTitle("Sign in", for: .normal)
        signUpButton.setTitle("Sign up", for: .normal)
        accountRecoveryButton.setTitle("Recovery", for: .normal)
        signoutButton.setTitle("Sign out", for: .normal)
        demoLoadingButton.setTitle("Loading View", for: .normal)
        titleLabel.text = "T1PSDK DEMO"

        redirectURL = redirectUrlTextField.text ?? ""
        clientId = clientIdTextField.text ?? ""

        enableTextField()
        disableButton()
        enableSegmentControl()
    }

    @IBAction private func didTapSignInButton() {
        let viewController = t1p.shared.signIn()
        present(viewController, animated: true, completion: nil)
    }

    @IBAction private func didTapSignUpButton() {
        let viewController = t1p.shared.signUp()
        present(viewController, animated: true, completion: nil)
    }

    @IBAction private func didTapAccountREcoveryButton() {
        let viewController = t1p.shared.accountRecovery()
        present(viewController, animated: true, completion: nil)
    }

    @IBAction private func didTapSignoutButton() {
        t1p.shared.signOut { _ in
            self.showAlert(title: "Signout", message: "success")
            self.reloadParameter()

        } onFailure: { error in
            self.showAlert(title: "Signout", message: error)
        }
    }

    @IBAction private func didTapInitialButton() {
        redirectURL = redirectUrlTextField.text ?? ""
        clientId = clientIdTextField.text ?? ""
        var language = t1p.shared.getLanguage()

        switch languageSegmentControl.selectedSegmentIndex {
        case 0:
            language = .thai
        case 1:
            language = .english
        default:
            break
        }

        var environment = T1PEnvironment.sit
        switch environmentSegmentControl.selectedSegmentIndex {
        case 0:
            environment = T1PEnvironment.sit
        case 1:
            environment = T1PEnvironment.uat
        case 2:
            environment = T1PEnvironment.pvt
        case 3:
            environment = T1PEnvironment.production
        default:
            break
        }

        self.t1p.shared.initialT1P(environment: environment,
                                   redirectUrl: redirectURL,
                                   clientId: clientId,
                                   language: language)
        let t1p = t1p
        t1p.delegate = self

        disableTextField()
        enableButton()
        disableSegmentControl()
    }

    @IBAction private func didTapDemoLoadingViewButton() {
        showLoadingViewDemo()
    }

    @IBAction private func didTapReloadButton() {
        reloadParameter()
    }

    @IBAction private func didTapGetAccessTokenButton() {
        t1p.shared.getAccessToken { token in
            self.showAlert(title: "Get Token", message: token)
        } onFailure: { error in
            self.showAlert(title: "Get Token", message: error)
        }
    }

    private func enableTextField() {
        clientIdTextField.isEnabled = true
        redirectUrlTextField.isEnabled = true

        initialButton.isEnabled = true
        reloadButton.isEnabled = false
    }

    private func disableTextField() {
        clientIdTextField.isEnabled = false
        redirectUrlTextField.isEnabled = false

        initialButton.isEnabled = false
        reloadButton.isEnabled = true
    }

    private func enableButton() {
        signInButton.isEnabled = true
        signUpButton.isEnabled = true
        accountRecoveryButton.isEnabled = true
        signoutButton.isEnabled = true
        reloadButton.isEnabled = true
        getAccessTokenButton.isEnabled = true
    }

    private func disableButton() {
        signInButton.isEnabled = false
        signUpButton.isEnabled = false
        accountRecoveryButton.isEnabled = false
        signoutButton.isEnabled = false
        reloadButton.isEnabled = false
        getAccessTokenButton.isEnabled = false
    }

    private func enableSegmentControl() {
        languageSegmentControl.isEnabled = true
        environmentSegmentControl.isEnabled = true
    }

    private func disableSegmentControl() {
        languageSegmentControl.isEnabled = false
        environmentSegmentControl.isEnabled = false
    }

    private func reloadParameter() {
        enableTextField()
        disableButton()
        enableSegmentControl()
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: T1PDelegate {
    func getTokenSuccess(response: AuthToken) {
        let textMessage = "\(response)"
        showAlert(title: "success", message: textMessage)
    }

    func getTokenFail() {
        showAlert(title: "fail", message: "")
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let dismissKeyboardSelector = #selector(UIViewController.dismissKeyboard)
        let tap = UITapGestureRecognizer(target: self, action: dismissKeyboardSelector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
