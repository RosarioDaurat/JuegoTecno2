import TUIO.*;
TuioProcessing tuioClient;
import ddf.minim.*;
import fisica.*;

Minim minim;
AudioPlayer musiquita, Viento, caida;

int tiempo, cant = 2, t = 10;
String estado = "portada";
PImage alerta, portada, portadaTipito, viento, pajaritos, pajaritos2, pajaritopabajo, pajaritopabajo2
  , instruccion1, instruccion2, instruccion3, control, barra;
PImage [] flecha = new PImage [3];
PImage [] flechaIzq = new PImage [3];
float x, y, momentoViento, posY, posY2, contadorViento;
float xEstado = 0;
boolean Arriba;

Pajaros [] pajaros;
Pajaros [] pajaros2;
Particulas [] particulas;
FWorld mundo;
Fondos fondos;
Tipito tipito;
Avioneta avion;

Reiniciar reiniciar;



void setup() {
  size(1000, 800);
  tuioClient  = new TuioProcessing(this);
  
  /*-- SONIDOS --------------------------------------------------*/

  minim = new Minim(this);
  musiquita = minim.loadFile("musiquita.mp3");
  Viento = minim.loadFile("Viento.mp3");
  caida = minim.loadFile("caidaa.mp3");
  musiquita.loop();
  musiquita.setGain(-20); //le bajamos el volumen a la musica y al avion
  caida.setGain(-20);


  /*-- CLASES CON FISICA ----------------------------------------*/

  Fisica.init(this);
  mundo = new FWorld();
  avion = new Avioneta();
  tipito = new Tipito();
  pajaros = new Pajaros[2];
  pajaros2 = new Pajaros[2];
  particulas = new Particulas[100];
  pajaritos = loadImage("pajaritoNuevo.png");
  pajaritos2 = loadImage("pajaritoNuevo2.png");
  pajaritopabajo = loadImage("pajaritopabajo3.png");
  pajaritopabajo2 = loadImage("pajaritopabajo2.png");
  for (int i=0; i<flecha.length; i++) { 
    flecha[i] = loadImage("flechaDerecha " + i + ".png");
    flechaIzq[i] = loadImage("flechaIzquierda " + i + ".png");
  } 

  for (int i=0; i<2; i++) {  
    pajaros[i] = new Pajaros(150, 80);
    pajaros[i].setPosition(int(random (-width)), int(random (50, 100)));
    pajaros[i].setVelocity(1000, 0);
    mundo.add(pajaros[i]);
  }

  for (int i=0; i<2; i++) {  
    pajaros2[i] = new Pajaros(150, 80);
    pajaros2[i].setPosition(int(random (width+200, width*2+200)), int(random (150, 250)));
    pajaros2[i].setVelocity(-4000, 0);
    pajaros2[i].attachImage(pajaritos2);  
    mundo.add(pajaros2[i]);
  }
  for (int i=0; i<100; i++) {  
    particulas[i]= new Particulas();
  }



  /*------------------------------------------------------------*/

  fondos = new Fondos();
  reiniciar = new Reiniciar();
  alerta= loadImage("Alerta2.png");
  portada= loadImage("Portadaultima.jpg");
  portadaTipito= loadImage("PortadaTipito.png");
  instruccion1= loadImage("instrucciones-03.png");
  control= loadImage("instrucciones-04.png");
  instruccion2= loadImage("instrucciones-05.png");
  instruccion3 = loadImage("Instrucciones-06.png");
  viento= loadImage("EfectoViento.png");
  barra = loadImage("barraFuerza.png");
  mundo.setGravity(0, 500);
  momentoViento= random(600, 1200);
}


void draw() {

  /*-- JUEGO ----------------------------------------------------*/

  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0; i<tuioObjectList.size (); i++) {
    TuioObject patron = tuioObjectList.get(i);
    int ID = patron.getSymbolID();

    if (ID == 0) {
      pushMatrix();
      avion.rotacionPatron = patron.getAngle();
      translate(patron.getScreenX(width), patron.getScreenY(height));
      rect(0, 0, 50, 50);
      popMatrix();
    }
  }

  if (estado.equals("jugar")) {

    fondos.dibujarFondos();
    reiniciar.reinic = false;
    fill(#feee51);
    stroke(255);
    strokeWeight(4);
    rect(0, 10, tiempo-tiempo/3, 25);
    image(barra, 390, 750);
    musiquita.setGain(-30);
    mundo.step();
    mundo.draw();

    avion.dibujarAvion();
    tipito.dibujarTipito();
    tipito.caerse();



    for (int i=0; i<2; i++) { 
      pajaros[i].actualizar(pajaros2[i]);
      pajaros[i].reiniciar();

      if (Arriba && pajaros[i].muerto == false ) {
        pajaros[i].attachImage(pajaritos);
      }
      if (!Arriba && pajaros[i].muerto == false ) {
        pajaros[i].attachImage(pajaritopabajo);
      }
    }

    for (int i=0; i<2; i++) {  
      pajaros2[i].actualizar2(pajaros[i]);    
      pajaros2[i].reiniciar2();

      if (Arriba && pajaros2[i].muerto == false ) {
        pajaros2[i].attachImage(pajaritos2);
      }
      if (!Arriba && pajaros2[i].muerto == false ) {
        pajaros2[i].attachImage(pajaritopabajo2);
      }
    }

    t--;
    if (t <= 0) {
      t = 5;
      Arriba = !Arriba ;
    }

    if (tiempo < 1500 && estado.equals("jugar")) { //Arranca a correr el tiempo
      tiempo++;
    } 

    if (tiempo > momentoViento-200 && tiempo < momentoViento-50) { //ALERTA VIENTO//
      pushStyle();
      imageMode(CENTER);
      image(alerta, width/2, height/2);
      popStyle();
    }
    if (tiempo > momentoViento && tiempo < momentoViento+200) { //VIENTO//
      for (int i=0; i<100; i++) {
        particulas[i].viento = true;
      }
      mundo.setGravity(60, 0);
      contadorViento++;
      float transpa = map(contadorViento, 0, 200, 50, 0);
      noStroke();
      fill(0, 0, 0, transpa);
      rect(0, 0, width, height);
      Viento.play();
    } else {
      mundo.setGravity(0, 500);
      Viento.pause();
      contadorViento = 0;
    }
    if ( tiempo > momentoViento+400) {
      for (int i=0; i<100; i++) {
        particulas[i].viento = false;
      }
    }
  }

  /*------------------------------------------------------------*/



  println(contadorViento);
  reiniciar.terminarJuego();//FUNCIONES DE REINICIO//
  reiniciar.reiniciarJuego();
  tipito.reiniciarPosicion();
  avion.reiniciarPosicion();
  fondos.cambiarFondo();
  if (reiniciar.reinic == true) {
    fondos.cambiar = true;
  } else {
    fondos.cambiar = false;
  }

  for (int i=0; i<100; i++) {
    particulas[i].actualizar();
  }
}

void contactStarted(FContact choque) {
  FBody cuerpo1 = choque.getBody1();
  FBody cuerpo2 = choque.getBody2();

  String nombre1 = conseguirNombre(cuerpo1);
  String nombre2 = conseguirNombre(cuerpo2);

  if (nombre1 == "tipito" && nombre2 == "pajaros") {
    Pajaros p = (Pajaros)cuerpo2;
    p.Muerto();
  }
  if (nombre2 == "tipito" && nombre1 == "pajaros") {
    Pajaros p = (Pajaros)cuerpo1;
    p.Muerto();
  }
}

void mousePressed() {
  reiniciar.reiniciarJuego();
}

void keyPressed() {

  if (keyCode == ENTER && estado == "portada") {
    estado = "instrucciones";
  }
  if (keyCode == ENTER && estado == "instrucciones" &&  xEstado==1) {
    estado = "instrucciones2";
    reiniciar.contador2 = 0;
  }
  if (keyCode == ENTER && estado == "instrucciones2" && xEstado==2) {
    estado = "instrucciones3";
  }
}
