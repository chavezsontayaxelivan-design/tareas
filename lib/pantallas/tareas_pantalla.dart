import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class TareasPantalla extends StatefulWidget {
  const TareasPantalla({super.key});

  @override
  State<TareasPantalla> createState() => _TareasPantallaState();
}

class _TareasPantallaState extends State<TareasPantalla> {
 final TextEditingController textEditingController= TextEditingController();

 bool _isListening = false;
 
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
 late stt.SpeechToText _speech;

   List<String> tareas=[];
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
            ElevatedButton.icon(onPressed: (){},label: Text('Eleminar'),),
            
            SizedBox(height: 25),

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
          ],
          
        ),
      ),
    );
  }
}