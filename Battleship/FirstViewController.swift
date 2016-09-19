//
//  FirstViewController.swift
//  Battleship
//
//  Created by Sabrina Ip on 9/16/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var boardView: UIView!
    
    var engine = gameEngine(boardSize: 10)
    

//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpBoard(v: boardView, boardSize: engine.boardSize)
    }
    
    
    func setUpBoard(v: UIView, boardSize: Int) {
        
        var xCoord = 0
        var yCoord = 0
        var rectSize: CGFloat
        
        if v.bounds.size.width < v.bounds.size.height {
            rectSize = v.bounds.size.width / CGFloat(boardSize+1)
        } else {
            rectSize = v.bounds.size.height / CGFloat(boardSize+1)
        }
        
        enum RowLetter: Int {
            case A = 1, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
        }
        
        var tag = 1
        
        for row in 0...boardSize{
            if row != 0 {
                yCoord += Int(rectSize)
            }
            for column in 0...boardSize {
                xCoord = column%(boardSize + 1)
                let peg = CGRect(origin: CGPoint(x: xCoord * Int(rectSize), y: yCoord), size: CGSize(width: rectSize*0.9, height: rectSize*0.9))
                
                if row == 0 || column == 0 {
                    let label = UILabel(frame: peg)
                    label.backgroundColor = .white
                    label.textAlignment = .center
                    if row == 0 && column == 0 {
                    } else if row == 0 {
                        if let letter = RowLetter(rawValue: column) {
                            label.text = String(describing: letter)
                        }
                    } else if column == 0 {
                        label.text = String(row)
                    }
                    v.addSubview(label)
                } else {
                    let button = UIButton(frame: peg)
                    button.tag = tag
                    tag += 1
                    button.backgroundColor = .lightGray
                    button.setTitle(("?"), for: UIControlState())
                    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                    v.addSubview(button)
                }
            }
        }
    }
    
    func buttonTapped(button: UIButton) {
        if engine.hits >= 17 {
            for i in boardView.subviews {
                if let button = i as? UIButton {
                    button.setTitle("W", for: UIControlState.normal)
                    button.backgroundColor = .green
                }
            }
        }
        if engine.hitShipCheck(tag: button.tag) {
            if button.backgroundColor == .red || button.backgroundColor == .green {}
            else {
                button.setTitle("!", for: UIControlState())
                button.backgroundColor = .red
                engine.hits += 1
                print("engine hits \(engine.hits)")
            }
        } else {
            button.setTitle("", for: UIControlState())
            button.backgroundColor = .black
        }
    }
}
