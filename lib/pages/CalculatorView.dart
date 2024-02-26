// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:assignment_3/buttons.dart';
import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String value1 = "";
  String operand = "";
  String value2 = "";
  String answer="";
  @override
  Widget build(BuildContext context) {
    final screenSize=MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
          Expanded(
            child: SingleChildScrollView(//for  scrolling when keyboard opens
              reverse: true, //starts from bottom to top the svrooling
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(16),
                child: Text(
                  "$value1$operand$value2".isEmpty
                  ?"0"
                  :"$value1$operand$value2", 
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
          Wrap(
            children: Buttons.buttonValues
            .map(
              (value) => SizedBox(
                width:screenSize.width/4,
                height:value == (value == Buttons.dotSign || value == Buttons.equalSign)?screenSize.width/3:screenSize.width/5,
                child: createButton(value))
              )
              .toList(),
          )//for buttons because it'll enable to have multiple widgets inside it

        ],
        ),
      ),
    );
  }

  Widget  createButton(value){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(//To style it
      color: btnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide:const  BorderSide(
            color: Colors.white24),
          borderRadius: BorderRadius.circular(100)
          ),
        child: InkWell( //Make the button tapable
          onTap: ()=>onButtonTap(value),
          child: Center(
            child: Text(
              value,
              style:const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ))
            ),
        ),
      
      ),
    );
  }

  void onButtonTap(String value){

    if(value==Buttons.clr){
      clear();
      return;
    }
    if(value==Buttons.per){
      convertToPercentage();
      return;
    }
    if(value==Buttons.equalSign){
      calculate();
      return;
    }
    appendValues(value);
  }
  void calculate(){
    if(value1.isEmpty) return;
    if(operand.isEmpty) return;
    if(value2.isEmpty) return;

   final double num1=double.parse(value1);
   final double num2=double.parse(value2);

    var answer=0.0;
    switch(operand){
      case Buttons.add:
        answer=num1+num2;
        break;
      case Buttons.subtract:
        answer=num1-num2;
        break;
      case Buttons.multiply:
        answer=num1*num2;
        break;
      case Buttons.divide:
        answer=num1/num2;
        break;
      default:

    }
    setState(() {
      value1="$answer";

      if(value1.endsWith(".0")){
        value1=value1.substring(0, value1.length-2);
      }
      operand="";
      value2="";
    });
  }
  void convertToPercentage(){
    if(value1.isNotEmpty&&operand.isNotEmpty&&value2.isNotEmpty){
       calculate();
    }
    if(operand.isNotEmpty){
      //operand is the last input
      return;
    }
    final val = double.parse(value1);
    setState(() {
      value1= "${(val/100)}";
      operand="";
      value2="";
    });
  }
  void clear(){
    setState(() {
      value1="";
      operand="";
      value2="";
    });
  }

  
  void delete(){
    if(value2.isNotEmpty){
      value2 = value2.substring(0, value2.length - 1);
    }else if(operand.isNotEmpty){
      operand = "";
    }else if (value1.isNotEmpty){
      value1 = value1.substring(0,value1.length - 1);
    }
  }
  
  void appendValues(String value){
    //if operand is pressed and not .
      if(value!=Buttons.dotSign&&int.tryParse(value)==null){
        //when operand pressed
        if(operand.isNotEmpty && value2.isNotEmpty){
          calculate();
        }
        operand = value;
      }else if(value1.isEmpty || operand.isEmpty){
        if(value==Buttons.dotSign && value1.contains(Buttons.dotSign)) return;
         if(value==Buttons.dotSign&&(value1.isEmpty  || value1==Buttons.dotSign)){
          value="0.";
         }
          value1+=value;
      }else if(value2.isEmpty || operand.isNotEmpty){
        if(value==Buttons.dotSign && value2.contains(Buttons.dotSign)) return;
        if(value==Buttons.dotSign&&(value2.isEmpty  || value2==Buttons.dotSign)){
          value="0.";
        }
          value2+=value;
      }

     
      setState(() {});
  }
  Color btnColor(value){
    return [
    Buttons.clr].contains(value)
          ?Colors.blueGrey
          :[
            Buttons.per,
             Buttons.multiply,
              Buttons.add,
              Buttons.subtract,
              Buttons.divide,
              Buttons.equalSign,
              ].contains(value)?Colors.orange
              :Colors.black;
  }
}