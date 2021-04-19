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
    var highlights: [NewsFeed.FeedData] = []
    {
        didSet
        {
            if tableView != nil {
                tableView.reloadData()
            }
        }
    }
    
    var updateTimer: Timer?
    
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
        updateTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(refresh(_:)), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        updateTimer?.invalidate()
        presenter.detach()
    }
}

//MARK: - View Protocol
extension NewsViewController: NewsProtocol {
    
    func requestHightlights() {
        presenter.getHighlights()
    }
    
    func requestNewsFeedWith(currentPage: Int?, perPage: Int?, publishedAt: String?) {
        presenter.getNews(currentPage: currentPage, perPage: perPage, publishedAt: publishedAt)
    }
    
    func confirmAPIResponseFor(data: NewsFeed, isFirstPage: Bool) {
        isLoadingFeed = false
        
        if isFirstPage {
            self.news.removeAll()
        }
        
        self.news.append(contentsOf: data.data)
    }
    
    func confirmAPIResponseFor(data: NewsFeed) {
        isLoadingFeed = false
        
        self.highlights.removeAll()
        self.highlights.append(contentsOf: data.data)
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
        requestNewsFeedWith(currentPage: self.currentPage, perPage: nil, publishedAt: "")
        requestHightlights()
    }
}

//MARK: - Delegates and DataSources
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 135
        }
        return 340
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + self.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "highlightsItemCell", for: indexPath) as! HighlightsItemCell
            cell.selectionStyle = .none
            
            return cell
        }
        
        let item = self.news[indexPath.row - 1]
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
        
        cell.shareButton.tag = indexPath.row - 1
        cell.shareButton.addTarget(self, action: #selector(shareButtonAction(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? HighlightsItemCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingFeed){
            self.isLoadingFeed = true
            self.currentPage += 1
            requestNewsFeedWith(currentPage: self.currentPage, perPage: nil, publishedAt: "")
            requestHightlights()
        }
    }
    
    @objc func shareButtonAction(sender: UIButton!) {
        let item = self.news[sender.tag]
        let activityVC = UIActivityViewController(activityItems: [item.url!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = sender
        present(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
            if completed  {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.highlights.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "highlightsDetailsCell", for: indexPath as IndexPath) as! HighlightsDetailItemCell
        
        let item = self.highlights[indexPath.item]
        
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
            Nuke.loadImage(with: requestLogo, options: options, into: cell.backgroundImageView)
        }
        
        cell.newsTitleLabel.text = item.newsDescription
        
        return cell
    }
    
}
