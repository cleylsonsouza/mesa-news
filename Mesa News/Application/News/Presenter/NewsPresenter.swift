//
//  NewsPresenter.swift
//  Mesa News
//

import Alamofire

class NewsPresenter: BasePresenterProtocol {
    
    weak private var view : NewsProtocol?
    
    var service: AlamofireService = RestClient()
    var userStorage: User!
    
    func attach(view: NSObjectProtocol) {
        self.view = view as? NewsProtocol
        userStorage = UserStorage.user
    }
    
    func detach() {
        view = nil
    }
    
    func getHighlights() {
        self.view?.loading!(show: true)
        
        let headers = [
            "Authorization": "Bearer \(userStorage.accessToken)"
        ] as HTTPHeaders
        
        let path = SessionManager.HIGHLIGHTS
        let url = path.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!

        service.GET(urlString: url, headers: headers,
                    completionHandler: { (data, statusCode, success) -> Void in
            self.view?.loading!(show: false)

            if success {
                let hightlights = NewsFeed.getFeedFrom(responseJSON: data!)
                
                self.view?.confirmAPIResponseFor(data: hightlights)
            } else {
                self.view?.showAlert?(title: "", message: Response().getStatusMessageFrom(code: statusCode!))
            }
        })
    }

    func getNews(currentPage: Int?, perPage: Int?, publishedAt: String?) {
        self.view?.loading!(show: true)

        let headers = [
            "Authorization": "Bearer \(userStorage.accessToken)"
        ] as HTTPHeaders

        let path = NSString(format: SessionManager.NEWS_FEED as NSString,
                            String(currentPage!), String(perPage ?? 20),
                            String(publishedAt ?? "")) as String
        let url = path.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!

        service.GET(urlString: url, headers: headers,
                    completionHandler: { (data, statusCode, success) -> Void in
            self.view?.loading!(show: false)

            if success {
                let feed = NewsFeed.getFeedFrom(responseJSON: data!)

                if currentPage == 1 {
                    self.view?.confirmAPIResponseFor(data: feed, isFirstPage: true)
                    return
                }
                self.view?.confirmAPIResponseFor(data: feed, isFirstPage: false)
            } else {
                self.view?.showAlert?(title: "", message: Response().getStatusMessageFrom(code: statusCode!))
            }
        })
    }
}
