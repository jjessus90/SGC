
/**
 * UsuarioSistema domain class.
 */
class UsuarioSistema {
	
    static transients = ['pass']
    static hasMany = [authorities: Role]
    static belongsTo = Role
    Dependencia dependencia

    
    String username
    String nombreCompleto
    String passwd
    
    boolean enabled
    
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    
    String email
    

    /** plain password to create a MD5 password */
    String pass = '[secret]'

    String toString(){
        return this.nombreCompleto
    }
    
    static constraints = {
        username(blank: false, unique: true)
        nombreCompleto(blank: false)
        passwd(blank: false) 
        dependencia(nullable: true)

    }
}
