//hola
//prueba ubuntu

class Persona {

    static  hasMany = [documentos: Documento, turnados:Turnado]
    
    String nombre
    String correo
    String cargo
    String calleNumero
    String colonia
    int cp
    String tel
    
    Dependencia dependencia
    Estado estado
    Municipio municipio
    
    String toString(){
            return this.nombre    
    }
    
    static constraints = {
        nombre(nullable:false,unique:true)
        correo(nullable:false)
        municipio(nullable:true)
        estado(blank:false,nullable:false)
    }
}