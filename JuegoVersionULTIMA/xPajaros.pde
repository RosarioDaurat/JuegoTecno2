class Pajaros extends FBox {

  float velocidad, nuevoX, nuevoY, nuevoX2, nuevoY2;
  boolean choque, choque2, muerto;
  float dir;
  PImage pajaroMuerto;

  Pajaros(float ancho, float alto) {
    super(ancho, alto);
    muerto = false;
    velocidad = int(random(200, 300)); 
    setName("pajaros");
    setRotation(0);
    setDensity(2);
    
    nuevoX = int(random (-100, -900));
    nuevoY= int(random (50, 90));
    nuevoX2 = int(random (width, width*2));
    nuevoY2= int(random (170, 250));  
    pajaroMuerto = loadImage("pajaroMuerto2.png");
  }

  void actualizar(Pajaros otro) {
    setRotation(0);
    if (tiempo>200) {
      setStatic(false);
    } else {
      setStatic(true);
    }  
    if(tiempo> 800 && getX() > width+99){
    setPosition(nuevoX, nuevoY2+20);
    }
    if (!muerto) {
      setVelocity(velocidad, 0);
    }
  }

  void actualizar2(Pajaros otro) {
    setRotation(0);
   if (tiempo>400) {
      setStatic(false);
    } else {
      setStatic(true);
    }
  if(tiempo> 730 && getX() < -100 ){
    setPosition(nuevoX2, nuevoY);
    }
    if (!muerto) {
      setVelocity(-velocidad, 0);
    }
  }

  void Muerto() {
    muerto = true;
    setVelocity(0, 0);
    attachImage(pajaroMuerto);
  } 

  void reiniciar() {
      if (getY() > height || getX() > width+100 ||tiempo < 2|| estado.equals("perdiste")) {
        setPosition (nuevoX, nuevoY);
        setVelocity(velocidad, 0);
        muerto = false;
        setRotation(0);
        attachImage(pajaritos);
      }
    
  }


  void reiniciar2() {
      if (getY() > height || getX() < -100 ||tiempo < 2|| estado.equals("perdiste") ) {
        setPosition(nuevoX2, nuevoY2);
        setVelocity(-velocidad, 0);
        muerto = false;
        setRotation(0);
        attachImage(pajaritos2);
      }
  }
}
