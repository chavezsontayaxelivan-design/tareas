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

 bool _isListeningDia = false;
 bool _isListeningTarde = false;
 bool _isListeningNoche = false;
 
 late stt.SpeechToText _speechDia;
 late stt.SpeechToText _speechTarde;
 late stt.SpeechToText _speechNoche;

    List<String> tareas=[];
    List<String> tarde =[];
    List<String> noche =[];


  @override
  void initState(){
  super.initState();
  _speechDia = stt.SpeechToText();
  _speechTarde= stt.SpeechToText();
  _speechNoche= stt.SpeechToText();
 }

void _escucharVozDia()  async {
  if (_isListeningTarde) {
    setState(()  => _isListeningTarde = false);
    _speechTarde.stop();
    
  }
  if(_isListeningNoche){
    setState(() => _isListeningNoche = false);
    _speechNoche.stop();
    } 
    if(!_isListeningDia){
  
    bool disponible = await _speechDia.initialize(
      onStatus: (status) => print('Estado: $status'),
      onError: (error) => print('Error: $error'),
    );
    if (disponible) {
      setState(()  => _isListeningDia = true );
      _speechDia.listen(
        onResult: (result){
          setState(() {
            textEditingController.text =result.recognizedWords;
          });
        
      },
      );
    }
  
} else {
setState(() => _isListeningDia= false );
_speechDia.stop(); 
}
}


void _escucharVozTarde()  async {
   if (_isListeningDia) {
    setState(()  => _isListeningDia = false);
    _speechDia.stop();
    
  }
  if(_isListeningNoche){
    setState(() => _isListeningNoche = false);
    _speechNoche.stop();
    } 

    if(!_isListeningTarde){


    bool disponible = await _speechTarde.initialize(
      onStatus: (status) => print('Estado: $status'),
      onError: (error) => print('Error: $error'),
    );
    if (disponible) {
      setState(()  => _isListeningTarde = true );
      _speechTarde.listen(
        onResult: (result){
          setState(() {
            textoTareaControlador.text =result.recognizedWords;
          });
        
      },
      );
    }
  
} else {
setState(() => _isListeningTarde= false );
_speechTarde.stop(); 
  
}
}




void _escucharVozNoche()  async {

  if (_isListeningDia) {
    setState(()  => _isListeningDia = false);
    _speechDia.stop();
    
  }
  if(_isListeningTarde){
    setState(() => _isListeningTarde = false);
    _speechTarde.stop();
    } 
    if(!_isListeningNoche){
  
    bool disponible = await _speechNoche.initialize(
      onStatus: (status) => print('Estado: $status'),
      onError: (error) => print('Error: $error'),
    );
    if (disponible) {
      setState(()  => _isListeningNoche= true );
      _speechNoche.listen(
        onResult: (result){
          setState(() {
            textoTareaControlador1.text =result.recognizedWords;
          });
        
      },
      );
    }
  
} else {
setState(() => _isListeningNoche= false );
_speechNoche.stop(); 
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
                  _isListeningDia ? Icons.mic : Icons.mic_none,
                  color: _isListeningDia ? Colors.red : Colors.grey,
                 ),
                 onPressed: _escucharVozDia,
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
                  _isListeningTarde? Icons.mic : Icons.mic_none,
                  color: _isListeningTarde ? Colors.red : Colors.grey,
                 ),
                   onPressed: _escucharVozTarde,
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
                  _isListeningNoche? Icons.mic : Icons.mic_none,
                  color: _isListeningNoche ? Colors.red : Colors.grey,
                 ),
                   onPressed: _escucharVozNoche
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