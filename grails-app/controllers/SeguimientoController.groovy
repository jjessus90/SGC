import org.springframework.dao.DataIntegrityViolationException

class SeguimientoController {

    def springSecurityService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [seguimientoInstanceList: Seguimiento.list(params), seguimientoInstanceTotal: Seguimiento.count()]
    }

    def agregarSeguimientoTurnado(Long id){
        
    
        def idDocumento
        idDocumento=params?.document
        
        if(params?.document){
            def documentoInstance = Documento.get(idDocumento as int)
            def querySeguimiento="From Seguimiento s where s.documento=${idDocumento} order by s.fechaCaptura desc"
            [documentoInstance: documentoInstance, seguimientoInstance:Seguimiento.findAll(querySeguimiento)]
            
        }else{
            
            def documentoInstance = Documento.get(id as int)
            def querySeguimiento="From Seguimiento s where s.documento=${id} order by s.fechaCaptura desc"
            def seguimientoInstance = Seguimiento.findAll(querySeguimiento)
            [documentoInstance: documentoInstance, seguimientoInstance:seguimientoInstance]
        
            
        }
    }
    def agregarSeguimiento(Long id){
       
        def idDocumento
        idDocumento=params?.document
        
        if(params?.document){
            def documentoInstance = Documento.get(idDocumento as int)
            def querySeguimiento="From Seguimiento s where s.documento=${idDocumento} order by s.fechaCaptura desc"
            [documentoInstance: documentoInstance, seguimientoInstance:Seguimiento.findAll(querySeguimiento)]
            
        }else{
            
            def documentoInstance = Documento.get(id as int)
            def querySeguimiento="From Seguimiento s where s.documento=${id} order by s.fechaCaptura desc"
            def seguimientoInstance = Seguimiento.findAll(querySeguimiento)
            [documentoInstance: documentoInstance, seguimientoInstance:seguimientoInstance]
        
            
        }
        
            
           
        
        
        
    }
    def saveSeguimientoTurnado(){
        
        def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def usuario=UsuarioSistema.get(idUsuario)
        
        def seguimientoInstance = new Seguimiento(params)
        def idDocument=params?.document as int
        
        def documentoInstance = Documento.get(idDocument as int)
        seguimientoInstance.fechaCaptura = new Date()
        seguimientoInstance.usuarioSistema=usuario
        seguimientoInstance.seguimiento=params.seguimiento
        
        
         if (!seguimientoInstance.save(flush: true)) {
            
            redirect(action: "agregarSeguimientoTurnado", id:params.document)
            return
        }
        
        //Actualizamos el status del documento con las siguientes dos lineas
        //0) Creado
        //1) Turnado
        if(documentoInstance.status==0 || documentoInstance.status==1){
            Documento.executeUpdate("update Documento d set d.status=2 " +
                      "where d.id=${idDocument as int}")
        }else{//fin de if e inicio del else
        
        }//fin else
        
        def query = "From Seguimiento s where s.documento=${idDocument} order by s.fechaCaptura desc"
        render(view: "agregarSeguimientoTurnado", model: [documentoInstance: documentoInstance, seguimientoInstance:Seguimiento.findAll(query)])
        
        
        
    }
    def saveSeguimiento(){
        def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def usuario=UsuarioSistema.get(idUsuario)
        
        def seguimientoInstance = new Seguimiento(params)
        def idDocument=params?.document as int
        
        def documentoInstance = Documento.get(idDocument as int)
        seguimientoInstance.fechaCaptura = new Date()
        seguimientoInstance.usuarioSistema=usuario
        seguimientoInstance.seguimiento=params.seguimiento
        
        
         if (!seguimientoInstance.save(flush: true)) {
            
            redirect(action: "agregarSeguimiento", id:params.document)
            return
        }
        
        //Actualizamos el status del documento con las siguientes dos lineas
        //0) Creado
        //1) Turnado
        if(documentoInstance.status==0 || documentoInstance.status==1){
            Documento.executeUpdate("update Documento d set d.status=2 " +
                      "where d.id=${idDocument as int}")
        }else{//fin de if e inicio del else
        
        }//fin else
        
        def query = "From Seguimiento s where s.documento=${idDocument} order by s.fechaCaptura desc"
        render(view: "agregarSeguimiento", model: [documentoInstance: documentoInstance, seguimientoInstance:Seguimiento.findAll(query)])
        
        
        
    }
    
    def deleteSeguimientoTurnado(){
        
        def idSeguimiento = params.id as int
        
        def seguimientoInstance = Seguimiento.get(idSeguimiento)
        if (!seguimientoInstance.save(flush: true)) {
            flash.message = "Error al actualizar el seguimiento"
            redirect(action: "agregarSeguimientoTurnado", id: idTurnado) 
        }
        
        if(seguimientoInstance.delete(flush:true)){
        }else{
            
        }

        
        def idDocumento=params.documento.id
        def documentoInstance = Documento.get(idDocumento)
        def query="From Seguimiento s where s.documento=${idDocumento} order by s.fechaCaptura desc"
        def seguimientoInstances=Seguimiento.findAll(query)
        
        if(!seguimientoInstances){//Si no hay personas turnadas a este documento se actualiza el status del documento a creado
            //con las siguientes lineas actualizamos el status del documento a creado "0"
            Documento.executeUpdate("update Documento d set d.status=1 " +
                      "where d.id=${idDocumento as int}")
            
        }
        flash.message = "El seguimiento fue declinado de este documento"
        render(view: "agregarSeguimientoTurnado", model: [documentoInstance: documentoInstance, seguimientoInstance:seguimientoInstances])
        
        
    }
    
    def deleteSeguimiento(){
        
        def idSeguimiento = params.id as int
        
        def seguimientoInstance = Seguimiento.get(idSeguimiento)
        if (!seguimientoInstance.save(flush: true)) {
            flash.message = "Error al actualizar el seguimiento"
            redirect(action: "agregarSeguimiento", id: idTurnado) 
        }
        
        if(seguimientoInstance.delete(flush:true)){
        }else{
            
        }

        
        def idDocumento=params.documento.id
        def documentoInstance = Documento.get(idDocumento)
        def query="From Seguimiento s where s.documento=${idDocumento} order by s.fechaCaptura desc"
        def seguimientoInstances=Seguimiento.findAll(query)
        
        if(!seguimientoInstances){//Si no hay personas turnadas a este documento se actualiza el status del documento a creado
            //con las siguientes lineas actualizamos el status del documento a creado "0"
            Documento.executeUpdate("update Documento d set d.status=1 " +
                      "where d.id=${idDocumento as int}")
            
        }
        flash.message = "El seguimiento fue declinado de este documento"
        render(view: "agregarSeguimiento", model: [documentoInstance: documentoInstance, seguimientoInstance:seguimientoInstances])
        
        
    }
    def create() {
        [seguimientoInstance: new Seguimiento(params)]
    }

    def save() {
        def seguimientoInstance = new Seguimiento(params)
        if (!seguimientoInstance.save(flush: true)) {
            render(view: "create", model: [seguimientoInstance: seguimientoInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'seguimiento.label', default: 'Seguimiento'), seguimientoInstance.id])
        redirect(action: "show", id: seguimientoInstance.id)
    }

    def showSegTurnado(Long id) {
        def seguimientoInstance = Seguimiento.get(id)
        if (!seguimientoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seguimiento.label', default: 'Seguimiento'), id])
            redirect(action: "create")
            return
        }

        [seguimientoInstance: seguimientoInstance]
    }
    
    def show(Long id) {
        def seguimientoInstance = Seguimiento.get(id)
        if (!seguimientoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seguimiento.label', default: 'Seguimiento'), id])
            redirect(action: "list")
            return
        }

        [seguimientoInstance: seguimientoInstance]
    }

    def editTurnado(Long id){
        def seguimientoInstance = Seguimiento.get(id)
        if (!seguimientoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seguimiento.label', default: 'Seguimiento'), id])
            redirect(action: "list")
            return
        }

        [seguimientoInstance: seguimientoInstance]
    }
    def edit(Long id) {
        def seguimientoInstance = Seguimiento.get(id)
        if (!seguimientoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seguimiento.label', default: 'Seguimiento'), id])
            redirect(action: "list")
            return
        }

        [seguimientoInstance: seguimientoInstance]
    }
def updateTurnado(Long id, Long version) {
        def seguimientoInstance = Seguimiento.get(id)
        if (!seguimientoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seguimiento.label', default: 'Seguimiento'), id])
            redirect(action: "create")
            return
        }

        if (version != null) {
            if (seguimientoInstance.version > version) {
                seguimientoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'seguimiento.label', default: 'Seguimiento')] as Object[],
                          "Another user has updated this Seguimiento while you were editing")
                render(view: "editTurnado", model: [seguimientoInstance: seguimientoInstance])
                return
            }
        }

        seguimientoInstance.properties = params

        if (!seguimientoInstance.save(flush: true)) {
            render(view: "editTurnado", model: [seguimientoInstance: seguimientoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'seguimiento.label', default: 'Seguimiento'), seguimientoInstance.id])
        redirect(action: "showSegTurnado", id: seguimientoInstance.id)
    }
    def update(Long id, Long version) {
        def seguimientoInstance = Seguimiento.get(id)
        if (!seguimientoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seguimiento.label', default: 'Seguimiento'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (seguimientoInstance.version > version) {
                seguimientoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'seguimiento.label', default: 'Seguimiento')] as Object[],
                          "Another user has updated this Seguimiento while you were editing")
                render(view: "edit", model: [seguimientoInstance: seguimientoInstance])
                return
            }
        }

        seguimientoInstance.properties = params

        if (!seguimientoInstance.save(flush: true)) {
            render(view: "edit", model: [seguimientoInstance: seguimientoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'seguimiento.label', default: 'Seguimiento'), seguimientoInstance.id])
        redirect(action: "show", id: seguimientoInstance.id)
    }

    def delete(Long id) {
        def seguimientoInstance = Seguimiento.get(id)
        if (!seguimientoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seguimiento.label', default: 'Seguimiento'), id])
            redirect(action: "list")
            return
        }

        try {
            seguimientoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'seguimiento.label', default: 'Seguimiento'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'seguimiento.label', default: 'Seguimiento'), id])
            redirect(action: "show", id: id)
        }
    }
}
