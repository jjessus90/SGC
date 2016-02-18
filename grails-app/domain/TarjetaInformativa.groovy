class TarjetaInformativa {

	String numTarjeta
	Persona remitente
	String asunto
	Date fechaCaptura
    int status // 0) Creado,   1)Turnado,  2)Con Seguimiento   3)Terminado

	static hasMany = [destinatiario: TurnadoTarjeta, seguimientos:SeguimientoTarjeta]

	String toString(){
        
        return this.numTarjeta
    }
    static constraints = {
    	numTarjeta(nullable:false, unique:true)
    	asunto(blank:false, nullable:false)
    	remitente(nullable:false)
         status(nullable:false)//no se va a permitir que el usuario la capture
    }
}
