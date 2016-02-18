class TipoDocumento {

    String tipoDocumento
    
    
    String toString(){
        
        return this.tipoDocumento
    }
    static constraints = {
    tipoDocumento(nullable:false)
    
    }
}
