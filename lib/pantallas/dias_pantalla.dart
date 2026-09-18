import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class DiasPantalla extends StatefulWidget {
  const DiasPantalla({super.key});

  @override
  State<DiasPantalla> createState() => _DiasPantallaState();
}

class _DiasPantallaState extends State<DiasPantalla> {
   final TextEditingController textEditingController= TextEditingController();
   final TextEditingController textoTareaControlador= TextEditingController();
    final TextEditingController textoTareaControlador1= TextEditingController();

 bool _isListening = false;
 late stt.SpeechToText _speech;

    List<String> tareas=[];
   List<String> tarde =[];
      List<String> noche =[];


  @override
  void initState(){
  super.initState();
  _speech = stt.SpeechToText();
 }

void _escucharVoz()  async {
  if (!_isListening) {
    bool disponible = await _speech.initialize(
      onStatus: (status) => print('Estado: $status'),
      onError: (error) => print('Error: $error'),
    );
    if (disponible) {
      setState(()  => _isListening = true );
      _speech.listen(
        onResult: (result){
          setState(() {
            textEditingController.text =result.recognizedWords;
          });
        
      },
      );
    }
  
} else {
setState(() => _isListening = false );
_speech.stop(); 
  
}
}



void agregarTarea () {
  setState(() {
    tareas.add(textEditingController.text);
    textEditingController.clear();
  });

}
void borrarTarea (int index){
setState(() {
  tareas.removeAt(index);
});
}

void ponerTarea () {
  setState(() {
    tarde.add(textoTareaControlador.text);
    textoTareaControlador.clear();
  });

}
void eliminarTarea (int index){
setState(() {
  tarde.removeAt(index);
});
}

void ingresarTarea () {
  setState(() {
    noche.add(textoTareaControlador1.text);
    textoTareaControlador1.clear();
  });

}
void limpiartarea (int index){
setState(() {
  noche.removeAt(index);
});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.blueAccent,

      appBar: AppBar(
        title: const Text('LISTA DE TAREAS', ),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
            controller: textEditingController,
            decoration:  InputDecoration(
              labelText: 'Escribe una tarea',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                 icon: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  color: _isListening ? Colors.red : Colors.grey,
                 ),
                 onPressed: _escucharVoz,
                 ),
            
              prefixIcon: Icon(Icons.person),
            ),
            ),
            ElevatedButton.icon(onPressed: (){},label: Text('Mañana'),),
            
            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 196, 163, 17),
                foregroundColor: Colors.black,
              ),
              onPressed: agregarTarea, child: Text('Agregar')),
            Expanded(
              child: ListView.builder(
                itemCount: tareas.length,
               itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tareas[index]),
               trailing: IconButton(
                icon: const Icon(Icons.delete, color: Color.fromARGB(255, 104, 70, 196)), 
                onPressed: () => borrarTarea(index),
                ),
                );
               },
                ),
              ),
              
         
              
              ElevatedButton.icon(onPressed: (){},label: Text('Tarde'),),
              TextField(
                   controller: textoTareaControlador,
            decoration:  InputDecoration(
              labelText: 'Escribe una tarea',
               border: OutlineInputBorder(),
              suffixIcon: IconButton(
                 icon: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  color: _isListening ? Colors.red : Colors.grey,
                 ),
                   onPressed: _escucharVoz,
              ),
              ),
              ),
                   ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 196, 163, 17),
                foregroundColor: Colors.black,
              ),
              onPressed: ponerTarea, child: Text('Agregar')),
               Expanded(
              child: ListView.builder(
                itemCount: tarde.length,
               itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tarde[index]),
               trailing: IconButton(
                icon: const Icon(Icons.delete, color: Color.fromARGB(255, 104, 70, 196)), 
                onPressed: () => eliminarTarea(index),
                ),
                );
               },
                ),
              ),
               ElevatedButton.icon(onPressed: (){},label: Text('Noche'),),
              TextField(
                   controller: textoTareaControlador1,
            decoration:  InputDecoration(
              labelText: 'Escribe una tarea',
               border: OutlineInputBorder(),
              suffixIcon: IconButton(
                 icon: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  color: _isListening ? Colors.red : Colors.grey,
                 ),
                   onPressed: _escucharVoz,
              ),
              ),
              ),
                   ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 196, 163, 17),
                foregroundColor: Colors.black,
              ),
              onPressed: ingresarTarea, child: Text('Agregar')),
               Expanded(
              child: ListView.builder(
                itemCount: noche.length,
               itemBuilder: (context, index) {
                return ListTile(
                  title: Text(noche[index]),
               trailing: IconButton(
                icon: const Icon(Icons.delete, color: Color.fromARGB(255, 104, 70, 196)), 
                onPressed: () => limpiartarea(index),
                ),
                );
               },
                ),
              ),
              
          ],
          
        ),
      ),
    );
  }
}