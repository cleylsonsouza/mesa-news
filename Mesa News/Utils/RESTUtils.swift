//
//  RESTUtils.swift
//  Mesa News
//

class Response {
    
    public func getStatusMessageFrom(code: Int) -> String {
        switch code {
        case 401:
            return "Acesso negado para este usuário."
        case 404:
            return "Este serviço está temporariamente indisponível."
        case 500:
            return "Estamos enfrentando alguns problemas. Por favor, tente mais tarde."
        default:
            return "Erro interno."
        }
    }
}
