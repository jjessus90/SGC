

class Estado {
    
    static  hasMany = [documentos: Documento, dependencias: Dependencia]
String nombre
String toString(){
        return this.nombre
    }
    static constraints = {
        nombre(blank:false)
    }
}
