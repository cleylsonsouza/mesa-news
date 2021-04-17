//
//  NewsProtocol.swift
//  Mesa News
//

protocol NewsProtocol: BaseViewProtocol {
    func requestNewsFeedWith(currentPage: Int?, perPage: Int?)
    func confirmAPIResponse(data: NewsFeed, isFirstPage: Bool)
}
