//
//  NewsViewController.swift
//  Mesa News
//

import UIKit
import Nuke

class NewsViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }

    @IBOutlet weak var tableView: UITableView!
    
    var news: [NewsFeed.FeedData] = []
    {
        didSet
        {
            if tableView != nil {
                tableView.reloadData()
            }
        }
    }
    
    private let presenter: NewsPresenter = NewsPresenter()
    var refreshControl = UIRefreshControl()
    
    var currentPage : Int = 0
    var isLoadingFeed : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.attach(view: self)
        
        refreshControl.beginRefreshing()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.detach()
    }
}

extension NewsViewController: NewsProtocol {
    
    func requestNewsFeedWith(currentPage: Int?, perPage: Int?) {
        presenter.getNews(currentPage: currentPage, perPage: perPage)
    }
    
    func confirmAPIResponse(data: NewsFeed, isFirstPage: Bool) {
        isLoadingFeed = false
        
        if isFirstPage {
            self.news.removeAll()
        }
        
        self.news.append(contentsOf: data.data)
    }
    
    func loading(show: Bool) {
        if (show) {
            refreshControl.beginRefreshing()
        } else {
            refreshControl.endRefreshing()
        }
    }
    
    func configureViewComponents() {
        tableView.separatorStyle = .none
        
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        currentPage = 1
        requestNewsFeedWith(currentPage: self.currentPage, perPage: nil)
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.news[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsItemCell", for: indexPath) as! NewsItemCell
        cell.selectionStyle = .none
        
        let photoURL = item.imageUrl
        if !photoURL!.isEmpty {
            var requestLogo = ImageRequest(url: URL(string: photoURL!)!)
            let options = ImageLoadingOptions(
                placeholder: nil,
                transition: .fadeIn(duration: 0.30),
                failureImage: nil
            )
            requestLogo.priority = .high
            DataLoader.sharedUrlCache.cachedResponse(for: requestLogo.urlRequest)
            Nuke.loadImage(with: requestLogo, options: options, into: cell.imageBackgroundView)
        }
        
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.newsDescription
        cell.authorLabel.text = "By \(item.author!)."
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingFeed){
            self.isLoadingFeed = true
            self.currentPage += 1
            requestNewsFeedWith(currentPage: self.currentPage, perPage: nil)
        }
    }
}
