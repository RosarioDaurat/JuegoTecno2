class Reiniciar {

  Fondos f;
  PImage ganaste, perdiste;
  int bx, by, tamb, contador, contador2, contador3, flechas;
  float anguloActual, rotcontrol = 0;
  boolean llego, vuelta, reinic;

  /*------------------------------------------------------------*/
  Reiniciar() {
    f = new Fondos();
    ganaste = loadImage("Ganaste.jpg");
    perdiste = loadImage("Perdiste.jpg");
    bx = 430;
    by = 205;
    tamb = 260;
  }

  /*------------------------------------------------------------*/
  void terminarJuego() {
    if (tiempo > 1499 && estado != "perdiste") {
      estado = "ganaste";
    }
    if (estado.equals("ganaste")) {
      image(ganaste, 0, 0);
      fill(255);
      rect(bx-11, by-1, 180, 20);
      fill(#feee51);
      rect(bx-10, by, contador3/2, 18);
      contador3++;
      noFill();
      noStroke();
      rect(bx, by, tamb, tamb/4);
      musiquita.setGain(-20);
      avion.sonidoAvioneta.pause(); //esto esta mal, pero no me sale de otra forma
      reinic = true;
    } 

    if (estado.equals("perdiste")) {
      image(perdiste, 0, 0);
      fill(255);
      rect(bx-11, by-1, 180, 20);
      fill(#feee51);
      rect(bx-10, by, contador3/2, 18);
      contador3++;
      noFill();
      noStroke();
      rect(bx, by, tamb, tamb/4);
      musiquita.setGain(-20);
      avion.sonidoAvioneta.pause(); //esto esta mal, pero no me sale de otra forma
      Viento.pause();
      reinic = true;
    }


    if (estado.equals("portada")) {
      image(portada, 0, 0);
      textSize(20);
      fill(0);
      text("gira el volante hacia la opcion que quieras", 320, 770);
      pushMatrix();
      pushStyle();
      translate(width/2, 500);
      rotate(avion.rotacionPatron);
      imageMode(CENTER);
      image(portadaTipito, 0, 0);
      popStyle();
      popMatrix();

      pushMatrix();
      translate(750, 280);
      rotate(0.5);
      image(flecha[flechas], 0, 0 );
      popMatrix();

      pushMatrix();
      translate(40, 420);
      rotate(-0.5);
      image(flechaIzq[flechas], 0, 0);
      popMatrix();

      if (!llego && frameCount % 10 == 0) {
        flechas ++;
      }
      if (  flechas == 3 ) {
        llego = true;
      }
      if (llego && frameCount % 10 == 0) {
        flechas --;
      }
      if (flechas == 0) {
        llego = false;
      }

      noFill();
      noStroke();
      rect(bx, by, tamb, tamb/4);
      avion.sonidoAvioneta.pause(); //esto esta mal, pero no me sale de otra forma
    }

    if (estado.equals("instrucciones")) {
      contador2++;
      image(instruccion1, 0, 0);
      if (!vuelta) {
        rotcontrol += 0.03;
      }
      if ( rotcontrol > 1) {
        vuelta = true;
      }
      if (vuelta) {
        rotcontrol -= 0.03;
      }
      if (rotcontrol< -1) {
        vuelta = false;
      }

      pushMatrix();
      pushStyle();
      imageMode(CENTER);
      translate(width/2+30, height/2+10);
      rotate(rotcontrol);
      image(control, 0, 0, 600, 500);
      popStyle();
      popMatrix();

      xEstado=1;
      fill(255);
      fill(0);
      rect(368, 750, 245, 15);
      fill(255);
      rect(370, 752, contador2/2, 10);
      if (contador2>480) {
        estado = "instrucciones2";
        contador2 = 0;
      }
    }
    if (estado.equals("instrucciones2")) {

      contador2++;
      image(instruccion2, 0, 0);
      xEstado=2;
      
      fill(0);
      rect(368, 750, 312,15);
      fill(255);
      rect(370, 752, contador2/2, 10);
      if (contador2>600) {
        estado = "instrucciones3";
      }
    }
    if (estado.equals("instrucciones3")) {
      image(instruccion3, 0, 0);
      xEstado=3;
      textAlign(CENTER);
      textSize(120);
      fill(#6a4700);
      text(contador/60, width/2, height/2+90);
      contador++;
      if (contador > 200) {
        estado = "jugar";
      }
    }
  }

  /*------------------------------------------------------------*/
  void reiniciarJuego() { //Boton para reiniciar
    if (contador3 > 350) {
      estado = ("jugar");
      tiempo = 0;
      frameCount = 0;
      avion.avion.setRotation(0);
      avion.avion.resetForces();
      contador3 = 0;
    }
    println("angulo:"+ avion.rotacionPatron);
    if ( avion.rotacionPatron - anguloActual < 6 && avion.rotacionPatron - anguloActual > 4 &&  estado.equals("portada")) { //ACA INTENTO QUE INICIE EL JUEGO CON EL VOLANTE
      estado = ("jugar");
      tiempo = 0;
      frameCount = 0;
      f.cambiar = true;
    }
    if ( avion.rotacionPatron - anguloActual < 3 && avion.rotacionPatron - anguloActual > 0.6 &&  estado.equals("portada")) {
      estado = "instrucciones";
    }
  }
  void asignarAnguloActual() {
    anguloActual = avion.rotacionPatron;
  }
}
