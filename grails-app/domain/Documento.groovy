

class Documento {
   
    static hasMany = [turnados: Turnado, seguimientos:Seguimiento]
        
    String folio
    
    //*************CATALOGOS CON LOS CUALES SE LLENA CADA DOCUMENTO***************//
    
    Persona persona
    UsuarioSistema usuarioSistema
    TipoDocumento tipoDocumento
    Estado estado
    Municipio municipio
    Localidad localidad
    Indicacion indicacion
    Dependencia dependenciaRemitente
    //******************FECHAS PARA CADA DOCUMENTO****************************************************************
    Date fechaCaptura //este campo mostrara la fecha de captura del documento
    Date fechaRecibido//Fecha en que se recibio el documento
    
    //se deben de sacar los dias totales desde la fecha de su captura hasta la fecha actual para ver que tanto tiempo lleva el documento
 
    //********************OTROS CAMPOS********************************
    String dirigido
    String signatario
    String prioridad
    String asunto
    int status // 0) Creado,   1)Turnado,  2)Con Seguimiento   3)Terminado
    String turnadoInterno
    String upload
//    String numOficio
    String indicacionTexto
    String presente
    String observacion
    String evento
    ClasificacionArchivo clasificacion
    

    
    
    String toString(){
        
        return this.folio
    }
    
    static constraints = {
        
        
        folio(nullable:false)//no se va a permitir que el usuario la capture
        indicacionTexto(nullable:true)
        dirigido(nullable:true)
        persona(nullable:true)
        usuarioSistema(nullable:false)//no se va a permitir que el usuario la capture
        tipoDocumento(nullable:false)
        municipio(nullable:true)
        localidad(nullable:true)
        estado(nullable:true)
        dependenciaRemitente(nullable:true)
        indicacion(nullable:true)
        observacion(nullable:true)
        fechaCaptura(nullable:false)//no se va a permitir que el usuario la capture
        fechaRecibido(nullable:false)
        evento(nullable:true)
        turnadoInterno(nullable:true)
        
        prioridad(nullable:true, inList:['IMPORTANCIA','URGENTE', 'NORMAL', ])
        asunto(blank:false, nullable:false)
        status(nullable:false)//no se va a permitir que el usuario la capture
        
        upload(nullable:true)
  //      numOficio(nullable:true)
        presente(nullable:true)
        clasificacion(nullable:true)
        signatario(nullable:true)
    }
}
