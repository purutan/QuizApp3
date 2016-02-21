//
//  ViewController.swift
//  QuizApp3
//
//  Created by 藤田 優介 on 2016/02/21.
//  Copyright © 2016年 yusuke.fujita. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var quizText: UITextView!
    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var resultText: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var maruButton: UIButton!
    @IBOutlet weak var batsuButton: UIButton!
    
    
    var quizNo : NSInteger = 1                  //クイズ番号
    var quizFlag : NSInteger = 0                //正解・不正解のフラグ
    let lastQuiz : NSInteger = 6                //最終問題番号 + 1  を設定
    var yourAnswer : NSInteger = 0                 //解答
    var quiz : NSString = ""
    var correctQuizNum : NSInteger = 0          //正解数
    var correctQuizRatio : Double = 0        //正解率
    var musicPlayer:AVAudioPlayer!              //再生用のplayerを設定

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resetButton.hidden = true
        
        
        quizStart()
        
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func quizStart() {
        
        switch quizNo {
            
            // quizFlag = 1 の場合、○が正解
            // quizFlag = 0 の場合、×が正解
            
        case 1:
            quiz = "問１\n最近話題の駄菓子がテーマの漫画・アニメ作品と言えば『だがしかし』である。"
            quizText.text = String(quiz)
            quizFlag = 1
            break
            
        case 2:
            quiz = "問2\n機会費用とは事業や行為に投下した資金・労力のうち、事業や行為の撤退・縮小・中止によっても戻ってこない投下資金または労力を言う。"
            quizText.text = String(quiz)
            quizFlag = 0
            break
            
        case 3:
            quiz = "問3\nサッカーにて一人の選手が３得点あげるとハットトリックと呼ばれるが、ダーツではブルに３本とも命中した場合にハットトリックと呼ばれる。"
            quizText.text = String(quiz)
            quizFlag = 1
            break
            
        case 4:
            quiz = "問4\n 生きている間は有名な人で会っても広辞苑に載ることがない。"
            quizText.text = String(quiz)
            quizFlag = 1
            break
            
        case 5:
            quiz = "問5\n技術的特異点（シンギュラリティ）とは、テクノロジーが急速に変化し、それにより甚大な影響がもたらされ、人間の生活が後戻りできないほどに変容してしまうような、来るべき未来のことである。"
            quizText.text = String(quiz)
            quizFlag = 1
            break
            
        default :
            break
            
        }
    }
    
    func quizAnswer(yourAnswer : Int) {
        
        if (yourAnswer == quizFlag) {
            // 正解の処理
            answerText.text = "問\(quizNo)は正解です"
                        do {
                // 再生するmusicファイルのパスを取得  今回は[music.mp3]
                    let music_data = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("info-girl1-omedetou1", ofType: "mp3")!)
                    musicPlayer = try AVAudioPlayer(contentsOfURL: music_data)
                    musicPlayer.play()
                    //Playbutton.setTitle("Stop", forState: UIControlState.Normal)
            
            }catch let error as NSError {
                //エラーをキャッチした場合
                print(error)
            }
            
            quizNo++
            correctQuizNum++
            quizStart()
            
        } else {
            // 間違いの処理
            answerText.text = "問\(quizNo)は不正解です"
            do {
                // 再生するmusicファイルのパスを取得
                let music_data = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("info-girl1-zannen1", ofType: "mp3")!)
                musicPlayer = try AVAudioPlayer(contentsOfURL: music_data)
                musicPlayer.play()
            }catch let error as NSError {
                //エラーをキャッチした場合
                print(error)
            }

            quizNo++
            quizStart()
        }
        
        if (quizNo == lastQuiz){
            // 最後の問題になった場合
            resetButton.hidden = false
            gameResult()
        }
    }
    
    func gameResult() {
        correctQuizRatio = Double(correctQuizNum) / (Double(lastQuiz) - 1)
        correctQuizRatio = correctQuizRatio * 100
        resultText.text = "正解率は\(String(format: "%.0f", correctQuizRatio))%です"
        // var text = String(format: "%.01f", Float(someCGFloat))
        // 少数点　１桁の表示にするためには　この形
        
        maruButton.hidden = true
        batsuButton.hidden = true
    }
    
    
    @IBAction func reset(sender: UIButton) {
        quizNo = 1
        resetButton.hidden = true
        maruButton.hidden = false
        batsuButton.hidden = false
        resultText.text = "Result"
        answerText.text = "Answer"
        correctQuizNum = 0
        correctQuizRatio = 0
        
        quizStart()
    }
    
    
    @IBAction func yseButton(sender: UIButton) {
        yourAnswer = 1
        quizAnswer(1)
    }
    
    @IBAction func noButton(sender: UIButton) {
        yourAnswer = 0
        quizAnswer(0)
    }
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    



