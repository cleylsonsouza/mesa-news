//
//  UserSignUpProtocol.swift
//  Mesa News
//

protocol UserSignUpProtocol: BaseViewProtocol {
    func validateCall()
    func requestRegistrationFor(user: SignUpDTO)
    func confirmAPIResponse(data: User)
}
