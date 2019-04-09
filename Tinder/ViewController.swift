//
//  ViewController.swift
//  Tinder
//
//  Created by seijiro on 2019/04/09.
//  Copyright © 2019 norainu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
  @IBOutlet var basicCard: UIView!
  @IBOutlet var liveImageView: UIImageView!
  @IBOutlet var person1: UIView!
  @IBOutlet var person2: UIView!
  @IBOutlet var person3: UIView!
  @IBOutlet var person4: UIView!


  let names = ["人1","人2","人3","人4"]
  var likedNames = [String]()
  
  var centerOfCard:CGPoint!
  var people = [UIView]()
  var selectedCardCount = 0

  override func viewDidLoad() {
    super.viewDidLoad()

    centerOfCard = basicCard.center

    people.append(person1)
    people.append(person2)
    people.append(person3)
    people.append(person4)

  }

  func resetCard(){
      self.basicCard.center = self.centerOfCard
      self.basicCard.transform = .identity
      self.liveImageView.alpha = 0
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "next" {
      let vc = segue.destination as! ListViewController
      vc.likedNames = likedNames
    }
  }

  @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
    let card = sender.view!
    let point = sender.translation(in: view)
    sender.setTranslation(CGPoint.zero, in: view)

    card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
    people[selectedCardCount].center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)


    let xFromCenter = card.center.x - view.center.x
    card.transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
    people[selectedCardCount].transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
    if xFromCenter > 0 {
      liveImageView.image = UIImage(named: "good")
      liveImageView.alpha = 1
      liveImageView.tintColor = UIColor.red
    } else if xFromCenter < 0 {
      liveImageView.image = UIImage(named: "bad")
      liveImageView.alpha = 1
      liveImageView.tintColor = UIColor.blue
    }

    //print(sender.state)
    if sender.state == UIGestureRecognizer.State.ended {
      let person:UIView = people[selectedCardCount]
      // 左に大きくスワイプ
      if card.center.x < 75 {
        UIView.animate(withDuration: 0.2) {
          //card.center = CGPoint(x: card.center.x - 350 , y: card.center.y)
          person.center = CGPoint(x: person.center.x - 350 , y: person.center.y)
          self.resetCard()
        }
        self.liveImageView.alpha = 0
        if selectedCardCount == names.count - 1 {
          print(likedNames)
          performSegue(withIdentifier: "next", sender: self)
        }
        self.selectedCardCount = (self.selectedCardCount + 1) % 4
        return
      }
      // 右に大きくスワイプ
      if card.center.x > self.view.frame.width - 75 {
        UIView.animate(withDuration: 0.2) {
          //card.center = CGPoint(x: card.center.x + 350 , y: card.center.y)
          person.center = CGPoint(x: person.center.x + 350 , y: person.center.y)
          self.resetCard()
        }
        self.liveImageView.alpha = 0
        likedNames.append(names[selectedCardCount])
        if selectedCardCount == names.count - 1 {
          print(likedNames)
          performSegue(withIdentifier: "next", sender: self)
        }
        self.selectedCardCount = (self.selectedCardCount + 1) % 4
        return
      }

      // 元に戻る処理
      UIView.animate(withDuration: 0.2) {
        self.resetCard()
        person.transform = .identity
        person.center = self.centerOfCard
      }

    }
  }
  
}

