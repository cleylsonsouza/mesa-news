//
//  SignInViewController.swift
//  Mesa News
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: CustomOutlinedTextField!
    @IBOutlet weak var passcodeTextField: CustomOutlinedTextField!
    @IBOutlet weak var tableView: UITableView!
    
    let passwdButton = UIButton()
    var loading: UIView?
    
    private let presenter: SignInPresenter = SignInPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewComponents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.attach(view: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.detach()
    }
}

// MARK: - Button Views Actions
extension SignInViewController {

    @objc func passwdButtonAction(sender: Any!) {
        let image = passcodeTextField.isSecureTextEntry ? #imageLiteral(resourceName: "ic_hide") : #imageLiteral(resourceName: "ic_show")
        passwdButton.setImage(image, for: .normal)
        passcodeTextField.isSecureTextEntry = !passcodeTextField.isSecureTextEntry
    }

    @IBAction func didTapLoginButton(_ sender: Any) {
        validateCall()
    }

    @IBAction func didTapNewUserButton(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let controller = UIStoryboard.buildSignUpViewController()
            controller.modalPresentationStyle = UIModalPresentationStyle.currentContext
            controller.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(controller, animated: true, completion: nil)
        }
    }
}

// MARK: - View Protocol
extension SignInViewController: UserSignInProtocol {
    
    func validateCall() {
        let userDto = SignInDTO()
        userDto.email = emailTextField.text
        userDto.pass = passcodeTextField.text
        requestLoginFor(user: userDto)
    }
    
    func requestLoginFor(user: SignInDTO) {
        dismissKeyboard()
        presenter.doSignIn(data: user)
    }
    
    func confirmAPIResponse(data: User) {
        UserStorage.user = data
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let controller = UIStoryboard.buildNewsViewController()
            controller.modalPresentationStyle = UIModalPresentationStyle.currentContext
            controller.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func loading(show: Bool) {
        if (show) {
            view.addSubview(loading!)
        } else {
            loading!.removeFromSuperview()
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func configureViewComponents() {
        tableView.separatorStyle = .none
        
        emailTextField.placeholder = "E-mail"
        emailTextField.keyboardType = .emailAddress
        emailTextField.clearButtonMode = .never
        
        passcodeTextField.placeholder = "Passcode"
        passcodeTextField.keyboardType = .default
        passcodeTextField.isSecureTextEntry = true
        passcodeTextField.trailingViewMode = .always
        passwdButton.setImage(UIImage(named: "ic_show"), for: .normal)
        passwdButton.addTarget(self, action: #selector(passwdButtonAction), for: .touchUpInside)
        passcodeTextField.trailingView = passwdButton
        
        loading = LoadingUtils().getOverlay(toView: view)
    }
}
