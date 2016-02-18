class TurnadoTarjeta {
 	
 	Dependencia dependencia
    UsuarioSistema usuarioSistema
    TarjetaInformativa tarjetaInformativa
    Persona persona
    
    //***********************     FECHAS PARA CONSULTAS     *************************
   
    Date fechaTurnado //Esta fecha se modificara hasta que el documento sea turnado a un funcionario
    boolean status//  1.- turnado          2.-con seguimiento 
    
    static constraints = {

        dependencia(nullable:false)
        usuarioSistema(nullable:false)
        tarjetaInformativa(nullable:false)
        fechaTurnado(nullable:false)
        status(nullable:false)       
    }
}
