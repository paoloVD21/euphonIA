import 'package:flutter/material.dart';
import 'pages/pantalla_grabacion.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Euphonia App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),
    );
  }
}

// Pantalla de bienvenida (Splash Screen)
class WelcomeScreen extends StatelessWidget {
  // Añadir 'key' como parámetro al constructor
  const WelcomeScreen({super.key}); // <-- Aquí agregamos el parámetro 'key'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Icono de la app
            Image.asset(
              'assets/images/IconoEuphonia.jpg',
              width: 80,
              height: 80,
            ),
            SizedBox(height: 20),
            Text(
              'EuphonIA',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 50),
            // Botón de comenzar
            ElevatedButton(
              onPressed: () {
                // Navega hacia la otra pantalla
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaGrabacion(),
                  ), // Redirigiendo a la nueva pantalla
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors
                        .orange, // Usamos 'backgroundColor' en lugar de 'primary'
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // Borde redondeado
                ),
              ),
              child: Text(
                'Comenzar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[900],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
