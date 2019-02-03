import 'package:flutter/material.dart';

void main(){
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Interest Calculator",
        home: Interest(),
      )
  );
}

class Interest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InterestState();
  }
}

class InterestState extends State<Interest>{
  var formKey = GlobalKey<FormState>();
  var currency = ['Rupees', 'Dollars', 'Pounds'];
  final double padding = 7.0;
  var currentItem = '';
  var result = '';
  @override
  void initState() {
    super.initState();
    currentItem = currency[0];
  }

  TextEditingController pController = TextEditingController();
  TextEditingController rController = TextEditingController();
  TextEditingController tController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                  padding: EdgeInsets.all(padding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: pController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter principal amount';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Principal Amount',
                      hintText: 'Enter the amount',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                    ),
                  )
              ),
              Row(
                children: <Widget>[
                  Container(
                      width: padding
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: rController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter rate of interest';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Rate of interest',
                        hintText: 'Enter rate percentage',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: padding
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: tController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter time';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Time period',
                        hintText: 'Enter number of years',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: padding
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: padding*10),
                      child: Text(
                          "Select the currency :",
                          style: TextStyle(
                              fontSize: 18.0
                          )
                      )
                  ),
                  Container(
                      padding: EdgeInsets.only(top: padding, bottom: padding, left: padding*2, right: padding*10),
                      child: DropdownButton<String>(
                        items: currency.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: currentItem,
                        onChanged: (String valueSelected) {
                          dropDownItem(valueSelected);
                        },
                      )
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Calculate',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          if (formKey.currentState.validate()) {
                            this.result = calculate();
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Reset',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          reset();
                        });
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(padding * 2),
                child: Text(
                  this.result,
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
              )
            ],
          )
      ),
    );
  }

  Widget getImageAsset(){
    AssetImage assetImage = AssetImage('images/money.jpg');
    Image image = Image(
      image:assetImage,
      width: 250,
      height: 240,
    );
    return Container(
      child: image,
      margin: EdgeInsets.only(right:padding*5, left:padding*5),
    );
  }

  void dropDownItem(String newValueSelected) {
    setState(() {
      this.currentItem = newValueSelected;
    });
  }

  String calculate() {
    double p = double.parse(pController.text);
    double r = double.parse(rController.text);
    double t = double.parse(tController.text);

    double interest = (p*t*r)/100;
    double totalAmount = p + interest;

    String result ='After $t years, \nInterest = $interest $currentItem \nTotal Amount = $totalAmount $currentItem';
    return result;
  }

  void reset() {
    pController.text = '';
    rController.text = '';
    tController.text = '';
    result = '';
    currentItem = currency[0];
  }
}