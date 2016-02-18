class SeguimientoTarjeta {

    TarjetaInformativa tarjetaInformativa
    Date fechaCaptura
    String seguimiento
    UsuarioSistema usuarioSistema
    static constraints = {
        
        tarjetaInformativa(nullable:false)
        fechaCaptura(nullable:false)
        seguimiento(nullable:false)
        usuarioSistema(nullable:false)
        
    }
}
