import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notas_bex/core/utils/app_theme.dart';
import 'package:notas_bex/core/utils/decoration_form.dart';
import 'package:notas_bex/core/utils/validators.dart';
import 'package:notas_bex/presentation/blocs/note/note_bloc.dart';
import 'package:notas_bex/presentation/screens/login/widgets/input_decoration.dart';
import '../../../data/datasources/note_database_helper.dart';
import '../../../data/models/note_model.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note? note;

  const NoteDetailScreen({Key? key, this.note}) : super(key: key);

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  int priority = 1;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      descriptionController.text = widget.note!.description;
      contentController.text = widget.note!.content;
      priority = widget.note!.priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Nueva Nota' : 'Editar Nota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: inputDecorationLogin(
                    labelText: "Título",
                    hintText: "Título",
                  ),
                  validator: (value) {
                    return Validator.isEmpty(value, context);
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: descriptionController,
                  decoration: inputDecorationLogin(
                    labelText: "Descripción",
                    hintText: "Descripción",
                  ),
                  validator: (value) {
                    return Validator.isEmpty(value, context);
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: contentController,
                  decoration: inputDecorationLogin(
                    labelText: "Contenido",
                    hintText: "Contenido",
                  ),
                  maxLines: 5,
                  validator: (value) {
                    return Validator.isEmpty(value, context);
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<int>(
                  value: priority,
                  decoration: inputDecorationLogin(
                    labelText: "",
                    hintText: "",
                  ),
                  items: [1, 2, 3]
                      .map((level) => DropdownMenuItem(
                            value: level,
                            child: Text(
                              'Prioridad $level',
                              style: TextStyle(
                                  fontSize: 16, color: AppThemeColors.black),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      priority = value!;
                    });
                  },
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;
                    final now = DateTime.now();

                    if (widget.note == null) {
                      // Crear nueva nota
                      final newNote = Note(
                        title: titleController.text,
                        description: descriptionController.text,
                        content: contentController.text,
                        creationDate: now,
                        updateDate: now,
                        priority: priority,
                      );

                      context.read<NoteBloc>().add(AddNoteEvent(newNote));
                    } else {
                      // Actualizar nota existente
                      final updatedNote = widget.note!.copyWith(
                        title: titleController.text,
                        description: descriptionController.text,
                        content: contentController.text,
                        updateDate: now,
                        priority: priority,
                      );
                      // await dbHelper.updateNote(updatedNote);
                      context.read<NoteBloc>().add(UpdateNoteEvent(updatedNote));
                    }

                    context.pop();
                  },
                  child: Text(
                      widget.note == null ? 'Crear Nota' : 'Guardar Cambios'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
