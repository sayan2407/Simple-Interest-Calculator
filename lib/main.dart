
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(
    title: 'Simple Interest Calculator',
    debugShowCheckedModeBanner: false,
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.amber,
      accentColor: Colors.amber,
    ),
  ));
}
class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return SIFormState();
  }

}
class SIFormState extends State<SIForm>
{
  var _currencies = ["Rupees" , " Dollar","Pounds", " Others"] ;
  var _currentItemSelected = '';
  @override
  void initState()
  {
    super.initState();
     _currentItemSelected = _currencies[0];
  }
  TextEditingController principleController = TextEditingController();
  TextEditingController roController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayresult = '';
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.amber,
       title: Text(
         "Simple Interest Calculator",
             style: TextStyle(
           color: Colors.white,
               fontSize: 16.0,
       ),
       ),
     ),
     body: Form(
       key: _formKey,
       child:Padding(
       padding: EdgeInsets.all(10.0),
       child: ListView(
         children: [
           getImageAsset(),
           Padding(
             padding: EdgeInsets.only(top: 10.0),
             child:  TextFormField(
               keyboardType: TextInputType.number,
               controller: principleController,
               validator: (String value){
                 if(value.isEmpty)
                   {
                     return 'Please Enter Principle Amount' ;
                   }
               },
               decoration: InputDecoration(
                   labelText: 'Principle',
                   hintText: 'Enter principle amount',
                   errorStyle: TextStyle(
                     color: Colors.red,
                     fontSize: 15.0,
                   ),

                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(5.0),
                   )
               ),

             ),
           ),

           Padding(
             padding: EdgeInsets.only(top: 15.0),
             child:  TextFormField(
               controller: roController,
               validator: (String value){
                 if(value.isEmpty)
                   {
                     return 'Please Enter Rate Of Interest' ;
                   }
               },
               keyboardType: TextInputType.number,
               decoration: InputDecoration(
                   labelText: 'Interest',
                   hintText: 'Enter Rate Of Interest',
                   errorStyle: TextStyle(
                     color: Colors.red,
                     fontSize: 15.0,
                   ),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(5.0),
                   )
               ),

             ),
           ),
           Padding(
             padding: EdgeInsets.only(top: 15.0),
             child: Row(
               children: [
                 Expanded(
                   child: TextFormField(
                     keyboardType: TextInputType.number,
                     validator: (String value){
                       if(value.isEmpty)
                         {
                           return 'Please Enter Time In Years' ;
                         }
                     },
                     controller: termController,
                     decoration: InputDecoration(
                         labelText: 'Term',
                         hintText: 'Time in years',
                         errorStyle: TextStyle(
                           color: Colors.red,
                           fontSize: 15.0,
                         ),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5.0),
                         )
                     ),
                   ) ,
                 ),
                 Container(
                   width: 20.0,
                 ),
                 Expanded(
                   child: DropdownButton<String>(

                     items:
                     _currencies.map((String dropDownStringItem) {
                       return DropdownMenuItem<String>(
                         value: dropDownStringItem,
                         child: Text(dropDownStringItem),
                       );
                     }).toList(),

                     onChanged: (String newValue){
                       _onDropDownItemSelected(newValue);
                     },
                     value: _currentItemSelected,
                   ),
                 )

               ],
             ) ,
           ),
           Padding(
             padding: EdgeInsets.only(top: 15.0),
             child:   Row(
               children: [
                 Expanded(
                   child: RaisedButton(
                     color: Colors.amber,
                     elevation: 6.0,
                     onPressed: (){

                          setState(() {
                            if(_formKey.currentState.validate()){
                              this.displayresult = _calculateTotal();
                            }

                          });
                     },
                     child: Text(
                       "Calculate",
                       style: TextStyle(
                         color: Colors.white,
                       ),
                     ),

                   ) ,
                 ),
                 Container(
                   width: 20.0,
                 ),
                 Expanded(
                   child: RaisedButton(
                     color: Colors.lightBlueAccent,
                     elevation: 6.0,
                     onPressed: (){
                         setState(() {
                           _reset();
                         });
                     },
                     child: Text(
                       "Reset",
                       style: TextStyle(
                         color: Colors.white,
                       ),
                     ),
                   ) ,
                 ),



               ],
             ),
           ),
           Padding(
             padding: EdgeInsets.all(15.0),
             child: Text(
               this.displayresult,
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 16.0
               ),
             ),
           )

         ],
       )),

     ),
   );
  }
  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/poster.png');
    Image image = Image(image: assetImage, width: 100.0, height: 100.0,);
    return Container(child: image, margin: EdgeInsets.all(10.0),);
  }

  void  _onDropDownItemSelected(String value)
  {
    setState(() {
      this._currentItemSelected=value;
      this._currentItemSelected = value;
    });
  }

  String  _calculateTotal()
  {
    double principle =double.parse(principleController.text);
    double ro =double.parse(roController.text);
    double time = double.parse(termController.text);

    double totalAmount = principle +  (principle * ro * time ) /100 ;

    String result = 'After $time years , your investment will be worth $totalAmount $_currentItemSelected' ;

    return result ;
  }

  void  _reset()
  {
    principleController.text='';
    roController.text='';
    termController.text='';
    displayresult='';
    _currentItemSelected = _currencies[0];
  }

}


/*class SIFormState extends State<SIForm> {
  var _currencies = ["Rupees", "Dollar", "Pound"];
  var _currentItemSelected = "Rupees";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(
            "Simple Interest Calculator",
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          backgroundColor: Colors.amber,

        ),
        body: Container(
        padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0,
        bottom: 15.0),
    child: ListView(
    children: [
    getImageAsset(),
    Padding(
    padding: EdgeInsets.only(top: 15.0),
    child:TextField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
    labelText: 'Principal',
    hintText: 'Enter principle amount e.g 10000',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0)
    )
    ),
    ),
    ),
    Padding(
    padding: EdgeInsets.only(top: 15.0),
    child: TextField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
    labelText: 'Rate Of Interest',
    hintText: 'Enter Interest',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0)
    )
    ),
    ),
    ),
    Padding(
    padding: EdgeInsets.only(top: 15.0),
    child: Row(
    children: [
    Expanded(
    child: TextField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
    labelText: 'Term',
    hintText: 'Time in Years',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0)
    )
    ),
    ),
    ),
    Container(
    width: 20.0,
    )
    ,
    Expanded
    (
    child
    :
  }

  ,
  ),
  ),
  ],
  ),
  ),
  Padding

  (

  padding

      :

  EdgeInsets.only

  (

  top

      :

  15.0

  )

  ,

  child

      :

  Row

  (

  children

      :

  [

  Expanded

  (

  child

      :

  RaisedButton

  (

  color

      :

  Colors.amber

  ,

  elevation

      :

  6.0

  ,

  padding

      :

  EdgeInsets.all

  (

  10.0

  )

  ,

  child

      :

  Text

  (

  "

  Calculate

  "

  ,

  textDirection

      :

  TextDirection.ltr

  ,

  style

      :

  TextStyle

  (

  color

      :

  Colors.white

  ,

  //   backgroundColor: Colors.lightBlueAccent
  )

  ,

  )

  ,

  onPressed

      : (){
  //action
  },

  )

  ,

  )

  ,

  Container

  (

  width

      :

  20.0

  ,

  )

  ,

  Expanded

  (

  child

      :

  RaisedButton

  (

  elevation

      :

  6.0

  ,

  color

      :

  Colors.lightBlue

  ,

  padding

      :

  EdgeInsets.all

  (

  10.0

  )

  ,

  child

      :

  Text

  (

  "

  Reset

  "

  ,

  textDirection

      :

  TextDirection.ltr

  ,

  style

      :

  TextStyle

  (

  color

      :

  Colors.white

  ,

  //            backgroundColor: Colors.lightBlueAccent
  )

  ,

  )

  ,

  onPressed

      : (){
  //action
  },
  ),
  ),

  ],
  ),
  ),

  Padding

  (

  padding

      :

  EdgeInsets.only

  (

  top

      :

  15.0

  )

  ,

  child

      :

  Text

  (

  "Result show here"
  ),
  )


  ],
  ),
  ),

  );
} */



