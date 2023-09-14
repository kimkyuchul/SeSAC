//
//  LottoViewController.swift
//  Unsplash
//
//  Created by 김규철 on 2023/09/13.
//

import UIKit

class LottoViewController: UIViewController {
    @IBOutlet weak var lottoButton: UIButton!
    @IBOutlet weak var lottoResultLabel: UILabel!
    @IBOutlet weak var lnumber6Label: UILabel!
    @IBOutlet weak var lnumber5Label: UILabel!
    @IBOutlet weak var number4Label: UILabel!
    @IBOutlet weak var lnumber3Label: UILabel!
    @IBOutlet weak var lnumber2Label: UILabel!
    @IBOutlet weak var number1Label: UILabel!
    private var viewModel = LottoViewModel()
    
//    init(viewModel: LottoViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoadEvent()
        bind()
        lottoButton.addTarget(self, action: #selector(lottoButtonTapped), for: .touchUpInside)
    }
    
    @objc func lottoButtonTapped() {
        viewModel.lottobuttonTapp()
    }
    
    func bindInput() {
        viewModel.lottoMoney.value = lottoResultLabel.text ?? ""
    }
    
    func bind() {
        viewModel.number1.bind { [weak self] number in
            DispatchQueue.main.async {
                self?.number1Label.text = "\(number)"
            }
        }
        
        viewModel.number2.bind { [weak self] number in
            DispatchQueue.main.async {
                self?.lnumber2Label.text = "\(number)"
            }
        }
        
        viewModel.number3.bind { [weak self] number in
            DispatchQueue.main.async {
                self?.lnumber3Label.text = "\(number)"
            }
        }
        
        viewModel.number4.bind { [weak self] number in
            DispatchQueue.main.async {
                self?.number4Label.text = "\(number)"
            }
        }
        
        viewModel.number5.bind { [weak self] number in
            DispatchQueue.main.async {
                self?.lnumber5Label.text = "\(number)"
            }
        }
        
        viewModel.number6.bind { [weak self] number in
            DispatchQueue.main.async {
                self?.lnumber6Label.text = "\(number)"
            }
        }
        
        viewModel.lottoMoney.bind { [weak self] lottoMoney in
            DispatchQueue.main.async {
                self?.lottoResultLabel.text = lottoMoney
            }
        }

    }
}
