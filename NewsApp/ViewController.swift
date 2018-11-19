//
//  ViewController.swift
//  NewsApp
//
//  Created by Phyo Thinzar Aung on 11/12/18.
//  Copyright © 2018 padc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tblNews: UITableView!
    
   // var newsList : [ArticleModel] = []
    var list : Results<News>!
    
    var news : News?
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblNews.separatorStyle = .none
        //loadNews()
        //loadNewsAlamofire()
        loadNewsAndSave()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getNews()
    }
    
    func getNews() {
        self.list = realm.objects(News.self)
        self.tblNews.reloadData()
    }
    
//    func loadNews() {
//        URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/everything?q=bitcoin&from=2018-10-13&sortBy=publishedAt&apiKey=86ff401e54fd48528ddd7819208712bd")!) { (data, response, error) in
//            
//        if error != nil {
//            print(error ?? "Unkonwn Error")
//            return
//        }
//        
//        guard let data = data else { return }
//        
//            do {
//                let baseResponse = try JSONDecoder().decode(BaseResponse.self, from: data)
//                
//                DispatchQueue.main.async {
//                    self.newsList = baseResponse.articles
//                    self.tblNews.reloadData()
//                }
//            }catch let jsonErr {
//                print("Json Serialization Error ==> \(jsonErr.localizedDescription)")
//            }
//        }.resume()
//    }
    
    func loadNewsAlamofire() {
        Alamofire.request("https://newsapi.org/v2/everything?q=bitcoin&from=2018-10-13&sortBy=publishedAt&apiKey=86ff401e54fd48528ddd7819208712bd", method: .get).responseJSON {(response) in
            
            switch response.result {
                case .success :
                    let api = response.result.value
                    let json = JSON(api!)
                    let data = json["articles"].array
                    if let result = data {
                        result.forEach( { (news) in
                            
                        })
                        
                        //self.newsList = newsList
                        self.tblNews.reloadData()
                    }
                    break
            case .failure :
                print("Fail")
                break
                
            }
        }
      
    }
    
    func loadNewsAndSave() {
        Alamofire.request("https://newsapi.org/v2/everything?q=bitcoin&from=2018-11-19&sortBy=publishedAt&apiKey=86ff401e54fd48528ddd7819208712bd", method: .get).responseJSON {(response) in
            
            switch response.result {
            case .success :
                let api = response.result.value
                let json = JSON(api!)
                let data = json["articles"].array
                if let result = data {
                    var list : [News] = []
                    result.forEach( { (news) in
                        //newsList.append(ArticleModel.parseToNews(news))
                        
                        try! self.realm.write {
                            list.append(News.parseToNews(news))
                            self.realm.add(list)
                        }
                    })
                }
                break
            case .failure :
                print("Fail")
                break
                
            }
        }
    }
}

extension ViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(list)
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        let news = list[indexPath.row]
        cell.lblNewsTitle.text = news.title ?? "Network Error"
        cell.lblNewsReleaseDate.text = news.publishedAt ?? "Date Error"
        //cell.imgNews.loadImageUsingUrlString(url: news.urlToImage ?? "")
        cell.imgNews.sd_setImage(with: URL(string: news.urlToImage ?? ""), placeholderImage : UIImage(named: "news"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ViewController : UITableViewDelegate {
    
}

