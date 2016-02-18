

class Turnado {

    //***********catalogos con los cuales se va a llenar un turnado

    Dependencia dependencia
    UsuarioSistema usuarioSistema
    Documento documento
    Persona persona
    
    //***********************     FECHAS PARA CONSULTAS     *************************
    Date fechaTerminacion //Esta fecha se modificara hasta que el estatus del documento sea de terminado
    Date fechaTurnado //Esta fecha se modificara hasta que el documento sea turnado a un funcionario
    
    String responsabilidad
    
    boolean status//  1.- turnado          2.-con seguimiento 
    static constraints = {

        dependencia(nullable:false)
        usuarioSistema(nullable:false)
        documento(nullable:false)
        
        fechaTerminacion(nullable:true)
        fechaTurnado(nullable:false)
        
        
        status(nullable:false)
        responsabilidad(inList:['RESPONSABLE', 'CCP'])
        
        
    }
}
