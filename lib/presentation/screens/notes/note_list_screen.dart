// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notas_bex/core/utils/app_theme.dart';
import 'package:notas_bex/presentation/blocs/note/note_bloc.dart';
import 'package:notas_bex/presentation/widgets/custom_bar_widget.dart';
import 'note_detail_screen.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              const CustomAppbar(title: 'Notas'),
              Container(
                padding: const EdgeInsets.all(10),
                child:
                    //buscador de notas
                    TextField(
                  decoration: const InputDecoration(
                    hintText: 'Buscar nota...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        // _loadNotes();
                        context.read<NoteBloc>().add(LoadNotesEvent());
                        return;
                      }

                      context.read<NoteBloc>().noteListFilter = context
                          .read<NoteBloc>()
                          .noteList
                          .where((note) =>
                              note.title
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              note.description
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
              context.read<NoteBloc>().noteListFilter.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/empty_notes.png',
                              width: 300),
                          const Text("Crea tu primera nota!",
                              style: TextStyle(
                                  fontSize: 20, fontFamily: 'Roboto')),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount:
                            context.read<NoteBloc>().noteListFilter.length,
                        itemBuilder: (context, index) {
                          final note =
                              context.read<NoteBloc>().noteListFilter[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                              color: note.priority == 1
                                  ? AppThemeColors.green
                                  : note.priority == 2
                                      ? AppThemeColors.orange
                                      : AppThemeColors.red,
                              elevation: 2.0,
                              child: ListTile(
                                title: Text(
                                  note.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    color: AppThemeColors.primary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      note.description,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Roboto',
                                          color: AppThemeColors.black),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                        'Última actualización: ${note.updateDate.day}/${note.updateDate.month}/${note.updateDate.year}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Roboto',
                                            color: AppThemeColors.black)),
                                  ],
                                ),
                                onTap: () async {
                                  // Navegar a la pantalla de detalle de la nota para editarla
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NoteDetailScreen(note: note)),
                                  );
                                  // _loadNotes(); // Recargar la lista de notas después de editar
                                },
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: AppThemeColors.primary,
                                  ),
                                  onPressed: () async {
                                    //mostramos un modal de confirmación
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 5, sigmaY: 5),
                                          child: AlertDialog(
                                            actionsAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            //tamanio del dialog
                                            insetPadding:
                                                const EdgeInsets.all(10),
                                            title: const Center(
                                                child: Text('Eliminar nota')),
                                            content: const Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Center(
                                                  child: Text(
                                                      '¿Estás seguro de eliminar esta nota?'),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              // TextButton(
                                              //   onPressed: () {
                                              //     Navigator.pop(context);
                                              //   },
                                              //   child: const Text('Cancelar'),
                                              // ),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    minimumSize:
                                                        const Size(100, 50),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20,
                                                        vertical: 6),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child:
                                                      const Text('Cancelar')),

                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppThemeColors.primary,
                                                    minimumSize:
                                                        const Size(100, 50),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20,
                                                        vertical: 6),
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<NoteBloc>()
                                                        .add(DeleteNoteEvent(
                                                            note.id!));
                                                    Navigator.pop(context);
                                                  },
                                                  child:
                                                      const Text('Eliminar')),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              context.go('/note-detail');
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
