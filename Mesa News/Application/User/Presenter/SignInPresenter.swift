//
//  SignInPresenter.swift
//  Mesa News
//

import Alamofire

class SignInPresenter: BasePresenterProtocol {
    
    weak private var view : UserSignInProtocol?
    
    var service: AlamofireService = RestClient()
    
    func attach(view: NSObjectProtocol){
        self.view = view as? UserSignInProtocol
    }
    
    func detach() {
        view = nil
    }
    
    func doSignIn(data: SignInDTO) {
        self.view?.loading!(show: true)
        
        let params = [
            "email": data.email!,
            "password": data.pass!
        ] as [String : Any]
        
        let path = SessionManager.SIGN_IN
        let url = path.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!

        service.POST(url: url, headers: [:], params, completionHandler: { (data, statusCode, success, headers) -> Void in
            self.view?.loading!(show: false)
            
            if success {
                let user = User.getUserFrom(responseJSON: data!)
                if statusCode == 401 {
                    self.view?.showAlert?(
                        title: "",
                        message: user!.message!
                    )
                    return
                }

                self.view?.confirmAPIResponse(data: user!)
            } else {
                self.view?.showAlert?(title: "", message: Response().getStatusMessageFrom(code: statusCode!))
            }
        })
    }
    
}
