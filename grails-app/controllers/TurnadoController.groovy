import org.springframework.dao.DataIntegrityViolationException
import grails.converters.*
import org.springframework.dao.DataIntegrityViolationException
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.springframework.*
import org.springframework.web.multipart.*



class TurnadoController {

    def springSecurityService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST",ajaxGetUnidadesAdmin:"GET", ajaxGetPersonaResponsable:"GET", ajaxGetPersona:"GET"]

    
    def mailService
    def index() {
        redirect(action: "list", params: params)
    }
    
    
def downloadFile(){
    def file = new File(servletContext.getRealPath("images/reports/archivo.pdf"))

if (file.exists()) {
   response.setContentType("application/octet-stream")
   response.setHeader("Content-disposition", "filename=${file.name}")
   response.outputStream << file.bytes
   return
}
}
    def upload() {
   
    }
boolean transactional = true
    def uploadFile() {
        def file=request.getFile('myFile')
        def name="archivo.pdf"
        def destinationDirectory = "images/reports/"
        
        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath(destinationDirectory)

        // Create storage path directory if it does not exist
        def storagePathDirectory = new File(storagePath)
        if (!storagePathDirectory.exists()) {
            print "CREATING DIRECTORY ${storagePath}: "
            if (storagePathDirectory.mkdirs()) {
//                println "SUCCESS"
            } else {
//                println "FAILED"
            }
        }

        
        // Store file
        if (!file.isEmpty()) {
            file.transferTo(new File("${storagePath}/${name}"))
//            println "Saved file: ${storagePath}/${name}"
            
            redirect(action: "upload")
            //return "${storagePath}/${name}"// este es para que nos retorne la ruta donde se guardo

        } else {
//            println "File ${file.inspect()} was empty!"
            return null
        }
       
        
    }
    
    //   def uploadFile(){
    //        def f = request.getFile('myFile')
    //    if (f.empty) {
    //        flash.message = 'file cannot be empty'
    //        render(view: 'uploadFile')
    //        return
    //    }
    //    f.transferTo(new File(servletContext.getRealPath("images/reports/")+"archivo.pdf"))
    //    
    //    response.sendError(200, 'Done')
    //    println"la ruta es: "+servletContext.getRealPath("images/reports/")
    //        render(view: "upload")
    //        return
    //   } 
    def send={
        
        def f = request.getFile('uploadedFile')
        
        def idDocumento=params.document
        def documentoInstance = Documento.get(idDocumento)
        def folioDoc=documentoInstance.folio as String
        
        
        def  turnadoInstance = Turnado.executeQuery("Select t.persona.correo From Turnado t where t.documento=${idDocumento as int}")
        
        def correo = turnadoInstance[0] as String
        
      
        //         def queryPersona="select p.correo from Persona p where p.id=${params.persona.id}"
        //        def personaInstance=Persona.executeQuery(queryPersona)              
        //        def correo= personaInstance[0] as String
        
        try{
            mailService.sendMail {
       
                multipart true
                to turnadoInstance
                //bcc "omartinez.stc@gmail.com"
                from '"Gobierno del estado" <Morelos>'
 
                subject "Sistema de Correspondencia"
                text "Buen Dia! \n\
Porfavor, sirvase a leer el documento que a continuación se adjunta\n\
\n\
\n\
\n\
\n\
El Folio del documento es: ${folioDoc}\n\
No es necesario que responda a este correo...\n\
\n\
Para visualizar la informacion en el sistema click en este link http://pruebas.gobiernodigital.morelos.gob.mx/SGC"
           
                attachBytes "correspondencia.pdf", "text/pdf", f.bytes
            
            }

          
            flash.message = ("El correo se ha enviado a :"+turnadoInstance)
            redirect(action: "agregarDependenciasNombre", id:params.document)
        }catch(Exception e){
          
            flash.error = ("El correo No se pudo enviar a :"+turnadoInstance+" debido a un error, Favor de revisar las direcciones de correo.")
            redirect(action: "agregarDependenciasNombre", id:params.document)
            
        }
        
        
        
    }
    
//    def ajaxGetUnidadesAdmin(){
//        
//        
//        def Cadena = params.id as String   
//        
//        def listUnidades = UnidadAdmin.findAll("FROM UnidadAdmin u WHERE u.dependencia=${Cadena}")  
//       
//        def resultadoFormateado = listUnidades.collect {
//            [
//                id: it.id,                
//                nombre: it.nombre            
//            ]
//        }        
//        render resultadoFormateado as JSON       
//        
//    }
    def agregarDependenciasNombre(Long id){
        
       
        def idDocumento
        
        if(params?.document){
            idDocumento=params?.document
            
            def query="From Dependencia"
            def documentoInstance = Documento.get(idDocumento)
            def queryTurnado="From Turnado t where t.documento=${idDocumento}"
            [documentoInstance: documentoInstance, dependenciaInstance:Dependencia.findAll(query), turnadoInstance:Turnado.findAll(queryTurnado)]
        
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
        }
        
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
//    def ajaxGetPersonaResponsable(){
//        
//        def Cadena = params.id as String   
//        
//        def listPersonas = Persona.findAll("FROM Persona p WHERE p.unidadAdmin=${Cadena}")  
//       
//        def resultadoFormateado = listPersonas.collect {
//            [
//                id: it.id,                
//                nombre: it.nombre            
//            ]
//        }        
//        render resultadoFormateado as JSON       
//    }
    
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [turnadoInstanceList: Turnado.list(params), turnadoInstanceTotal: Turnado.count()]
    }

    def create() {
        [turnadoInstance: new Turnado(params)]
    }

    //    def save() {
    //        println"porque estamos aqui????"
    //        def turnadoInstance = new Turnado(params)
    //        if (!turnadoInstance.save(flush: true)) {
    //            render(view: "create", model: [turnadoInstance: turnadoInstance])
    //            return
    //        }
    //
    //        flash.message = message(code: 'default.created.message', args: [message(code: 'turnado.label', default: 'Turnado'), turnadoInstance.id])
    //        redirect(action: "show", id: turnadoInstance.id)
    //    }

    def agregarDependencias(Long id){
        
   
        def idDocumento
        
        if(params?.document){
            idDocumento=params?.document
            
            def query="From Dependencia"
            def documentoInstance = Documento.get(idDocumento)
            def queryTurnado="From Turnado t where t.documento=${idDocumento}"
            [documentoInstance: documentoInstance, dependenciaInstance:Dependencia.findAll(query), turnadoInstance:Turnado.findAll(queryTurnado)]
        
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
        }
        
    }
    
    
    
    
    def saveDependenciasTurnadas(){
       
        
        
        def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def usuario=UsuarioSistema.get(idUsuario)
        
        
        def idDocument=params?.document as int
        
        def queryTurnado = Turnado.executeQuery("Select count(t.id) from Turnado t where t.persona=${params?.personaID} and t.documento=${idDocument as int}")
        def duplicadoTurnado=queryTurnado[0]
        if(duplicadoTurnado){
            
            flash.error = ("La persona ya ha sido agregada")
            redirect(action: "agregarDependenciasNombre", id:params.document)
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
        def documentoInstance = Documento.get(idDocument as int)
        def turnadoInstance = new Turnado()
        turnadoInstance.fechaTurnado = new Date()
        turnadoInstance.status = 0
        turnadoInstance.usuarioSistema=usuario//asasdaaaaaaaaaaaaaaaaaaaa
        turnadoInstance.dependencia=dependenciaInstance
        //turnadoInstance.unidadAdmin=unidadAdminInstance
        turnadoInstance.persona=personaInstance
        turnadoInstance.documento = documentoInstance
        turnadoInstance.responsabilidad = params?.responsabilidad
        
//        println"Params son fecha:"+turnadoInstance.fechaTurnado
//        println"Params son status:"+turnadoInstance.status
//        println"Params son user:"+turnadoInstance.usuarioSistema
//        println"Params son dependencia:"+ turnadoInstance.dependencia
//        //println"Params son unidad :"+ turnadoInstance.unidadAdmin
//        println"Params son persona:"+turnadoInstance.persona
//        
       
       
       
        //Con este fragmento de código podremos guardar el turnado y al mismo tiempo saber 
        //si el turnado no fue guardado redireccionamos hacia agregar dependencias
        if(!turnadoInstance){
           
        }
        if (!turnadoInstance.save(flush: true)) {
           
            flash.error=("No se pudo guardar")
            redirect(action: "agregarDependenciasNombre", id:params.document)
            return
        }
        
        //Actualizamos el status del documento con las siguientes dos lineas
        if(documentoInstance.status==0 || documentoInstance.status==1){
            Documento.executeUpdate("update Documento d set d.status=1 " +
                      "where d.id=${params.document as int}")
        }else{//fin de if e inicio del else
        
        }//fin else
        
        //Hacemos el query para regresar la lista de turnados a ese documento
        def query="From Turnado t where t.documento=${idDocument}"
        
        //Regresamos el mensaje de que fue creado y regresamos a la vista agregar dependencias
        flash.message = message(code: 'default.created.message', args: [message(code: 'turnado.label', default: 'Turnado'), turnadoInstance.id])
        render(view: "agregarDependenciasNombre", model: [documentoInstance: documentoInstance, turnadoInstance:Turnado.findAll(query)])
        
    }
    
    def show(Long id) {
        def turnadoInstance = Turnado.get(id)
        if (!turnadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'turnado.label', default: 'Turnado'), id])
            redirect(action: "list")
            return
        }

        [turnadoInstance: turnadoInstance]
    }

    def edit(Long id) {
        def turnadoInstance = Turnado.get(id)
        if (!turnadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'turnado.label', default: 'Turnado'), id])
            redirect(action: "list")
            return
        }

        [turnadoInstance: turnadoInstance]
    }

    def update(Long id, Long version) {
        def turnadoInstance = Turnado.get(id)
        if (!turnadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'turnado.label', default: 'Turnado'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (turnadoInstance.version > version) {
                turnadoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'turnado.label', default: 'Turnado')] as Object[],
                          "Another user has updated this Turnado while you were editing")
                render(view: "edit", model: [turnadoInstance: turnadoInstance])
                return
            }
        }

        turnadoInstance.properties = params

        if (!turnadoInstance.save(flush: true)) {
            render(view: "edit", model: [turnadoInstance: turnadoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'turnado.label', default: 'Turnado'), turnadoInstance.id])
        redirect(action: "show", id: turnadoInstance.id)
    }

    def deleteDep(){
      
        def idTurnado = params.id as int
        
        def turnadoInstance = Turnado.get(idTurnado)
        if (!turnadoInstance.save(flush: true)) {
            flash.message = "Error al actualizar el turnado"
            redirect(action: "agregarDependenciasNombre", id: idTurnado) 
        }
        
        if(turnadoInstance.delete(flush:true)){                           
        }else{                       
        }
        
        def idDocumento=params.documento.id
        def documentoInstance = Documento.get(idDocumento)
        def query="From Turnado t where t.documento=${idDocumento}"
        def turnadoInstances=Turnado.findAll(query)
        
        if(!turnadoInstances){//Si no hay personas turnadas a este documento se actualiza el status del documento a creado
            //con las siguientes lineas actualizamos el status del documento a creado "0"
            Documento.executeUpdate("update Documento d set d.status=0 " +
                      "where d.id=${idDocumento as int}")
            
        }
        flash.message = "La dependencia y unidad fueron declinadas de este turnado"
        render(view: "agregarDependenciasNombre", model: [documentoInstance: documentoInstance, turnadoInstance:turnadoInstances])
        
        
    }
    
    def delete(Long id) {
        def turnadoInstance = Turnado.get(id)
        if (!turnadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'turnado.label', default: 'Turnado'), id])
            redirect(action: "list")
            return
        }

        try {
            turnadoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'turnado.label', default: 'Turnado'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'turnado.label', default: 'Turnado'), id])
            redirect(action: "show", id: id)
        }
    }
}
