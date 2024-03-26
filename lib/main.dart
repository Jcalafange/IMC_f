import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculadora IMC",
    theme: ThemeData(primarySwatch: Colors.green, primaryColor: Colors.red),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _textInfo = "";
  double _peso = 0;
  double _altura = 0;

  void _resetCampos() {
    _formKey.currentState!.reset();
    pesoController.clear();
    alturaController.clear();
    setState(() {
      _textInfo = "";
    });
  }

  @override
  void initState() {
    super.initState();
    pesoController.text = _peso.toStringAsFixed(1);
    alturaController.text = _altura.toStringAsFixed(1);
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      //debugPrint("$imc");
      if (imc < 18.6)
        _textInfo = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      else if (imc >= 18.6 && imc < 24.9)
        _textInfo = "Peso ideal (${imc.toStringAsPrecision(4)})";
      else if (imc >= 24.9 && imc < 29.9)
        _textInfo = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      else if (imc >= 29.9 && imc < 34.9)
        _textInfo = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      else if (imc >= 34.9 && imc < 39.9)
        _textInfo = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      else if (imc >= 40)
        _textInfo = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC",
            style: TextStyle(color: Colors.white, fontSize: 25)),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: _resetCampos,
          )
        ], //<Widget>[]
      ), // app bar
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(fontSize: 30, color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green, fontSize: 25.0),
                controller: pesoController,
                validator: (value) {
                  if (value!.isEmpty)
                    return "Insira seu peso!";
                  else
                    return null;
                },
              ),
              Slider(
                value: _peso,
                max: 200,
                label: _peso.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _peso = value;
                    pesoController.text = _peso.toStringAsFixed(1);
                  });
                },
                activeColor: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green, fontSize: 30)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: alturaController,
                validator: (value) {
                  if (value!.isEmpty)
                    return "Insira sua altura!";
                  else
                    return null;
                },
              ),
              Slider(
                value: _altura,
                max: 250,
                label: _altura.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _altura = value;
                    alturaController.text = _altura.toStringAsFixed(1);
                  });
                },
                activeColor: Colors.green,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) _calcular();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  )),
              Text(
                _textInfo,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ], //<widget>[]
          ),
        ),
      ),
    );
  }
}
