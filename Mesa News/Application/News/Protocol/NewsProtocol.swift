//
//  NewsProtocol.swift
//  Mesa News
//

protocol NewsProtocol: BaseViewProtocol {
    func requestNewsFeedWith(currentPage: Int?, perPage: Int?, publishedAt: String?)
    func requestHightlights()
    func confirmAPIResponseFor(data: NewsFeed, isFirstPage: Bool)
    func confirmAPIResponseFor(data: NewsFeed)
}
