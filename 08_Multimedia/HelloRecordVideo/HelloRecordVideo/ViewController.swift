//********************************************************************
//********************************************************************
//************************** Record Vidio ****************************
//********************************************************************
//********************************************************************

import UIKit
import MobileCoreServices
import Photos //1.引入MobileCoreServices與Photos函式庫

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
//2.服從UIImagePickerControllerDelegate與UINavigationControllerDelegate
    
    @IBAction func recordVideo(sender: UIButton) {
        //3.檢查是否有錄影的相機可以使用
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            //4.生成負責錄影的 UIImagePickerController
            let imagePicker = UIImagePickerController()
            //5.設定來源為相機
            imagePicker.sourceType = .Camera
            //6.設定錄影的結果是影片
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            //7.把ViewController設定給UIImagePickerController的delegate
            imagePicker.delegate = self
            //8.推出UIImagePickerController來錄影
            presentViewController(imagePicker,
                animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            //9.利用UIImagePickerControllerMediaURL的key
            //從info拿到錄影短片的URL
            let urlOfVideo = info[UIImagePickerControllerMediaURL] as? NSURL
            //10.把影片存入相機膠卷中
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
PHAssetChangeRequest.creationRequestForAssetFromVideoAtFileURL(urlOfVideo!)
            }) {(success, error) -> Void in}
            
            //11.把錄影的UIImagePickerController收回
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        //12.錄影過程中如果按了cancel，則把錄影畫面收回
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

