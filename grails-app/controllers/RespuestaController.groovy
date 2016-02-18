import org.springframework.dao.DataIntegrityViolationException

class RespuestaController {

    def springSecurityService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [respuestaInstanceList: Respuesta.list(params), respuestaInstanceTotal: Respuesta.count()]
    }

    def create() {
        [respuestaInstance: new Respuesta(params)]
    }

    def save() {
        def respuestaInstance = new Respuesta(params)
        if (!respuestaInstance.save(flush: true)) {
            render(view: "create", model: [respuestaInstance: respuestaInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'respuesta.label', default: 'Respuesta'), respuestaInstance.id])
        redirect(action: "show", id: respuestaInstance.id)
    }

    def show(Long id) {
        def respuestaInstance = Respuesta.get(id)
        if (!respuestaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'respuesta.label', default: 'Respuesta'), id])
            redirect(action: "list")
            return
        }

        [respuestaInstance: respuestaInstance]
    }

    def edit(Long id) {
        def respuestaInstance = Respuesta.get(id)
        if (!respuestaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'respuesta.label', default: 'Respuesta'), id])
            redirect(action: "list")
            return
        }

        [respuestaInstance: respuestaInstance]
    }

    def update(Long id, Long version) {
        def respuestaInstance = Respuesta.get(id)
        if (!respuestaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'respuesta.label', default: 'Respuesta'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (respuestaInstance.version > version) {
                respuestaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'respuesta.label', default: 'Respuesta')] as Object[],
                          "Another user has updated this Respuesta while you were editing")
                render(view: "edit", model: [respuestaInstance: respuestaInstance])
                return
            }
        }

        respuestaInstance.properties = params

        if (!respuestaInstance.save(flush: true)) {
            render(view: "edit", model: [respuestaInstance: respuestaInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'respuesta.label', default: 'Respuesta'), respuestaInstance.id])
        redirect(action: "show", id: respuestaInstance.id)
    }

    def delete(Long id) {
        def respuestaInstance = Respuesta.get(id)
        if (!respuestaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'respuesta.label', default: 'Respuesta'), id])
            redirect(action: "list")
            return
        }

        try {
            respuestaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'respuesta.label', default: 'Respuesta'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'respuesta.label', default: 'Respuesta'), id])
            redirect(action: "show", id: id)
        }
    }
    def agregarRespuesta(Long id){
        //println"el id es: "+id
        def idDocumento
        idDocumento=params?.document
        
        if(params?.document){
            def documentoInstance = Documento.get(idDocumento as int)
            def queryRespuesta="From Respuesta s where s.documento=${idDocumento} order by s.fechaCaptura desc"
            [documentoInstance: documentoInstance, respuestaInstance:Respuesta.findAll(queryRespuesta)]
            
        }else{
            
            def documentoInstance = Documento.get(id as int)
            def queryRespuesta="From Respuesta s where s.documento=${id} order by s.fechaCaptura desc"
            def respuestaInstance = Respuesta.findAll(queryRespuesta)
            [documentoInstance: documentoInstance, respuestaInstance:respuestaInstance]
        
            
        }
}

        def saveRespuesta(){
         def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def usuario=UsuarioSistema.get(idUsuario)
        
        def respuestaInstance = new Respuesta(params)
        def idDocument=params?.document as int
        
        def documentoInstance = Documento.get(idDocument as int)
        respuestaInstance.fechaCaptura = new Date()
        respuestaInstance.usuarioSistema=usuario
        respuestaInstance.respuesta=params.respuesta
        
        
         if (!respuestaInstance.save(flush: true)) {
            
            redirect(action: "agregarRespuesta", id:params.document)
            return
        }
        
        
        
        def query = "From Respuesta s where s.documento=${idDocument} order by s.fechaCaptura desc"
        render(view: "agregarRespuesta", model: [documentoInstance: documentoInstance, respuestaInstance:Respuesta.findAll(query)])
        
}

    def deleteRespuesta(){
        
        def idRespuesta = params.id as int
        
        def respuestaInstance = Respuesta.get(idRespuesta)
        if (!respuestaInstance.save(flush: true)) {
            flash.message = "Error al actualizar la respuesta"
            redirect(action: "agregarRespuesta", id: idTurnado) 
        }
        
        if(respuestaInstance.delete(flush:true)){
        }else{
            
        }

        
        def idDocumento=params.documento.id
        def documentoInstance = Documento.get(idDocumento)
        def query="From Respuesta s where s.documento=${idDocumento} order by s.fechaCaptura desc"
        def respuestaInstances=Respuesta.findAll(query)
        
        if(!respuestaInstances){//Si no hay personas turnadas a este documento se actualiza el status del documento a creado
            //con las siguientes lineas actualizamos el status del documento a creado "0"
            Documento.executeUpdate("update Documento d set d.status=1 " +
                      "where d.id=${idDocumento as int}")
            
        }
        flash.message = "La respuesta fue declinado de este documento"
        render(view: "agregarRespuesta", model: [documentoInstance: documentoInstance, respuestaInstance:respuestaInstances])
        
        
    }
}