import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notas_bex/core/utils/app_theme.dart';
import 'package:notas_bex/presentation/blocs/note/note_bloc.dart';
import 'package:notas_bex/presentation/screens/notes/note_detail_screen.dart';
import 'package:notas_bex/presentation/widgets/custom_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navegar a la pantalla de detalle de la nota para crear una nueva
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NoteDetailScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const CustomAppbar(title: 'Notas'),
          Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            height: size.height * 0.45,
            child: BlocBuilder<NoteBloc, NoteState>(
              builder: (context, state) {
                if (state is NoteLoadSuccess) {
                  // Filtrar las notas por prioridad

                  return Column(
                    children: [
                      ItemCountNotes(
                        title: 'Alta',
                        count: context.read<NoteBloc>().notePriority1,
                      ),
                      ItemCountNotes(
                        title: 'Media',
                        count: context.read<NoteBloc>().notePriority2,
                      ),
                      ItemCountNotes(
                        title: 'Baja',
                        count: context.read<NoteBloc>().notePriority3,
                      ),
                      const SizedBox(height: 30),
                      Card(
                        elevation: 2,
                        child: ListTile(
                          title: const Text('Notas'),
                          subtitle: Text(
                              'Total de notas : ${context.read<NoteBloc>().noteList.length}'),
                        ),
                      ),
                    ],
                  );
                } else if (state is NoteLoading) {
                  return const CircularProgressIndicator();
                } else if (state is NoteLoadFailure) {
                  return const Text('Error al cargar las notas');
                } else {
                  return const Text('No se encontraron notas');
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class ItemCountNotes extends StatelessWidget {
  const ItemCountNotes({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(Icons.note,
            color: title == 'Alta'
                ? AppThemeColors.red
                : title == 'Media'
                    ? AppThemeColors.orange
                    : AppThemeColors.green),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Notas con prioridad $title'),
            Text('($count)',
                style: TextStyle(
                    color: title == 'Alta'
                        ? AppThemeColors.red
                        : title == 'Media'
                            ? AppThemeColors.orange
                            : AppThemeColors.green)),
          ],
        ),
        onTap: () {
          // Aquí puedes implementar la navegación a la pantalla que muestra las notas de la prioridad seleccionada.
        },
      ),
    );
  }
}
