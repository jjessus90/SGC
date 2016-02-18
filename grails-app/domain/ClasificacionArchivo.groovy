

class ClasificacionArchivo {
    
    String dependencia
    String tipoDependencia // 0.Dependencias Federales 1. Dependencias Estatales
    String clave
    Date anio
    int status
    static constraints = {
        dependencia(nullable:false)
        tipoDependencia(nullable:false, inList:['FEDERAL','ESTATAL','INTERNO'])
        clave(nullable:false)
        anio(nullable:false)
        status(nullable:false)
    }
}
