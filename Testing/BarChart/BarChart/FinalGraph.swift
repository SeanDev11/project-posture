//
//  FinalGraph.swift
//  BarChart
//
//  Created by Sean Devine on 14.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//


import UIKit
import Macaw

class FinalGraph: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViews()
    }
    
    
    func setupViews() {
        view.backgroundColor = UIColor.white
        view.addSubview(barView)
        
        barView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        barView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        barView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        barView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        
        view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 170).isActive = true
        
        
        
        view.addSubview(nextButton)
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -20).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    @objc func makeGraphFinal() {
        
        
        
        
        MacawFinalView.playAnimations()
        
    }
    
    
    
    let barView: MacawFinalView = {
        let view = MacawFinalView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(makeGraphFinal), for: .touchUpInside)
        btn.setTitle("Weekly Progress", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        return btn
    }()
    
   
    
    
    let nextButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(nextOne), for: .touchUpInside)
        btn.setTitle("PP next", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        return btn
    }()
    
    @objc func nextOne() {
        
        
        let next = StreakTester()
        
        self.present(next, animated: true)
        
        
        
    }
    
    
    
}



