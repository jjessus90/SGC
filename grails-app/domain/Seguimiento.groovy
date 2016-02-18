
class Seguimiento {

    
    Documento documento
    Date fechaCaptura
    String seguimiento
    UsuarioSistema usuarioSistema
    static constraints = {
        
        documento(nullable:false)
        fechaCaptura(nullable:false)
        seguimiento(nullable:false)
        usuarioSistema(nullable:false)
        
    }
}
