//
//  SearchOutputViewController.swift
//  flickrAPIdemo
//
//  Created by Stan Liu on 2020/2/25.
//  Copyright © 2020 Stan Liu. All rights reserved.
//

import UIKit

class SearchOutputViewController: UIViewController {
    
    private let cellIdentifier = "cell"
    private var photo = [Photo]()
    public var titleText = ""
    public var perPage = ""
    @IBOutlet weak var searchResultCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "搜尋結果: \(titleText)"
        
        searchResultCollectionView.register(UINib(nibName: "SearchResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        
        getSearchResult()
    }
    
    func getSearchResult() {
        let finalLink = Utils.api_url + "&text=\(titleText)&per_page=\(perPage)&format=json&nojsoncallback=1"
        if let url = URL(string: finalLink) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let d = data,
                    let searchData = try? JSONDecoder().decode(SearchData.self, from: d) {
                    self.photo = searchData.photos.photo
                    DispatchQueue.main.async {
                        self.searchResultCollectionView.reloadData()
                    }
                }
            }
            task.resume()
        }
    }
}

extension SearchOutputViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SearchResultCollectionViewCell
        
        let p = photo[indexPath.item]
        cell.titleLabel.text = p.title
        cell.photoImageView.image = nil
        
        let task = URLSession.shared.dataTask(with: p.imageUrl) { (data, response, error) in
            if let d = data,
                let img = UIImage(data: d) {
                DispatchQueue.main.async {
                    cell.photoImageView.image = img
                }
            }
        }
        task.resume()
        
        return cell
    }
}

extension SearchOutputViewController: UICollectionViewDelegate {
    
}

extension SearchOutputViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width-30)/2,
                      height: (collectionView.frame.size.width+30)/2)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
