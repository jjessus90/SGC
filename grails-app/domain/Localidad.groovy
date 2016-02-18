
class Localidad {

    static  hasMany = [documentos: Documento]
    Estado estado
    Municipio municipio
    String nombre
    String toString(){
        return this.nombre
    }
    
    static constraints = {
        nombre(blank:false)
    }
    
    
}