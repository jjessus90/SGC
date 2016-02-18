import org.springframework.dao.DataIntegrityViolationException
import grails.converters.*
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.springframework.*

class TurnadoTarjetaController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [turnadoTarjetaInstanceList: TurnadoTarjeta.list(params), turnadoTarjetaInstanceTotal: TurnadoTarjeta.count()]
    }

    def create() {
        [turnadoTarjetaInstance: new TurnadoTarjeta(params)]
    }

    def save() {
        def turnadoTarjetaInstance = new TurnadoTarjeta(params)
        if (!turnadoTarjetaInstance.save(flush: true)) {
            render(view: "create", model: [turnadoTarjetaInstance: turnadoTarjetaInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'turnadoTarjeta.label', default: 'TurnadoTarjeta'), turnadoTarjetaInstance.id])
        redirect(action: "show", id: turnadoTarjetaInstance.id)
    }

    def show(Long id) {
        def turnadoTarjetaInstance = TurnadoTarjeta.get(id)
        if (!turnadoTarjetaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'turnadoTarjeta.label', default: 'TurnadoTarjeta'), id])
            redirect(action: "list")
            return
        }

        [turnadoTarjetaInstance: turnadoTarjetaInstance]
    }

    def edit(Long id) {
        def turnadoTarjetaInstance = TurnadoTarjeta.get(id)
        if (!turnadoTarjetaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'turnadoTarjeta.label', default: 'TurnadoTarjeta'), id])
            redirect(action: "list")
            return
        }

        [turnadoTarjetaInstance: turnadoTarjetaInstance]
    }

    def update(Long id, Long version) {
        def turnadoTarjetaInstance = TurnadoTarjeta.get(id)
        if (!turnadoTarjetaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'turnadoTarjeta.label', default: 'TurnadoTarjeta'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (turnadoTarjetaInstance.version > version) {
                turnadoTarjetaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'turnadoTarjeta.label', default: 'TurnadoTarjeta')] as Object[],
                          "Another user has updated this TurnadoTarjeta while you were editing")
                render(view: "edit", model: [turnadoTarjetaInstance: turnadoTarjetaInstance])
                return
            }
        }

        turnadoTarjetaInstance.properties = params

        if (!turnadoTarjetaInstance.save(flush: true)) {
            render(view: "edit", model: [turnadoTarjetaInstance: turnadoTarjetaInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'turnadoTarjeta.label', default: 'TurnadoTarjeta'), turnadoTarjetaInstance.id])
        redirect(action: "show", id: turnadoTarjetaInstance.id)
    }

    def delete(Long id) {
        def turnadoTarjetaInstance = TurnadoTarjeta.get(id)
        if (!turnadoTarjetaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'turnadoTarjeta.label', default: 'TurnadoTarjeta'), id])
            redirect(action: "list")
            return
        }

        try {
            turnadoTarjetaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'turnadoTarjeta.label', default: 'TurnadoTarjeta'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'turnadoTarjeta.label', default: 'TurnadoTarjeta'), id])
            redirect(action: "show", id: id)
        }
    }

    def agregarDependenciasNombre(Long id){
        
        def idTarjeta

        if(params?.tarjetaInf){
            idTarjeta = params?.tarjetaInf

            def query = "From Dependencia"
            def tarjetaInformativaInstance = TarjetaInformativa.get(idTarjeta)
            def queryTurnado="From TurnadoTarjeta t where t.tajetaInformativa=${idTarjeta}"
            [TarjetaInformativaInstance: tarjetaInformativaInstance, dependenciaInstance:Dependencia.findAll(query), turnadoTarjetaInstance:TurnadoTarjeta.findAll(queryTurnado)]
        }

        else if(id){
            idTarjeta=id as int
            
            def query="From Dependencia"
            def tarjetaInformativaInstance = TarjetaInformativa.get(idTarjeta)
            def queryTurnado="From TurnadoTarjeta t where t.tarjetaInformativa=${idTarjeta}"
            def turnadoTarjetaInstanceN=TurnadoTarjeta.findAll(queryTurnado)
            [tarjetaInformativaInstance: tarjetaInformativaInstance, dependenciaInstance:Dependencia.findAll(query), turnadoTarjetaInstance:turnadoTarjetaInstanceN]
        }else{
            
            def query="From Dependencia"
            def tarjetaInformativaInstance = TarjetaInformativa.get(idTarjeta)
            //def queryTurnado="From Turnado t where t.documento=${idDocumento}"
            [tarjetaInformativaInstance: tarjetaInformativaInstance, dependenciaInstance:Dependencia.findAll(query)]
        }


        /*
        if(params?.document){
            idTarjeta=params?.document
            
            def query="From Dependencia"
            def tarjetaInformativaInstance = TarjetaInformativa.get(idTarjeta)
            def queryTurnado="From TurnadoTarjeta t where t.tajeta=${idTarjeta}"
            [TarjetaInformativaInstance: tarjetaInformativaInstance, dependenciaInstance:Dependencia.findAll(query), turnadoTarjetaInstance:TurnadoTarjeta.findAll(queryTurnado)]
        
        }else if(id){
            idDocumento=id as int
            
            def query="From Dependencia"
            def documentoInstance = Documento.get(idDocumento)
            def queryTurnado="From Turnado t where t.documento=${idDocumento}"
            def turnadoInstanceN=Turnado.findAll(queryTurnado)
            [documentoInstance: documentoInstance, dependenciaInstance:Dependencia.findAll(query), turnadoInstance:turnadoInstanceN]
        }else{
            
            def query="From Dependencia"
            def documentoInstance = Documento.get(idDocumento)
            //def queryTurnado="From Turnado t where t.documento=${idDocumento}"
            [documentoInstance: documentoInstance, dependenciaInstance:Dependencia.findAll(query)]
        }*/
        
    }

    def ajaxGetPersona(){
        def Cadena = params.id as String   
        
        def listPersonas = Persona.findAll("FROM Persona p WHERE p.nombre like '%${Cadena}%'")  
       
        def resultadoFormateado = listPersonas.collect {
            [
                id: it.id,                
                nombre: it.nombre            
            ]
        }        
        render resultadoFormateado as JSON       
        
    }


    def saveDependenciasTurnadas(){
       
        
        
        def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def usuario=UsuarioSistema.get(idUsuario)
        
        
        def idTarjeta=params?.tarjetaInf as int
        
        def queryTurnado = TurnadoTarjeta.executeQuery("Select count(t.id) from TurnadoTarjeta t where t.persona=${params?.personaID} and t.tarjetaInformativa=${idTarjeta as int}")
        def duplicadoTurnado=queryTurnado[0]
        if(duplicadoTurnado){
            
            flash.error = ("La persona ya ha sido agregada")
            redirect(action: "agregarDependenciasNombre", id:params.tarjetaInf)
            return
        }
        
        
        
        def IdPersona = params?.personaID as int
        def personaUnidadInstance = Persona.get(IdPersona)
        
        //def idUnidad = personaUnidadInstance.unidadAdmin.id as int
        
        //def dependenciaInst = UnidadAdmin.get(idUnidad)
        def idDependencia=personaUnidadInstance.dependencia.id as int
        
        def  dependenciaInstance = Dependencia.get(idDependencia)
        //def unidadAdminInstance = UnidadAdmin.get(idUnidad)
        
        
        def personaInstance = Persona.get(params?.personaID)
        def tarjetaInformativaInstance = TarjetaInformativa.get(idTarjeta as int)
        def turnadoTarjetaInstance = new TurnadoTarjeta()
        turnadoTarjetaInstance.fechaTurnado = new Date()
        turnadoTarjetaInstance.status = 0
        turnadoTarjetaInstance.usuarioSistema=usuario//asasdaaaaaaaaaaaaaaaaaaaa
        turnadoTarjetaInstance.dependencia=dependenciaInstance
        //turnadoInstance.unidadAdmin=unidadAdminInstance
        turnadoTarjetaInstance.persona=personaInstance
        turnadoTarjetaInstance.tarjetaInformativa = tarjetaInformativaInstance
      
//        println"Params son fecha:"+turnadoInstance.fechaTurnado
//        println"Params son status:"+turnadoInstance.status
//        println"Params son user:"+turnadoInstance.usuarioSistema
//        println"Params son dependencia:"+ turnadoInstance.dependencia
//        //println"Params son unidad :"+ turnadoInstance.unidadAdmin
//        println"Params son persona:"+turnadoInstance.persona
//        
       
       
       
        //Con este fragmento de código podremos guardar el turnado y al mismo tiempo saber 
        //si el turnado no fue guardado redireccionamos hacia agregar dependencias
        if(!turnadoTarjetaInstance){
           
        }
        if (!turnadoTarjetaInstance.save(flush: true)) {
           
            flash.error=("No se pudo guardar")
            redirect(action: "agregarDependenciasNombre", id:params.tarjetaInf)
            return
        }
        
        //Actualizamos el status del documento con las siguientes dos lineas
        if(tarjetaInformativaInstance.status==0 || tarjetaInformativaInstance.status==1){
            TarjetaInformativa.executeUpdate("update TarjetaInformativa d set d.status=1 " +
                      "where d.id=${params.tarjetaInf as int}")
        }else{//fin de if e inicio del else
        
        }//fin else
        
        //Hacemos el query para regresar la lista de turnados a ese documento
        def query="From TurnadoTarjeta t where t.tarjetaInformativa=${idTarjeta}"
        
        //Regresamos el mensaje de que fue creado y regresamos a la vista agregar dependencias
        flash.message = message(code: 'default.created.message', args: [message(code: 'turnadoTarjeta.label', default: 'TurnadoTarjeta'), turnadoTarjetaInstance.id])
        render(view: "agregarDependenciasNombre", model: [tarjetaInformativaInstance: tarjetaInformativaInstance, turnadoTarjetaInstance:TurnadoTarjeta.findAll(query)])
        
    }
}
