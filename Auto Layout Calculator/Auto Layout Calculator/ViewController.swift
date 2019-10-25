//
//  ViewController.swift
//  Auto Layout Calculator
//
//  Created by DKU on 10/07/2018.
//  Copyright © 2018 dku. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
   
    
    @IBOutlet weak var lbl_calculator: UILabel!;
   
    var numberOnScreen :Double = 0;
    var isTransactionButtonPressedBeforeExceptEqualsAndReset = false ;
    var bufferKeypad :String = "" ;
    var arrayOfNumbers = [Double]() ;
    var result : Double = 0 ;
    var tagKeeper = [Int]();
    var bufferResult : Double = 0;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

  
    @IBAction func numberPressed(_ sender: UIButton) {
       
        //That control is executes to be able to see previous numbers on screen after press any transaction button
        if(isTransactionButtonPressedBeforeExceptEqualsAndReset==true){
            
            
            switch sender.tag {
        case 0:
            bufferKeypad += "0"
        case 1:
            bufferKeypad += "1"
        case 2:
            bufferKeypad += "2"
        case 3:
            bufferKeypad += "3"
        case 4:
            bufferKeypad += "4"
        case 5:
            bufferKeypad += "5"
        case 6:
            bufferKeypad += "6"
        case 7:
            bufferKeypad += "7"
        case 8:
            bufferKeypad += "8"
        case 9:
            bufferKeypad += "9"
            case 15:
                clearAll();
        case 17:
            if(!bufferKeypad.contains(".")){
                bufferKeypad += "."
            }
            
            
        default:
           break
        }
        
            lbl_calculator.text = "" ;
            lbl_calculator.text! = bufferKeypad ;
            numberOnScreen = cleanConverter(numbers: lbl_calculator.text!) ;
            
        }
            
        //To get first number after initalization
        else{
          
            switch sender.tag {
            case 0:
                lbl_calculator.text! += "0"
            case 1:
                 lbl_calculator.text! += "1"
            case 2:
                 lbl_calculator.text! += "2"
            case 3:
                 lbl_calculator.text! += "3"
            case 4:
                 lbl_calculator.text! += "4"
            case 5:
                 lbl_calculator.text! += "5"
            case 6:
                 lbl_calculator.text! += "6"
            case 7:
                 lbl_calculator.text! += "7"
            case 8:
                 lbl_calculator.text! += "8"
            case 9:
                 lbl_calculator.text! += "9"
            case 15:
                clearAll();
            case 17:
                if(!(lbl_calculator.text?.contains("."))!){
                     lbl_calculator.text! += "."
                    
                }
                
            default:
                break;
            }
       
        numberOnScreen = cleanConverter(numbers: lbl_calculator.text!) ;
       
        }
    }

    
    @IBAction func transactionButtonPressed(_ sender: UIButton) {
       
        
        //Due to equals button and other buttons works differently we shoild monitor user's moves.
        tagKeeper.append(sender.tag);
        
        
        
       
  
        // This method is for getting input for Equal Button which lately push during using app. And if you want to enter a new number without pressing AC button.
        
        if(tagKeeper.count >= 2 && tagKeeper[tagKeeper.count-2]==16 && tagKeeper[tagKeeper.count-1] != 16 && String(result) != lbl_calculator.text) {
            arrayOfNumbers.removeAll();
            bufferKeypad="";
            arrayOfNumbers.insert(cleanConverter(numbers: lbl_calculator.text!), at: 0)
            isTransactionButtonPressedBeforeExceptEqualsAndReset=true;
            bufferResult=arrayOfNumbers[0];
   
        }
      

            //That method is used for to get first number of transaction.
        if(lbl_calculator.text != "" && arrayOfNumbers.count==0 && bufferResult == 0 && (sender.tag==10 || sender.tag==11 || sender.tag==12 || sender.tag==13 || sender.tag==14 )){
            
            arrayOfNumbers.insert(numberOnScreen, at: 0);
            isTransactionButtonPressedBeforeExceptEqualsAndReset=true;
                
                
            }
            
              //Equals button
        else if(lbl_calculator.text != "" && arrayOfNumbers.count==1 && sender.tag==16){
            
            //That if used for first equals button , if there is not any other consecutive transactions before.
            if(bufferResult==0){

                    
                arrayOfNumbers.insert(numberOnScreen, at: 1);
                additionalTransaction(transaction: tagKeeper[tagKeeper.count-2]);
                    
                }
                
            else{

                arrayOfNumbers.removeAll();
                arrayOfNumbers.insert(bufferResult, at: 0);
                arrayOfNumbers.insert(numberOnScreen, at: 1);
                additionalTransaction(transaction: tagKeeper[tagKeeper.count-2]);
               
                }
            }
            
            
            
            //This method send parameters if Equal Button  which lately push during using app.
        else if(lbl_calculator.text != "" && arrayOfNumbers.count==1 && tagKeeper[tagKeeper.count-1] != 16 && tagKeeper[tagKeeper.count-2] != 16 && numberOnScreen != 0){

            arrayOfNumbers.insert(numberOnScreen, at: 1);
            additionalTransaction(transaction: sender.tag);
            
           }
    }
    
    
    
    
    func additionalTransaction(transaction: Int){
        
        
        //Add
        if(transaction==10){
            
            result = arrayOfNumbers[0] + arrayOfNumbers [1];
        }
        //Subtract
        else if(transaction==11){
            
            result = arrayOfNumbers[0] - arrayOfNumbers [1];
        }
        //Multiply
        else if(transaction==12){
   
            result = arrayOfNumbers[0] * arrayOfNumbers [1];
        }
        //Divide
        else if(transaction==13){

            result = arrayOfNumbers[0] / arrayOfNumbers [1];
        }
        //Modulo
        else if(transaction==14){

            result = (arrayOfNumbers[0].truncatingRemainder(dividingBy: arrayOfNumbers[1]));
        }
        
        
//        Could be used instead of extension to show values in a proper format
        
//        if(result.truncatingRemainder(dividingBy: 1) == 0){
//            lbl_calculator.text = String(format:"%.000f" , result)
//        }
//
//        else{
//            lbl_calculator.text = String(format:"%.6f" , result)
//        }
        
        
        //CleanValueExtension.swift
        lbl_calculator.text = result.cleanValue;
        
        arrayOfNumbers.removeAll();
        arrayOfNumbers.insert(result, at: 0);
        bufferResult = result ;
        bufferKeypad = "";
        numberOnScreen=0;
        isTransactionButtonPressedBeforeExceptEqualsAndReset=true;
        
        
    }
        
    func clearAll(){
        arrayOfNumbers.removeAll();
        result=0;
        bufferKeypad = "";
        lbl_calculator.text = "";
        numberOnScreen=0;
        isTransactionButtonPressedBeforeExceptEqualsAndReset=false;
    }
    
    //To prevent the possibilty of error while converting lbl_calculator.text to Double ; Possible Error: Error:“fatal error: unexpectedly found nil while unwrapping an Optional value”
    func cleanConverter (numbers : String) ->Double{
        
        return (numbers as NSString).doubleValue;
        
        }
    
    }
        

