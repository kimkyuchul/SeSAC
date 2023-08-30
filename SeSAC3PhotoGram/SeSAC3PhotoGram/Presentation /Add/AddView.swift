//
//  AddView.swift
//  SeSAC3PhotoGram
//
//  Created by 김규철 on 2023/08/28.
//

import UIKit

class AddView: BaseView {
    
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .brown
        view.contentMode = .scaleToFill
        return view
    }()
    let searchButton = {
        let v = UIButton()
        v.backgroundColor = .systemPink
        return v
    }()
    let searchProtocolButton = {
        let v = UIButton()
        v.backgroundColor = .orange
        return v
    }()
    let dateButton = {
        let v = UIButton()
        v.backgroundColor = .magenta
        v.setTitle(DateFormatter.today(), for: .normal)
        return v
    }()
    let titleButton = {
        let v = UIButton()
        v.backgroundColor = .purple
        v.setTitle("오늘의 사진", for: .normal)
        return v
    }()
    let closureButton = {
        let v = UIButton()
        v.backgroundColor = .brown
        v.setTitle("클로저", for: .normal)
        return v
    }()
    
    
    override func configureView() {
        [photoImageView, searchButton, searchProtocolButton, dateButton, titleButton, closureButton].forEach { view in
            addSubview(view)
        }
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.topMargin.leadingMargin.trailingMargin.equalTo(self).inset(10)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(photoImageView)
        }
        
        searchProtocolButton.snp.makeConstraints { make in
            make.size.equalTo(searchButton.snp.size)
            make.bottom.leading.equalTo(photoImageView)
        }

        dateButton.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(10)
            make.height.equalTo(searchButton.snp.height)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        titleButton.snp.makeConstraints { make in
            make.top.equalTo(dateButton.snp.bottom).offset(10)
            make.height.equalTo(searchButton.snp.height)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        closureButton.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).offset(10)
            make.height.equalTo(searchButton.snp.height)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
