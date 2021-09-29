class Tipito {
  FCircle tipito;
  PImage aviador;
  boolean terminar;

  /*------------------------------------------------------------*/
  Tipito () {
    tipito = new FCircle(100);
    aviador = loadImage("Aviador.png");
    mundo.add(tipito);
    tipito.setPosition(width/2, 0);
    tipito.setGrabbable(false);
    tipito.addForce(6000, 0);
  }

  /*------------------------------------------------------------*/
  void dibujarTipito() {
    tipito.setName("tipito");
    tipito.attachImage(aviador);
  }

  /*------------------------------------------------------------*/
  void caerse() { //perdimos
    float ty = tipito.getY();
    float tx = tipito.getX();
     if (ty>700) {
      caida.play();
    }
   if (ty>800 || tx>width+100 || tx<-100) {
      estado= "perdiste";

      tipito.setPosition(width/2, 0);
      reiniciar.asignarAnguloActual();
    }
  }

  /*------------------------------------------------------------*/
  void reiniciarPosicion() {
    if (estado.equals("perdiste") || estado.equals("ganaste")) {
      tipito.setPosition(width/2, 0);
    }
  }
}
