class Avioneta {

  FBox avion;
  PImage avioneta, helice;
  float rotacionPatron, min = 0, max = 0;
  AudioPlayer sonidoAvioneta;

  /*------------------------------------------------------------*/
  Avioneta() {
    sonidoAvioneta = minim.loadFile ("sonidoAvioneta.mp3");
    sonidoAvioneta.setGain(-10);
    FCircle ancla = new FCircle(40);
    ancla.setPosition(width/2, height/2+120);
    ancla.setStatic(true);
    ancla.setNoStroke();
    ancla.setFill(0);
    mundo.add(ancla);

    avion = new FBox(717, 260);
    avion.setPosition(width/2, height/2+100);
    avioneta = loadImage("AvionetaSinHelice.png");
    helice = loadImage("Helice.png");
    avion.attachImage(avioneta);
    mundo.add(avion);

    FRevoluteJoint junta = new FRevoluteJoint(ancla, avion, width/2, height/2+120);
    junta.setNoStroke();
    junta.setNoFill();
    mundo.add(junta);
  }

  /*------------------------------------------------------------*/
  void dibujarAvion() {
    //float rp = rotacionPatron - reiniciar.anguloActual;
    float factor1 = map(rotacionPatron, 0, PI, 0, 100);
    float factor2 = map(rotacionPatron, PI, TAU, -100, 0);
    float factor = rotacionPatron > PI ? factor2:factor1;

    min = factor < min ? factor:min ; //buscamos el minimo y el maximo para escalarlo
    max = factor > max ? factor:max ;

    float b_= map (factor*2, -300, 300, -190, 190 );

    fill(255); 
    rect (b_+width/2, 750, 5, 40); //es la barrita que sube y baja

    avion.addTorque(2000*factor);


    if ( !sonidoAvioneta.isPlaying() ) {    
      sonidoAvioneta.loop();
    }
    pushMatrix();
    pushStyle();
    translate(width/2+1, height/2+120);
    rotate(frameCount/3);
    imageMode(CENTER);
    image(helice, 0, 0);

    popStyle();
    popMatrix();
  }

  void reiniciarPosicion() {
    if (estado.equals("perdiste") || estado.equals("ganaste")) {
      avion.setRotation(0);
      avion.setPosition(width/2, height/2+100);
      avion.addTorque(0);
    }
  }
}
