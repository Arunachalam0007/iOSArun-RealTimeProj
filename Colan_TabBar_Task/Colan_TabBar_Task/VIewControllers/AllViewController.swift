//
//  ViewControlleOne.swift
//  Colan_TabBar_Task
//
//  Created by ArunSha on 27/05/21.
//

import UIKit

public let titleLabel:UILabel = {
    let titleLabel = UILabel()
    titleLabel.backgroundColor = .white
    titleLabel.frame = CGRect(x: 20, y: 300, width: 300, height: 300)
    titleLabel.textAlignment = .center
    return titleLabel
}()


class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(titleLabel)
        titleLabel.text = "FirstViewController"
    }

}

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(titleLabel)
        titleLabel.text = "SecondViewController"
    }

}

class ThiredViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(titleLabel)
        titleLabel.text = "ThiredViewController"
    }

}

class FourthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(titleLabel)
        titleLabel.text = "FourthViewController"
    }

}

class FifthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(titleLabel)
        titleLabel.text = "FifthViewController"
    }

}

class SixthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(titleLabel)
        titleLabel.text = "SixthViewController"
    }

}

class SeventhViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(titleLabel)
        titleLabel.text = "SeventhViewController"
    }

}
