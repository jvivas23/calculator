import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Basic Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String previousNumber = "";
  String currentNumber = "";
  String? operation = "";
  String screenOperationController = "";
  String screenValueController = "";
  bool numberWithDecimal = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isNumeric(String? value){
    if(value == null) return false;
    return double.tryParse(value) != null;
  }

  void clear(){
     previousNumber = "";
     currentNumber = "";
     operation = "";
     numberWithDecimal = false;
     updateDisplay();
  }

  void delete(){
    currentNumber = currentNumber.substring(0,currentNumber.length-1);
    updateDisplay();
  }

  void updateDisplay(){
    setState(() {
      screenValueController = currentNumber;
      if(operation != ""){
        screenOperationController = "${previousNumber}${operation}";
      }else{
        screenOperationController = "";
      }
    });
  }

  void doCalculation(){
    double result;
    if(!isNumeric(previousNumber) || !isNumeric(currentNumber)) return;
    switch(operation){
      case '+':
        result = double.tryParse(previousNumber)! + double.tryParse(currentNumber)!;
        break;
      case '-':
        result = double.tryParse(previousNumber)! - double.tryParse(currentNumber)!;
        break;
      case '*':
        result = double.tryParse(previousNumber)! * double.tryParse(currentNumber)!;
        break;
      case '%':
        result = double.tryParse(previousNumber)! / double.tryParse(currentNumber)!;
        break;
      default:
        return;
    }
    if(numberWithDecimal){
      currentNumber = result.toString();
    }else{
      currentNumber = result.toString().split('.')[0];
    }
    operation = "";
    previousNumber = "";
    updateDisplay();
  }

  void chooseOperation(String value){
    if(currentNumber == '') return;
    if(previousNumber !=''){
      doCalculation();
    }
    operation = value;
    previousNumber = currentNumber;
    currentNumber = '';
    updateDisplay();
  }

  void addNumber(String value){
    if(value == '.' && currentNumber.indexOf(".") != -1) return;
    if(value == '.') numberWithDecimal = true;
    currentNumber += value;
    updateDisplay();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    Container _screenSection(){
      return Container(
        height: 300,
        width: double.infinity,
        color: Colors.black,
        margin: const EdgeInsets.only(left:0,top: 0,right: 0,bottom: 0),
        child:
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.only(left:0,top: 0,right: 0,bottom: 0),
                      child:
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                screenOperationController,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                screenValueController,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                  )
              )
          ]
        )
      );
    }

    Column _buildButton(String label,double width,int btnType){
      return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
                visible: btnType ==1,//It's number
                child:
              Container(
                  width: width,
                  height: 50,
                  margin: const EdgeInsets.only(left:0,top: 5,right: 0,bottom: 5),
                  child:
                  ElevatedButton(
                      onPressed:() => { addNumber(label) },
                      child: Text(
                        label,
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                        ),
                      )
                  )
              )
            ),
            Visibility(
                visible: btnType ==2,//It's operation
                child:
                Container(
                    width: width,
                    height: 50,
                    margin: const EdgeInsets.only(left:0,top: 5,right: 0,bottom: 5),
                    child:
                    ElevatedButton(
                        onPressed:() => { chooseOperation(label) },
                        child: Text(
                          label,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                          ),
                        )
                    )
                )
            ),
            Visibility(
                visible: btnType ==3,//It's equals
                child:
                Container(
                    width: width,
                    height: 50,
                    margin: const EdgeInsets.only(left:0,top: 5,right: 0,bottom: 5),
                    child:
                    ElevatedButton(
                        onPressed:() => { doCalculation() },
                        child: Text(
                          label,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                          ),
                        )
                    )
                )
            ),
            Visibility(
                visible: btnType ==4,//It's DEL
                child:
                Container(
                    width: width,
                    height: 50,
                    margin: const EdgeInsets.only(left:0,top: 5,right: 0,bottom: 5),
                    child:
                    ElevatedButton(
                        onPressed:() => { delete() },
                        child:
                          Icon(
                            Icons.backspace,
                            color: Colors.white,
                            size: 40.0,
                          )
                        )
                )
            ),
            Visibility(
                visible: btnType ==5,//It's AC
                child:
                Container(
                    width: width,
                    height: 50,
                    margin: const EdgeInsets.only(left:0,top: 5,right: 0,bottom: 5),
                    child:
                    ElevatedButton(
                        onPressed:() => { clear() },
                        child: Text(
                          label,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                          ),
                        )
                    )
                )
            )
          ]
      );
    }

    Row _buttonSection1() {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton("AC", 180,5),
            _buildButton("DEL",90,4),
            _buildButton("%",90,2),
          ],
      );
    }

    Row _buttonSection2() {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton("7", 90,1),
            _buildButton("8", 90,1),
            _buildButton("9", 90,1),
            _buildButton("*", 90,2)
          ]
      );
    }

    Row _buttonSection3() {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton("4", 90,1),
            _buildButton("5", 90,1),
            _buildButton("6", 90,1),
            _buildButton("+", 90,2)
          ],
      );
    }

    Row _buttonSection4() {
      return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("1", 90,1),
              _buildButton("2", 90,1),
              _buildButton("3", 90,1),
              _buildButton("-", 90,2)
            ],
      );
    }

    Row _buttonSection5() {
      return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton(".", 90,1),
              _buildButton("0", 90,1),
              _buildButton("=", 180,3),
            ],
      );
    }
      // This method is rerun every time setState is called, for instance as done
      // by the _incrementCounter method above.
      //
      // The Flutter framework has been optimized to make rerunning build methods
      // fast, so that you can just rebuild anything that needs updating rather
      // than having to individually change instances of widgets.
      return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: [
            _screenSection(),
            _buttonSection1(),
            _buttonSection2(),
            _buttonSection3(),
            _buttonSection4(),
            _buttonSection5(),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
}
