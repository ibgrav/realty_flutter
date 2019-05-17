import 'package:flutter/material.dart';
import './glob.dart' as glob;
import './main.dart' as main;

class IncomePage extends StatefulWidget {
  IncomePage({Key key}) : super(key: key);

  @override
  _IncomePagePageState createState() => _IncomePagePageState();
}

class _IncomePagePageState extends State<IncomePage> {
  String monthDropValue = 'May';
  String yearDropValue = '2019';

  @override
  Widget build(BuildContext context) {
    FloatingActionButton actionButton = FloatingActionButton(
      onPressed: () {
        // Add your onPressed code here!
      },
      child: Icon(Icons.add_circle_outline),
      backgroundColor: Colors.pink,
    );

    return main.mainLayout(
      context,
      'Income',
      'back',
      actionButton,
      Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 40),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DecoratedBox(
                    decoration: glob.boxDec(0xFFEFEFEF),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          elevation: 0,
                          iconSize: 40,
                          style: glob.subHeadStyle('dark'),
                          value: monthDropValue,
                          onChanged: (String newValue) {
                            setState(() {
                              monthDropValue = newValue;
                            });
                          },
                          items: glob.monthArray
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: DecoratedBox(
                    decoration: glob.boxDec(0xFFEFEFEF),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          elevation: 5,
                          iconSize: 40,
                          style: glob.subHeadStyle('dark'),
                          value: yearDropValue,
                          onChanged: (String newValue) {
                            setState(() {
                              yearDropValue = newValue;
                            });
                          },
                          items: glob.incomeYears
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: SingleChildScrollView(
                      child: incomeBoxBuilder(
                          context, monthDropValue, yearDropValue))),
            ),
          ],
        ),
      ),
    );
  }
}

Column incomeBoxBuilder(context, month, year) {
  List<Widget> returnData = [];
  String monthIndex = glob.monthArray.indexOf(month).toString();
  for (var item in glob.incomeData) {
    print(item['data'][year][monthIndex]);
    bool noteCheck = false;
    String note;
    int val = item['data'][year][monthIndex]['val'];
    bool rec = item['data'][year][monthIndex]['rec'];
    if (item['data'][year][monthIndex]['note'] is String) {
      noteCheck = true;
      note = item['data'][year][monthIndex]['note'];
    }

    returnData.add(GestureDetector(
      onTap: () {
        // glob.pushMember(context, income.IncomePage());
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        width: glob.width(context, 0.85),
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        decoration: glob.boxDec(0xFFBDD9C0),
        child: Column(
          children: [
            Text(
              item['name'],
              style: glob.subHeadStyle('dark'),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color(0xFF425464),
                ),
                height: 3,
              ),
            ),
            Container(height: 20),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  Text('Total: \$' + val.toString()),
                  SizedBox(height: 20),
                  rec ? Text('Reoccuring Income') : Text('Not Reoccuring'),
                  SizedBox(height: 20),
                  noteCheck ? Text('Note: ' + note) : Text('No Note'),
                  SizedBox(height: 20)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: glob.boxDec(0xFFEFEFEF),
                    child: Text(
                      'Add Income',
                      style: glob.subHeadStyle('dark'),
                    ),
                  ),
                  onTap: () async {
                    await showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (_) => EditPopUp(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));
    returnData.add(SizedBox(height: 20));
  }
  return Column(children: returnData);
}

class EditPopUp extends StatefulWidget {
  EditPopUp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditPopUpState();
}

class EditPopUpState extends State<EditPopUp>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 0));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.linear);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final logoutButton = Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(6.0),
      color: Color(0xFF5C748A),
      child: MaterialButton(
        height: 40,
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });

          setState(() {
            Navigator.pop(context);
            _isLoading = false;
          });
        },
        child: Text(
          "Logout",
          textAlign: TextAlign.center,
          style: glob.subHeadStyle('light'),
        ),
      ),
    );

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Center(
            child: Material(
              color: Colors.transparent,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Container(
                  height: glob.height(context, 0.5),
                  width: glob.width(context, 0.85),
                  decoration: ShapeDecoration(
                      color: Color(0xFFEFEFEF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: logoutButton),
                ),
              ),
            ),
          );
  }
}
