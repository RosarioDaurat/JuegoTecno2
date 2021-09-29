class Fondos {
  PImage cielo1, cielo2, cielo3, nube;
  int nx, ny, f;
  float tam;
  boolean cambiar;

  /*------------------------------------------------------------*/
  Fondos() {
    cambiar = true;
    f = round(random (0, 2));
    cielo1 = loadImage("Cielo0.jpg");
    cielo2 = loadImage("Cielo1.jpg");
    cielo3 = loadImage("Cielo2.jpg");
    nube = loadImage("Nube3.png");
    nx = int(random(-270, -300));
    ny= int(random(0, 300));
    tam= random(100, 200);
  }

  /*------------------------------------------------------------*/
  void dibujarFondos() {
    if (f == 0) {
      background(cielo1);
    }
    if (f == 1) {
      background(cielo2);
    }
    if (f == 2) {
      background(cielo3);
    }
    for (int i=1; i<3; i++) { //NUBES
      image(nube, nx*i, ny*i, tam*2, tam);
    }
    nx++;

    if (nx > width+250) {
      nx =int(random(-270, -300));
      tam= random(100, 200);
    }
  }
  void cambiarFondo() {
    if (cambiar) {
      f = round(random (0, 2));
    }
    if (cambiar && estado == "jugar") {
      cambiar = false;
    }
  }
}
