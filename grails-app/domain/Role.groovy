class Role {
    static hasMany = [people: UsuarioSistema]

    /** description */
    String description
    /** ROLE String */
    String authority

    String toString(){
        
        return this.description
    }
    
    static constraints = {
        authority(blank: false, unique: true)
        description()
    }
}
