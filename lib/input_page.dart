import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reusable_card.dart';
import 'constants.dart';
import 'results_page.dart';
import 'calculator_brain.dart';
class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Color inactiveCardColourM = Color(0xFF101427);
  Color inactiveCardColourF = Color(0xFF101427);
  int cCM =1;
  int cCF=1;
  int height =180;
  int weight = 60;
  int age=10;

  //colourCondition =1 ---> inactive
  updateColourM(int colourCondition) {
      if (colourCondition == 1 && cCF==2) {
          inactiveCardColourM = kActiveCardColour;
          cCM++;
          inactiveCardColourF=Color(0xFF101427);
          cCF--;
      }
      else if(colourCondition ==1 && cCF==1){
        inactiveCardColourM = kActiveCardColour;
        cCM++;
      }
      else if (colourCondition == 2) {
        inactiveCardColourM = Color(0xFF101427);
        cCM--;
      }
  }
    updateColourF(int colourCondition){
      if(colourCondition ==1 && cCM==2){
          inactiveCardColourF = kActiveCardColour;
          cCF++;
            inactiveCardColourM=Color(0xFF101427);
            cCM--;
      }
      else if(colourCondition ==1 && cCM==1){
        inactiveCardColourF = kActiveCardColour;
        cCF++;
      }
      else if(colourCondition==2){
        inactiveCardColourF=Color(0xFF101427);
        cCF--;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap:(){
                        setState(() {
                          updateColourM(cCM);
                        });

                    },
                  child: ReusableCard(
                    colour: inactiveCardColourM,
                    cardChild:
                        IconContent(ic: FontAwesomeIcons.mars, gender: 'MALE'),
                  ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                onTap: (){
                    setState(() {
                      updateColourF(cCF);
                    });
                    },
                  child: ReusableCard(
                    colour: inactiveCardColourF,
                    cardChild: IconContent(
                      ic: FontAwesomeIcons.venus,
                      gender: 'FEMALE',
                    ),
                  ),
                ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(colour: kActiveCardColour,
                  cardChild:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'HEIGHT      ',
                          style: kLabelTextStyle
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            height.toString(),style: kNumberTextStyle,
                          ),
                          Text(
                            'cm',style: kLabelTextStyle,
                          ),
    ]
    ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.white,
                              thumbColor: Color(0xFFEB1555),
                              overlayColor: Color(0x29EB1555),
                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                              overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0)
                            ),
                            child: Slider(
                              value: height.toDouble(),
                              min: 120.0,
                              max: 220.0,
                              inactiveColor: Color(0xFF8D8E98),
                              onChanged: (double newValue) {
                                setState(() {
                                  height= newValue.round();
                                });
                            },
                            ),
                          )


                    ],
                  )),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Text (
                          weight.toString(),
                          style: kNumberTextStyle
                          ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(icon: FontAwesomeIcons.minus,
                              onPressed: (){
                              setState(() {
                                weight--;
                              });
                              }
                              ,),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(icon: FontAwesomeIcons.plus,
                            onPressed: (){
                              setState(() {
                                weight++;
                              });
                            },),
                          ],
                        ),
                      ],

                    )
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          Text(
                            'AGE',
                            style: kLabelTextStyle,
                          ),
                          Text (
                              age.toString(),
                              style: kNumberTextStyle
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundIconButton(icon: FontAwesomeIcons.minus,
                                onPressed: (){
                                  setState(() {
                                    age--;
                                  });
                                }
                                ,),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(icon: FontAwesomeIcons.plus,
                                onPressed: (){
                                  setState(() {
                                    age++;
                                  });
                                },),
                            ],
                          ),
                        ],

                      )
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              CalculatorBrain cB = new CalculatorBrain(height: height,weight: weight);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ResultsPage(
                  bmiResult: cB.calculateBMI(),
                  inter: cB.getInterpretation(),
                  result: cB.getResult()
              ),
              ),
              );
            },

            child: Container(
              child: Center(
                child: Text(
                  'CALCULATE',
                  style: TextStyle(
                    color:Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
              height: kBottomContainerHeight,
              width: double.infinity,
              color: kBottomContainerColour,
              margin: EdgeInsets.only(top: 10.0),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon,@required this.onPressed});
  final IconData icon;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      onPressed: onPressed,
      elevation: 0.0,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}
