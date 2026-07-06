import 'package:flutter/material.dart';

import '../../config/domain/domain.dart';


// * LISTA DE ELEMENTOS DE NUESTRA ENTIDAD INSTRUCTIONS 
final List<Instruction> instructions = [
  Instruction(text: 'Detener turbinas'),
  Instruction(text: 'Ventilar nucleo'),
  Instruction(text: 'Estabilizar agua'),
  Instruction(text: 'Apagar reactor'),
  Instruction(text: 'Parada de Emergencia'),
];

class InstructionsListWidget extends StatelessWidget {
  const InstructionsListWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: size.height * 0.15,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: instructions.length,
        itemBuilder: (context, index) {
          final instruction = instructions[index];
  
          return Padding(
            padding: EdgeInsetsGeometry.only(left: size.width * 0.07),
            child: Text(
              '${index + 1} · ${instruction.text}',
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}