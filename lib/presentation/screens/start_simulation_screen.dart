import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:central_nuclear/presentation/widgets/widgets.dart';

class StartSimulationScreen extends StatelessWidget {
  const StartSimulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text('Start Stimulation'),
      ),

      body: _BodyView(),

    );
  }
}

// * WIDGET BODY VIEW
class _BodyView extends StatelessWidget {
  const _BodyView();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          
          // * WIDGET QUE CONTRUYE UNA IMAGEN
          ImageAssetWidget(
            width: 0.75, 
            height: 0.32, 
            borderRadiusValue: 10, 
            image: 'assets/images/start-simulation-image.png', 
            borderWidthValue: 1, 
            colorBorder: Colors.white12
          ),
                  
          SizedBox(height: size.height * 0.02,),
          
          // * WIDGET QUE CONSTRUYE EL TITULO 
          Text(
            'SIMULACRO DE PARADA',
            style: textTheme.bodyLarge?.copyWith( 
              fontSize: size.width * 0.055, 
              fontWeight: FontWeight.bold 
            ),
          ),

          // * WIDGET QUE CONSTRUYE LAS INSTRUCCIONES
          _InstructionsView(size: size, textTheme: textTheme),

          SizedBox(height: size.height * 0.01,),

          // * WIDGET QUE CONSTRUYE UN FILLED BUTTON PERSONALIZADO
          FilledButtonWidget(
            width: 0.7, 
            height: 0.07, 
            onPressed: () {
              context.push('home');
              HapticFeedback.mediumImpact();
            },
            borderRadiusValue: 10, 
            colorButton: Colors.green.shade800, 
            textButton: 'Iniciar Simulacion', 
            iconButton: Icons.play_arrow_rounded, 
            colorText: Colors.white, 
            colorIcon: Colors.white,
          ),

          SizedBox(height: size.height * 0.1,),

        ],
      ),
    );
  }
}

// * IWDGET QUE CONTIENE LAS INSTRUCCIONES DE LA SIMULACION
class _InstructionsView extends StatelessWidget {
  const _InstructionsView({
    required this.size,
    required this.textTheme,
  });

  final Size size;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.01),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          border: Border.all(width: size.width * 0.004, color: Colors.white24),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
    
            SizedBox(height: size.height * 0.02,),

            // * WIDGET TEXT QUE MUESTRA EL OBJETIVO
            Padding(
              padding: EdgeInsetsGeometry.only(left: size.width * 0.07, right: size.width * 0.07),
              child: Text(
                'Objetivo · 00:30',
                style: textTheme.bodyMedium?.copyWith( color: Colors.yellow.shade800 ),
              ),
            ),
    
            SizedBox(height: size.height * 0.01,),
            
            // * WIDGET QUE MUESTRA TEXT PRE A LAS INSTRUCCIONES
            Padding(
              padding: EdgeInsetsGeometry.only(left: size.width * 0.07, right: size.width * 0.07),
              child: Text(
                'Ejecute los 5 pasos antes de que el cronometro llegue a 0s.',
                style: textTheme.bodyMedium,
              ),
            ),
            
            // * WIDGET DIVIDER PERSONALIZADO
            DividerWidget(
              start: 0.075, 
              end: 0.075, 
              height: 0.03, 
              colorDivider: Colors.grey.shade700, 
              borderRadiusValue: 20,
            ),
                
            SizedBox(height: size.height * 0.01),

            // * LISVIEWBUILDER QUE CONSTRUYE CADA ELEMENTO DE LA LIST
            InstructionsListWidget(),

            // * WIDGET DIVIDER
            DividerWidget(
              start: 0.075, 
              end: 0.075, 
              height: 0.03, 
              colorDivider: Colors.grey.shade700, 
              borderRadiusValue: 20,
            ),
          
            // * WIDGET QUE MUESTRA LAS CONDICIONES DE LA SIMULACION
            Padding(
              padding: EdgeInsetsGeometry.only(left: size.width * 0.07, right: size.width * 0.02),
              child: Text(
                'Mantener la temperatura < 400 C usando los controles de agua. Si supera los 500 C o se agota el tiempo, el nucleo colapsa.',
                style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
            ),
    
            SizedBox(height: size.height * 0.02,),
    
         ],
        ),
      ),
    );
  }
}
