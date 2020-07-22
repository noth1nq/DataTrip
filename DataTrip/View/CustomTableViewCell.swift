
import UIKit




class customTableViewCell : UITableViewCell {
    
    
    lazy var backview : UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        
        return view
        
    }()
    
    lazy var settingImage : UIImageView = {
        
        let imageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 30, height: 30))
        
        imageView.contentMode = .scaleToFill
        
        return imageView
        
    }()
    
    lazy var lbl : UILabel = {
        
        let lbl = UILabel(frame: CGRect(x: 60, y: 10, width: self.frame.width - 80 , height: 30))
        
        return lbl
        
        
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        addSubview(backview)
        backview.addSubview(settingImage)
        backview.addSubview(lbl)
        
        
    }
    
}






