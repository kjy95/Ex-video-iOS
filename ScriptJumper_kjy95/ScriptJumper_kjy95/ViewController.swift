//
//  ViewController.swift
//  ScriptJumper_kjy95
//
//  Created by 김지영 on 16/05/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate  {
    var clockList = [String]()
    var subList = [String]()
    var subListFilter = [String]()
    var clockListFilter = [String]()
    var jumperTime : String! //
    var parser: SmiParser?
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    /*func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        subListFilter = [String]()
        clockListFilter =  [String]()
        for i in Range(0...subList.count){
            if subList[i].contains(find: searchBar.text ?? ""){
                subListFilter.append(subList[i])
                clockListFilter.append(clockList[i])
            }
        }
        subtitleTableview.reloadData()
    }*/
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clockListFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subtitleTableViewCell", for:indexPath) as! subtitleTableViewCell
        cell.subtitleLabel.text = subListFilter[indexPath.row]
        cell.clockLabel.text = clockListFilter[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        jumperTime = clockList[indexPath.row]
    }
    @IBOutlet weak var subtitleTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subtitleTableview.delegate = self
        subtitleTableview.dataSource = self
        searchBar.delegate = self
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let parser = SmiParser(subfileName: "Oceans.Thirteen.2007.1080p.BluRay.H264.AAC-RARBG", ofType: "smi")
            self.clockList = parser.clockList
            self.subList = parser.onlySubtitleList!
            self.clockListFilter = self.clockList
            self.subListFilter = self.subList
            self.parser = parser
            DispatchQueue.main.async { [weak self] in
                self?.subtitleTableview.reloadData()
            }
        }
    }

    @IBAction func playVideo(_ sender: Any) {
        let filePath:String? = Bundle.main.path(forResource: "Oceans.Thirteen.2007.1080p.BluRay.H264.AAC-RARBG", ofType: "mp4")
        let url =  URL(fileURLWithPath: filePath!)
        let playVideoView = VideoLauncher()
        playVideoView.parser = parser
        playVideoView.showVideoPlayer(url: url, jumperTime: jumperTime)
        
    }
    
}

extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
}
