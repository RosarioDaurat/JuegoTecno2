 String conseguirNombre(FBody cuerpo){
 String nombre = "nada";
 
     if(cuerpo != null){
    nombre =cuerpo.getName();
    if(nombre == null){
      nombre = "nada";
    }
}
return nombre;
}
