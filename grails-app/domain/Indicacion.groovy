
class Indicacion {
    static hasMany = [documentos: Documento]
    
    String indicacion

    String toString(){
        
        def cadena = this.indicacion.length()
        
//       println"la cadena es de 2:"+cadena
        if(cadena>80){
        return this.indicacion //El número máximo esta en función de la primer indicación, por lo tanto si la primer indicación ingresada es de longitud 20, en el número máximo no podrá ir un número mayor a 20
        }
        else{
           return this.indicacion
        }
    }
    
    static constraints = {
        indicacion(blank:false)
    }
}
