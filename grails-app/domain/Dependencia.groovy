
class Dependencia {

    
    static hasMany = [turnados:Turnado]
    
    String nombre
    Estado estado
    Municipio municipio
    String calleNumero
    String colonia
    String tipoDependencia
    int cp
    
    boolean status
    
    String toString(){
        return this.nombre
    }
    static constraints = {
        nombre(blank:false,nullable:false,unique:true)
        calleNumero(nullable:true)
        status(nullable:false)
        estado(nullable:false)
        municipio(nullable:true)
        colonia(nullable:true)
        cp(nullable:true)
        tipoDependencia(nullable:false, inList:['UNIVERSIDAD', 'INTERNA', 'MUNICIPAL', 'FEDERAL', 'EXTERNA'])
    }
}
