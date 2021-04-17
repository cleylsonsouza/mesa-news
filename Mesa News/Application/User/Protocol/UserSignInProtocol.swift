//
//  UserSignInProtocol.swift
//  Mesa News
//

protocol UserSignInProtocol: BaseViewProtocol {
    func validateCall()
    func requestLoginFor(user: SignInDTO)
    func confirmAPIResponse(data: User)
}
