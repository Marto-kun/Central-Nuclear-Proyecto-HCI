import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartInstructionsScreen extends StatelessWidget {
  const StartInstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instrucciones'),
        centerTitle: true,
      ),

      body: _BodyView(),
    );
  }
}

class _BodyView extends StatelessWidget {
  const _BodyView();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        children: [

          //
          SizedBox(

            width: size.width * 0.5,
            height: size.height * 0.25,

            // decoration: BoxDecoration(
            //   border: Border.all( width: 1, color: Colors.white24 ),
            //   borderRadius: BorderRadius.circular(10),
            // ),

            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(10),
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox( height: size.height * 0.05, ),

          // 

          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1. Detener las turbinas de generacion electrica.'),
                Text('2. Ventilar el contenido radioactivo.'),
                Text('3. Evacuar el agua caliente e ingresar nueva.'),
                Text('4. Apagar el reactor.'),
                Text('5. Presionar el boton de detenido de emergencia.'),
              ],
            ),
          ),
          
          SizedBox( height: size.height * 0.05, ),

          // 
          
          FilledButton.icon(
            onPressed: () => context.push('simulation'), 
            label: Text('Iniciar'),
            icon: Icon(Icons.play_arrow_rounded),
          ),

        ],
      ),
    );
  }
}