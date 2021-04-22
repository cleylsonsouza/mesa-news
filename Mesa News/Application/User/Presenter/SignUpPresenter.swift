//
//  SignUpPresenter.swift
//  Mesa News
//

import Alamofire

class SignUpPresenter: BasePresenterProtocol {
    
    weak private var view : UserSignUpProtocol?
    
    var service: AlamofireService = RestClient()
    
    func attach(view: NSObjectProtocol) {
        self.view = view as? UserSignUpProtocol
    }
    
    func detach() {
        view = nil
    }
    
    func doSignUp(data: SignUpDTO) {
        self.view?.loading!(show: true)
        
        let params = [
            "name": data.name!,
            "email": data.email!,
            "password": data.pass!
        ] as [String : Any]
        
        let path = SessionManager.SIGN_UP
        let url = path.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!

        service.POST(urlString: url, headers: [:], params, completionHandler: { (data, statusCode, success, _) -> Void in
            self.view?.loading!(show: false)
            
            if success {
                let user = User.getUserFrom(responseJSON: data!)
                if user!.errors.isEmpty {
                    self.view?.confirmAPIResponse(data: user!)
                    return
                }

                self.view?.showAlert?(
                    title: user!.errors[0].field!,
                    message: user!.errors[0].message!
                )
            } else {
                self.view?.showAlert?(title: "", message: Response().getStatusMessageFrom(code: statusCode!))
            }
        })
    }
    
}
