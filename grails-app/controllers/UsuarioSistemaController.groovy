class UsuarioSistemaController {
    def springSecurityService
    // the delete, save and update actions only accept POST requests
    static Map allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

    def index = {
        redirect action: search

    }
	
    def search = {
		
        def activo=true;
			  
        if(params.inactivo){
            activo=false
        }
		
        def clase = UsuarioSistema //Cambia
        def listado
        def total
        def offset=0
        def maximo=10
					
        if(!params.offset){
            offset=0
            maximo=10
        }else{
            offset=params.offset as int
            maximo=params.max as int
        }
					

        if (params.query && params.query.trim()!=''){
            if(params.query.isNumber()){
                def idBusca=params.query
                def requestmap = clase.get(idBusca)
                if (!requestmap) {
                    params.anexo = "No existe ese ID: "+params.query
                    params.query=''
                    redirect(action: list, params:params)
                    return
                }
							
                redirect(action: show, id:idBusca, params:params)
							
            }else{
							
                def searchResult
		
                flash.message = "Mostrando resultados del ${offset} al ${offset+maximo}, activos:${activo}, buscando: ${params.query}"
                //cambia
                
                searchResult = clase.findAllByUsuarioSistemaRealNameLikeAndEnabled('%'+params.query+'%', activo, [ offset : offset, max: maximo ])
                
                listado = searchResult
                //Tama�o
                total = clase.countByusuarioSistemaRealNameLikeAndEnabled('%'+params.query+'%', activo)
//                println"Mostrando"+params.query+"y activo: "+activo
                if(total==0){flash.message = "No hay resultados para: "+params.query}
            }
						
        }else{
            if(!params.anexo){params.anexo='';}
            flash.message = "${params.anexo} Mostrando todos los resultados del ${offset} al ${offset+maximo}"
//		println"Mostrando"+params.query+"y activo: "+activo
		
            listado = clase.findAll("From UsuarioSistema",[ offset : offset, max: maximo ]);
            total = clase.count()
					
        }
        //cambia las instancias que regresa
        render(view:'list', model:[usuarioSistemaInstanceList: listado, total: total, query:params.query, max:maximo, inactivo:params.inactivo])
					
    }
					
			
    def list={
        redirect(controller:'usuarioSistema', action:'search', params:params)
    }
	


    def show = {
        def person = UsuarioSistema.get(params.id)
        if (!person) {
            flash.message = "usuarioSistema not found with id $params.id"
            redirect action: list
            return
        }
        List roleNames = []
        for (role in person.authorities) {
            roleNames << role.authority
        }
        roleNames.sort { n1, n2 ->
            n1 <=> n2
        }
        [usuarioSistemaInstance: person, roleNames: roleNames]
    }

    /**
     * Person delete action. Before removing an existing person,
     * he should be removed from those authorities which he is involved.
     */
    def delete = {

        def person = UsuarioSistema.get(params.id)
        if (person) {
            def authPrincipal = springSecurityService.principal
            //avoid self-delete if the logged-in usuarioSistema is an admin
            if (!(authPrincipal instanceof String) && authPrincipal.UsuarioSistemaname == person.UsuarioSistemaname) {
                flash.message = "You can not delete yourself, please login as another admin and try again"
            }
            else {
                //first, delete this person from People_Authorities table.
                Role.findAll().each { it.removeFromPeople(person) }
                person.delete()
                flash.message = "usuarioSistema $params.id deleted."
            }
        }
        else {
            flash.message = "usuarioSistema not found with id $params.id"
        }

        redirect action: list
    }

    def edit = {

        def person = UsuarioSistema.get(params.id)
        if (!person) {
            flash.message = "usuarioSistema not found with id $params.id"
            redirect action: list
            return
        }

        return buildPersonModel(person)
    }

    /**
     * Person update action.
     */
    def update = {
        def person = UsuarioSistema.get(params.id)
        if (!person) {
            flash.message = "usuarioSistema not found with id $params.id"
            redirect action: edit, id: params.id
            return
        }
                
        if(params.passwd=='') {
            flash.message="Password invalido"
            person.passwd=""
            render view: 'edit', model: buildPersonModel(person)
            return
        }

        long version = params.version.toLong()
        if (person.version > version) {
            person.errors.rejectValue 'version', "person.optimistic.locking.failure",
				"Another usuarioSistema has updated this usuarioSistema while you were editing."
            render view: 'edit', model: buildPersonModel(person)
            return
        }
		
		
        def oldPassword = person.passwd
        person.properties = params
        if (!params.passwd.equals(oldPassword)) {
            person.passwd = springSecurityService.encodePassword(params.passwd)
        }
        if (person.save()) {
            Role.findAll().each { it.removeFromPeople(person) }
            addRoles(person)
            redirect action: show, id: person.id
        }
        else {
            render view: 'edit', model: buildPersonModel(person)
        }
    }

    def create = {
        
        def query="From Dependencia"                        
        //def queryUnidad="From UnidadAdmin"
        def us= new UsuarioSistema(params)
        us.passwd=''
        [usuarioSistemaInstance:us, authorityList: Role.list(), listaDependencias:Dependencia.findAll(query)]
    }

    /**
     * Person save action.
     */
    def save = {

        def person = new UsuarioSistema()
        person.properties = params
	
        
        if(params.passwd=='') {
            flash.message="Password invalido"
            person.passwd=''
            render view: 'create', model: buildPersonModel(person)
            return
        }
		
        person.passwd = springSecurityService.encodePassword(params.passwd)
        if (person.save()) {
            addRoles(person)
//            println 'show'
            redirect action: show, id: person.id
        }
        else {

            person.passwd=''
            render view: 'create', model: [authorityList: Role.list(), usuarioSistemaInstance: person]
        }
    }

    private void addRoles(person) {
        for (String key in params.keySet()) {
            if (key.contains('ROLE') && 'on' == params.get(key)) {
                Role.findByAuthority(key).addToPeople(person)
               
            }
        }
    }

    private Map buildPersonModel(person) {

        List roles = Role.list()
        roles.sort { r1, r2 ->
            r1.authority <=> r2.authority
        }
        Set usuarioSistemaRoleNames = []
        for (role in person.authorities) {
            usuarioSistemaRoleNames << role.authority
        }
        LinkedHashMap<Role, Boolean> roleMap = [:]
        for (role in roles) {
            roleMap[(role)] = usuarioSistemaRoleNames.contains(role.authority)
        }

        return [usuarioSistemaInstance: person, roleMap: roleMap]
    }


    def selectHTML={
        def cadena='<select id="ejecutivoSeleccion" value="%">'
        cadena+='<option value="%">Todos los ejecutivos</option>'
        UsuarioSistema.findAllByEnabled(true).each{
            cadena+='<option value="'+it.id+'">'+it.usuarioSistemaRealName+'</option>'
        }
        cadena+='</select>'
        render cadena

    }
}
