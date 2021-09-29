class Particulas {
  //FCircle particula;
  boolean viento;
  float tam, posX, posY;

  /*------------------------------------------------------------*/
  Particulas () {
    tam = random(2, 4);
    posX = random(-width);
    posY = random(height);
  }


  void actualizar() {
    noStroke();
    fill(50);
    ellipse(posX, posY, tam, tam);
    if (viento) {
      posX+=5;
    }
    
    if (estado.equals("perdiste") || estado.equals("ganaste")) {
     posX = random(-width);
     viento = false;
    }
  }
}
