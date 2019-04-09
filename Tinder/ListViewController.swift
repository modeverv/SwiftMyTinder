//
//  ListViewController.swift
//  Tinder
//
//  Created by seijiro on 2019/04/09.
//  Copyright © 2019 norainu. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDataSource {

  @IBOutlet var tableView: UITableView!
  var likedNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(likedNames)

      tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return likedNames.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = likedNames[indexPath.row]
    return cell
  }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
