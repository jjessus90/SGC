

class Municipio {

    static  hasMany = [documentos: Documento, dependencias: Dependencia]
    Estado estado 
    String nombre
    String toString(){
        return this.nombre
    }
    
    static constraints = {
        nombre(blank:false)
    }
    
    
}
