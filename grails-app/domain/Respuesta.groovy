
class Respuesta {

    Documento documento
    Date fechaCaptura
    String respuesta
    UsuarioSistema usuarioSistema
    static constraints = {
        
        documento(nullable:false)
        fechaCaptura(nullable:false)
        respuesta(nullable:false)
        usuarioSistema(nullable:false)
        
    }
}
