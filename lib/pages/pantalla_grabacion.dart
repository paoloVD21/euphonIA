import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class PantallaGrabacion extends StatefulWidget {
  // Convertir 'key' en un super parámetro
  const PantallaGrabacion({super.key});

  @override
  State<PantallaGrabacion> createState() => _PantallaGrabacionState();
}

class _PantallaGrabacionState extends State<PantallaGrabacion> {
  final AudioRecorder audioRecorder = AudioRecorder();
  final AudioPlayer audioPlayer = AudioPlayer();

  String? recordingPath;
  bool isRecording = false;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: _recordingButton(),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (recordingPath != null)
            MaterialButton(
              onPressed: () async {
                if (audioPlayer.playing) {
                  audioPlayer.stop();
                  setState(() {
                    isPlaying = false;
                  });
                } else {
                  await audioPlayer.setFilePath(recordingPath!);
                  await audioPlayer.play();
                  setState(() {
                    isPlaying = true;
                  });
                }
              },
              color: Theme.of(context).colorScheme.primary,
              child: Text(
                isPlaying
                    ? "Detener la reproducción"
                    : "Reproducir la reproducción",
                style: const TextStyle(color: Colors.white),
              ), //Texto
            ),
          if (recordingPath == null)
            const Text(
              "Canta...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ), //Texto
        ],
      ),
    );
  }

  Widget _recordingButton() {
    return Align(
      alignment: Alignment.bottomCenter, // Centra el botón en la parte inferior
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 200.0,
          left: 30.0,
        ), // Espacio desde el borde inferior
        child: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () async {
            if (isRecording) {
              String? filePath = await audioRecorder.stop();
              if (filePath != null) {
                setState(() {
                  isRecording = false;
                  recordingPath = filePath;
                });
              }
            } else {
              if (await audioRecorder.hasPermission()) {
                final Directory appDocumentsDir =
                    await getApplicationDocumentsDirectory();
                final String filePath = p.join(
                  appDocumentsDir.path,
                  "recording.wav",
                );
                await audioRecorder.start(const RecordConfig(), path: filePath);
                setState(() {
                  isRecording = true;
                  recordingPath = null;
                });
              }
            }
          },
          child: Icon(
            isRecording ? Icons.stop : Icons.mic,
            color: Colors.deepPurple[900], // Cambia el color del icono
          ),
        ),
      ),
    );
  }
}
