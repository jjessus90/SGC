import grails.converters.*
import org.springframework.dao.DataIntegrityViolationException
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.springframework.*
import org.springframework.web.multipart.*
import java.util.*;
import pl.touk.excel.export.WebXlsxExporter
import pl.touk.excel.export.XlsxExporter
import pl.touk.excel.export.getters.LongToDatePropertyGetter
import pl.touk.excel.export.getters.MessageFromPropertyGetter

class DocumentoController {

    
    def springSecurityService
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST", buscadorAjax:"GET", buscarFolioAjax:"GET", buscadorAjaxDependencias:"GET"]

    def createDoc() {
        
        
        def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def user=UsuarioSistema.get(idUsuario as int)
        def rolee=user.authorities.id[0] as int//rol del usuario
        //println"el rol es: "+rolee
        if(rolee==1 || rolee==6){
            
            redirect(action: "createDCCA", model:[documentoInstance: new Documento(params)])
            return
        }else if(rolee==5 || rolee==3){
            redirect(action: "create", model:[documentoInstance: new Documento(params)])
            //println "llego hasta aqui"
            return
            
        }
        else if(rolee==4){
            redirect(action: "createGiras", model:[documentoInstance: new Documento(params)])
            //println "llego hasta aqui"
            return
        }
        //[documentoInstance: new Documento(params)]
    }
    def create(){
        
        //println("create helooo")
        def query="From Indicacion"
        [documentoInstance: new Documento(params), indicacionInstance:Indicacion.findAll(query)]
    }
    
    def createGiras(){
        
        //println("create helooo")
        def query="From Indicacion"
        [documentoInstance: new Documento(params), indicacionInstance:Indicacion.findAll(query)]
    }
    
    def saveGiras(){
        println "INDICACION-----"+params.indicacion
        
        def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def user=UsuarioSistema.get(idUsuario as int)
        def rolee=user.authorities.id[0] as int
//        println"el rol es: "+rolee        
        def documentoInstance = new Documento(params)
        def ind = params.indicacion.id as int
        documentoInstance.indicacion.id = ind
//        println "evento: "+documentoInstance.evento
        def date=new Date()
        def year = ((date.getYear() as int)+1900);
        
        ////    S I    E L   R O L    E S   4****************/////
        if(rolee==4){
           
            def queryExist=Documento.executeQuery("Select Max(d.id) From Documento d where d.folio like '%GIRAS%'")
        
            def idDocu=queryExist[0]
            
            def documentoInst 
        
            if(!idDocu){
            
                documentoInstance.folio="GIRAS"+"-"+"000001-"+year
            
            }else if(idDocu){
                documentoInst = Documento.get(queryExist[0] as int)
            
                def splitfolio=(documentoInst.folio).split("-")
            
                def asIntFolio = splitfolio[1] as int
                asIntFolio=asIntFolio+1
                asIntFolio = asIntFolio as String
             
                asIntFolio=asIntFolio.padLeft(6,"0")
                documentoInstance.folio="GIRAS-"+asIntFolio+"-"+year
            }
        }//fin if rolee 4
        ////    S I    E L   R O L    E S   5****************/////
                
        //************modificamos los parametros de usuario, fecha de captura y status************
        documentoInstance.usuarioSistema=user
        documentoInstance.fechaCaptura= new Date()
        documentoInstance.status=0

          
        
        //        if (!documentoInstance.save(flush: true)) {
        //            flash.error="Porfavor escriba nuevamente y elija de a lista de abajo..."
        //            render(view: "create", model: [documentoInstance: documentoInstance])
        //            return
        //        }

        if(!params["persona"] && !params["dependenciaRemitente"]){
           
            flash.error = "Porfavor, busque nuevamente el remitente y a continuación, seleccione de la lista conveniente"
            redirect(action: "createGiras", documentoInstance: documentoInstance)
            return
        }//fin if remitente
        
        if(params["persona"] && params["dependenciaRemitente"]){
            flash.error = "Porfavor, Elija solo un remitente NO puede elegir 2"
            redirect(action: "createGiras", documentoInstance: documentoInstance)
            return
            
        }
        if(!params["persona"]){

            if(params["dependenciaRemitente"]){

//                println"en dependencia"
                if (!documentoInstance.save(flush: true)) {
                    render(view: "create", model: [documentoInstance: documentoInstance])
                    return
                }//fin save
              
                flash.message = message(code: 'default.created.message', args: [message(code: 'documento.label', default: 'Documento'), documentoInstance.id])
                redirect(action: "show", id: documentoInstance.id)
        
            }//fin if dependenciaRemitente
            else{
                flash.error = "Porfavor, busque nuevamente el remitente y a continuación, seleccione de la lista conveniente"
                redirect(action: "createGiras", documentoInstance: documentoInstance)
                return
            
            }//fin else
        }
        
        else{
            
            if (!documentoInstance.save(flush: true)) {
                flash.error="Debes de elegir algun remitente ya sea dependencia o persona..."
                render(view: "createGiras", model: [documentoInstance: documentoInstance])
                return
            }
            
            flash.message = message(code: 'default.created.message', args: [message(code: 'documento.label', default: 'Documento'), documentoInstance.id])
            redirect(action: "show", id: documentoInstance.id)
        }//fin else guardar remitente
        
    }
    
    
    def save() {
       

        def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def user=UsuarioSistema.get(idUsuario as int)
        def rolee=user.authorities.id[0] as int
//        println"el rol es: "+rolee  
        def documentoInstance = new Documento(params)
        
        def date=new Date()
        def year = ((date.getYear() as int)+1900);
        ////    S I    E L   R O L    E S   4****************/////
        if(rolee==4){
            

            def queryExist=Documento.executeQuery("Select Max(d.id) From Documento d where d.folio like '%GIRAS%'")
        
            def idDocu=queryExist[0]
        
            def documentoInst 
        
            if(!idDocu){
            
                documentoInstance.folio="GIRAS"+"-"+"000001-"+year
            
            }else if(idDocu){
                documentoInst = Documento.get(queryExist[0] as int)
            
                def splitfolio=(documentoInst.folio).split("-")
            
                def asIntFolio = splitfolio[1] as int
                asIntFolio=asIntFolio+1
                asIntFolio = asIntFolio as String
             
                asIntFolio=asIntFolio.padLeft(6,"0")
                documentoInstance.folio="GIRAS-"+asIntFolio+"-"+year
            }
        }//fin if rolee 4
        ////    S I    E L   R O L    E S   5****************/////
        else if(rolee==5){
            
            def queryExist=Documento.executeQuery("Select Max(d.id) From Documento d where d.folio like '%SEG%'")
        
            def idDocu=queryExist[0]
        
            def documentoInst 
        
            if(!idDocu){
            
                documentoInstance.folio="SEG"+"-"+"000001-"+year
            
            }else if(idDocu){
                documentoInst = Documento.get(queryExist[0] as int)
            
                def splitfolio=(documentoInst.folio).split("-")
            
                def asIntFolio = splitfolio[1] as int
                asIntFolio=asIntFolio+1
                asIntFolio = asIntFolio as String
             
                asIntFolio=asIntFolio.padLeft(6,"0")
                documentoInstance.folio="SEG-"+asIntFolio+"-"+year
            }
        }//***********************FIN ROLE 5************************************************///////
        else if(rolee==3){
            
             def queryExist=Documento.executeQuery("Select Max(d.id) From Documento d where d.folio like '%DCCA%'")
        
        def idDocu=queryExist[0]
        
        def documentoInst 
        
        if(!idDocu && year==2016){
           
            documentoInstance.folio="DCCA"+"-"+"000001-"+year
            
        }else if(idDocu){
            documentoInst = Documento.get(queryExist[0] as int)
            
            def splitfolio=(documentoInst.folio).split("-")
            
            def asIntFolio = splitfolio[1] as int
            asIntFolio=asIntFolio+1
            asIntFolio = asIntFolio as String
             
            asIntFolio=asIntFolio.padLeft(6,"0")
            documentoInstance.folio="DCCA-"+asIntFolio+"-"+year
            
        }
        }
        
        //************modificamos los parametros de usuario, fecha de captura y status************
        documentoInstance.usuarioSistema=user
        documentoInstance.fechaCaptura= new Date()
        documentoInstance.status=0
        
        
        //        if (!documentoInstance.save(flush: true)) {
        //            flash.error="Porfavor escriba nuevamente y elija de a lista de abajo..."
        //            render(view: "create", model: [documentoInstance: documentoInstance])
        //            return
        //        }

        if(!params["persona"] && !params["dependenciaRemitente"]){
           
            flash.error = "Porfavor, busque nuevamente el remitente y a continuación, seleccione de la lista conveniente"
            redirect(action: "create", documentoInstance: documentoInstance)
            return
        }//fin if remitente
        
        if(params["persona"] && params["dependenciaRemitente"]){
            flash.error = "Porfavor, Elija solo un remitente NO puede elegir 2"
            redirect(action: "create", documentoInstance: documentoInstance)
            return
            
        }
        if(!params["persona"]){
            if(params["dependenciaRemitente"]){
//                println"en dependencia"
                if (!documentoInstance.save(flush: true)) {
                    render(view: "create", model: [documentoInstance: documentoInstance])
                    return
                }//fin save
               
                flash.message = message(code: 'default.created.message', args: [message(code: 'documento.label', default: 'Documento'), documentoInstance.id])
                redirect(action: "show", id: documentoInstance.id)
        
            }//fin if dependenciaRemitente
            else{
                flash.error = "Porfavor, busque nuevamente el remitente y a continuación, seleccione de la lista conveniente"
                redirect(action: "create", documentoInstance: documentoInstance)
                return
            
            }//fin else
        }
        
        else{
        
            if (!documentoInstance.save(flush: true)) {
                flash.error="Debes de elegir algun remitente ya sea dependencia o persona..."
                render(view: "create", model: [documentoInstance: documentoInstance])
                return
            }
//            println ("hellooooo")
            flash.message = message(code: 'default.created.message', args: [message(code: 'documento.label', default: 'Documento'), documentoInstance.id])
            redirect(action: "show", id: documentoInstance.id)
        }//fin else guardar remitente
        
    }
    
    def editDocumentoCreado(Long id){
        def documentoInstance = Documento.get(id)
        if (!documentoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")    
            return
        }
        def indicacionInstance = Indicacion.findAll("From Indicacion")
        [documentoInstance: documentoInstance, indicacionInstance:indicacionInstance]  
    }
    
    def buscadorAjaxDependencias () {
        
        def Cadena = params.id as String   
        def list = new Dependencia()
        def listDependencias = Dependencia.findAll("FROM Dependencia d WHERE d.nombre like '%${Cadena}%'")  
       
        def resultadoFormateado = listDependencias.collect {
            [
                id: it.id,                
                nombre: it.nombre            
            ]
        }        
        render resultadoFormateado as JSON        
          
    }
    
    def createDCCA() {
        [documentoInstance: new Documento(params)]
    }
    def showDocumentoCreado(Long id) {
        def documentoInstance = Documento.get(id)
        if (!documentoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }

        [documentoInstance: documentoInstance]
    }
    def saveDCCA() {
           
        def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def user=UsuarioSistema.get(idUsuario as int)
        def rolee=user.authorities.id[0] as int
//        println"el rol es: "+rolee
        def documentoInstance = new Documento(params)
        def date=new Date()
        def year = ((date.getYear() as int)+1900);
        
        //def dirigidoA = params.dirigido as String
        
       
        def queryExist=Documento.executeQuery("Select Max(d.id) From Documento d where d.folio like '%DCCA%'")
        
        def idDocu=queryExist[0]
        
        def documentoInst 
        
        if(!idDocu && year==2015){
            
            documentoInstance.folio="DCCA"+"-"+"000001-"+year
            
        }else if(idDocu){
            documentoInst = Documento.get(queryExist[0] as int)
            
            def splitfolio=(documentoInst.folio).split("-")
            
            def asIntFolio = splitfolio[1] as int
            asIntFolio=asIntFolio+1
            asIntFolio = asIntFolio as String
             
            asIntFolio=asIntFolio.padLeft(6,"0")
            documentoInstance.folio="DCCA-"+asIntFolio+"-"+year
        }
        
        
        //************modificamos los parametros de usuario, fecha de captura y status************
        documentoInstance.usuarioSistema=user
        documentoInstance.fechaCaptura= new Date()
        documentoInstance.status=0
        
        
        

        
        if(params["persona"] && params["dependenciaRemitente"]){
            flash.error = "Porfavor, Elija solo un remitente NO puede elegir 2"
            redirect(action: "createDCCA", documentoInstance: documentoInstance)
            return
            
        }
        if(!params["persona"]){
            if(params["dependenciaRemitente"]){
//                println"en dependencia"
                if (!documentoInstance.save(flush: true)) {
                    render(view: "createDCCA", model: [documentoInstance: documentoInstance])
                    return
                }//fin save

                flash.message = message(code: 'default.created.message', args: [message(code: 'documento.label', default: 'Documento'), documentoInstance.id])
                redirect(action: "showDocumentoCreado", id: documentoInstance.id)
        
            }//fin if dependenciaRemitente
            else{
                flash.error = "Porfavor, busque nuevamente el remitente y a continuación, seleccione de la lista conveniente"
                redirect(action: "createDCCA", documentoInstance: documentoInstance)
                return
            
            }//fin else
        }//fin if remitente
        else{
        
            if (!documentoInstance.save(flush: true)) {
                render(view: "createDCCA", model: [documentoInstance: documentoInstance])
                return
            }

            flash.message = message(code: 'default.created.message', args: [message(code: 'documento.label', default: 'Documento'), documentoInstance.id])
            redirect(action: "showDocumentoCreado", id: documentoInstance.id)
        }//fin else guardar remitente
    }
    
    def buscarDocFechaDep(){
        
        def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def user=UsuarioSistema.get(idUsuario as int)
        def dependencia = user.dependencia.id as int
        
        def fechaInicio = new Date()
        def fechaFin = new Date()  
        def listDocs =[]
               
        
        
        fechaInicio = fechaInicio.format("yyyy-MM-dd"+' 00:00:00')
        fechaFin = fechaFin.format("yyyy-MM-dd"+' 23:59:59')
        def turnadoInst = Turnado.findAll("From Turnado t where t.dependencia=${dependencia} and t.fechaTurnado >=  '${fechaInicio}' AND t.fechaTurnado <= '${fechaFin}'")
        def i
        
        for(i=0;i<turnadoInst.size();i++){
            listDocs.add(Documento.get(turnadoInst[i].documento.id))
            
        }
        
        
        def max = params?.max==null?10:params?.max as int
        def offset = params?.offset==null?0: params?.offset as int  
        def mapa = [max:max, offset:offset]                
        def query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}'"                        
        def total=10
             
        params.max = Math.min(max ?: 10, 100)
        //params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
        [documentoInstanceList: listDocs, documentoInstanceTotal: total, fechaInicio:params.fechaInicio,fechaFin:params.fechaFin]
    }
   
    def consultaDocFechaDep(){
       
//        println "id dependencia: "+params.dependencia
        def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def user=UsuarioSistema.get(idUsuario as int)
        def dependencia = user.dependencia.id as int
        
        def fechaInicio = params.fechaInicio
        def fechaFin = params.fechaFin
        def listDocs =[]
               
        fechaInicio = fechaInicio.format("yyyy-MM-dd"+' 00:00:00')
        fechaFin = fechaFin.format("yyyy-MM-dd"+' 23:59:59')
        def dependencias = Dependencia.findAll("FROM Dependencia where id='${params.dependencia.id}'")
        //println "dependencias: " +dependencias
        def turnadoInst = Turnado.findAll("From Turnado t where t.fechaTurnado >=  '${fechaInicio}' AND t.fechaTurnado <= '${fechaFin}'")
        
        def max = params?.max==null?10:params?.max as int
        def offset = params?.offset==null?0: params?.offset as int  
        def mapa = [max:max, offset:offset]                
        //def query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}' where dependenciaRemitente='${dependenciaRemit}'"                        
        def total=10
        def turnadoInstDos = Turnado.findAll("From Turnado t where t.fechaTurnado >=  '${fechaInicio}' AND t.fechaTurnado <= '${fechaFin}' AND dependencia='${params.dependencia.id}'")
        def i
       
        for(i=0;i<turnadoInstDos.size();i++){
            listDocs.add(Documento.get(turnadoInstDos[i].documento.id))
            
        }     
        params.max = Math.min(max ?: 10, 100)
        //params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
        
        render(view: "buscarDocDep", model: [documentoInstanceList: listDocs, documentoInstanceTotal: total, fechaInicio:params.fechaInicio,fechaFin:params.fechaFin] )
        return
        
        //        [documentoInstanceList: listDocs, documentoInstanceTotal: total, fechaInicio:params.fechaInicio,fechaFin:params.fechaFin]
    }
    
        
    def downloadFile(){
        
        def file = new File(servletContext.getRealPath("images/reports/"+params.folio+".pdf"))

        if (file.exists()) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "filename=${file.name}")
            response.outputStream << file.bytes
            return
        }
    }

    boolean transactional = true
    def uploadFile() {
        println params
        def file=request.getFile('myFile')
        def name=params.foly+".pdf"
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
            
            Documento.executeUpdate("update Documento d set d.upload='${storagePath}/${name}' " +
                      "where d.id=${params.documentoiD as int}")
            file.transferTo(new File("${storagePath}/${name}"))
//            println "Saved file: ${storagePath}/${name}"
            flash.message = "¡Se ha cargado el archivo correctamente!"
            redirect(action: "show", id: params.documentoiD as int)
            //return "${storagePath}/${name}"// este es para que nos retorne la ruta donde se guardo

        } else {
            flash.error=("¡El archivo no se pudo guardar!")
            
//            println "File ${file.inspect()} was empty!"
            redirect(action: "show", id: params.documentoiD as int)
        }
       
        
    }
    
    def updateDocumento() {
        def dependencia=params.clasificacion
     
//        def name=params.foly+".pdf"
//        def destinationDirectory = "images/reports/"
//        
//        def servletContext = ServletContextHolder.servletContext
//        def storagePath = servletContext.getRealPath(destinationDirectory)
//
//        // Create storage path directory if it does not exist
//        def storagePathDirectory = new File(storagePath)
//        if (!storagePathDirectory.exists()) {
//            print "CREATING DIRECTORY ${storagePath}: "
//            if (storagePathDirectory.mkdirs()) {
//                 
//                println "SUCCESS"
//            } else {
//                println "FAILED"
//            }
//        }
//
//        // Store file
        if (dependencia!=null) {
//            
            Documento.executeUpdate("update Documento d set d.clasificacion=${dependencia as int} " +
                      "where d.id=${params.documentoiD as int}")}
//            file.transferTo(new File("${storagePath}/${name}"))
//            println "Saved file: ${storagePath}/${name}"
            flash.message = "¡Clasificación Almacenada!"
            redirect(action: "show", id: params.documentoiD as int)
//            //return "${storagePath}/${name}"// este es para que nos retorne la ruta donde se guardo
//
//        } else {
//            flash.error=("¡El archivo no se pudo guardar!")
//            
//            println "File ${file.inspect()} was empty!"
//            redirect(action: "show", id: params.documentoiD as int)
//        }
       
        
    }
    
    def buscarFolioAjax(){
        def Cadena = params.id as String   
       
        def listDocumentos = Documento.findAll("FROM Documento d WHERE d.folio like '%${Cadena}%'")  
       
        def resultadoFormateado = listDocumentos.collect {
            [
                id: it.id,                
                folio: it.folio     
            ]
        }        
        render resultadoFormateado as JSON  
        
    }
    
    def buscadorAjax () {
        
        def Cadena = params.id as String   
        
        def listRemitentes = Persona.findAll("FROM Persona p WHERE p.nombre like '%${Cadena}%'")  
       
        def resultadoFormateado = listRemitentes.collect {
            [
                id: it.id,                
                nombre: it.nombre            
            ]
        }        
        render resultadoFormateado as JSON        
          
    }
    
    def index() {
        redirect(action: "list", params: params)
    }
    /////////////////////////////////////////////////////////////////////
    def  listDocSinTurnar(){
       
        def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def user=UsuarioSistema.get(idUsuario as int)
        def rolee=user.authorities.id[0] as int//rol del usuario
//        println"el rol es: "+rolee
        
        if(rolee==1 || rolee==3){
            def  documentoInstance = Documento.findAll("From Documento d where d.folio like'%SEG%' order by d.fechaCaptura desc")
        
            def listaHolgura =[]
        
            GregorianCalendar fechaMayor = Calendar.getInstance()
            GregorianCalendar fechaMenor = Calendar.getInstance()
        
            def max = params?.max==null?10:params?.max as int
            def offset = params?.offset==null?0: params?.offset as int
            def fechaHoy = new Date()
        
        
        
            def mapa = [max:max, offset:offset]
            def query="From Documento d where d.folio like'%SEG%' order by d.fechaCaptura desc"
            // params.max = Math.min(max ?: 10, 100)
            def rango
     
            for(int i =0; i<documentoInstance.size();i++){
                def fecha=documentoInstance.fechaCaptura[i].format(("yyyy-MM-dd"))
                def splitFecha = fecha.split("-")
            
                def year=(splitFecha[0] as int)
                def mes=(splitFecha[1] as int)-1
                def dia=(splitFecha[2] as int)
           
           
                def yearFechaMenor
                def yearFechaMayor
            
                yearFechaMenor=fechaMenor.get(Calendar.YEAR)
                yearFechaMayor=fechaMayor.get(Calendar.YEAR)
            
                fechaMenor.set(year, mes, dia)
           
                if(yearFechaMenor == yearFechaMayor){
               
                    rango=(fechaMayor.get(Calendar.DAY_OF_YEAR))-(fechaMenor.get(Calendar.DAY_OF_YEAR))
                    listaHolgura.add(rango)
                
               
                }
          
            
            }
        
        
            [documentoInstanceList: Documento.findAll(query, mapa), documentoInstanceTotal: documentoInstance.size(), listaHolgura:listaHolgura]
            
            
        }
        if(rolee==6){
            def  documentoInstance = Documento.findAll("From Documento d where d.folio like'%DCCA%' AND d.status='Creado' order by d.fechaCaptura desc")
            def listaHolgura =[]
        
            GregorianCalendar fechaMayor = Calendar.getInstance()
            GregorianCalendar fechaMenor = Calendar.getInstance()
        
            def max = params?.max==null?10:params?.max as int
            def offset = params?.offset==null?0: params?.offset as int
            def fechaHoy = new Date()
        
        
        
            def mapa = [max:max, offset:offset]
            def query="From Documento d where d.folio like'%DCCA%' and d.status='Creado' order by d.fechaCaptura desc"
            // params.max = Math.min(max ?: 10, 100)
            def rango
     
            for(int i =0; i<documentoInstance.size();i++){
                def fecha=documentoInstance.fechaCaptura[i].format(("yyyy-MM-dd"))
                def splitFecha = fecha.split("-")
            
                def year=(splitFecha[0] as int)
                def mes=(splitFecha[1] as int)-1
                def dia=(splitFecha[2] as int)
           
           
                def yearFechaMenor
                def yearFechaMayor
            
                yearFechaMenor=fechaMenor.get(Calendar.YEAR)
                yearFechaMayor=fechaMayor.get(Calendar.YEAR)
            
                fechaMenor.set(year, mes, dia)
           
                if(yearFechaMenor == yearFechaMayor){
               
                    rango=(fechaMayor.get(Calendar.DAY_OF_YEAR))-(fechaMenor.get(Calendar.DAY_OF_YEAR))
                    listaHolgura.add(rango)
                
               
                }
          
            
            }
        
        
            [documentoInstanceList: Documento.findAll(query, mapa), documentoInstanceTotal: documentoInstance.size(), listaHolgura:listaHolgura]
            
            
        }
        }
    
    
    def list() {
        
        def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def user=UsuarioSistema.get(idUsuario as int)
        def rolee=user.authorities.id[0] as int//rol del usuario
//        println"el rol es: "+rolee
        
        if(rolee==5){
            def  documentoInstance = Documento.findAll("From Documento d where d.folio like'%SEG%' order by d.fechaCaptura desc")
        
            def listaHolgura =[]
        
            GregorianCalendar fechaMayor = Calendar.getInstance()
            GregorianCalendar fechaMenor = Calendar.getInstance()
        
            def max = params?.max==null?10:params?.max as int
            def offset = params?.offset==null?0: params?.offset as int
            def fechaHoy = new Date()
        
        
        
            def mapa = [max:max, offset:offset]
            def query="From Documento d where d.folio like'%SEG%' order by d.fechaCaptura desc"
            // params.max = Math.min(max ?: 10, 100)
            def rango
     
            for(int i =0; i<documentoInstance.size();i++){
                def fecha=documentoInstance.fechaCaptura[i].format(("yyyy-MM-dd"))
                def splitFecha = fecha.split("-")
            
                def year=(splitFecha[0] as int)
                def mes=(splitFecha[1] as int)-1
                def dia=(splitFecha[2] as int)
           
           
                def yearFechaMenor
                def yearFechaMayor
            
                yearFechaMenor=fechaMenor.get(Calendar.YEAR)
                yearFechaMayor=fechaMayor.get(Calendar.YEAR)
            
                fechaMenor.set(year, mes, dia)
           
                if(yearFechaMenor == yearFechaMayor){
               
                    rango=(fechaMayor.get(Calendar.DAY_OF_YEAR))-(fechaMenor.get(Calendar.DAY_OF_YEAR))
                    listaHolgura.add(rango)
                
               
                }
          
            
            }
        
        
            [documentoInstanceList: Documento.findAll(query, mapa), documentoInstanceTotal: documentoInstance.size(), listaHolgura:listaHolgura]
            
            
        }else if(rolee==3 || rolee==6){

            String fechaCap = "2015-12-01"
            def  documentoInstance = Documento.findAll("From Documento d where fechaCaptura > '${fechaCap}' and d.folio like'%DCCA%' order by d.fechaCaptura desc")
            
            def listaHolgura =[]
        
            GregorianCalendar fechaMayor = Calendar.getInstance()
            GregorianCalendar fechaMenor = Calendar.getInstance()
        
            def max = params?.max==null?10:params?.max as int
            def offset = params?.offset==null?0: params?.offset as int
            def fechaHoy = new Date()
        
        
        
            def mapa = [max:max, offset:offset]
            def query="From Documento d where fechaCaptura > '${fechaCap}' and d.folio like'%DCCA%' order by d.fechaCaptura desc"
            // params.max = Math.min(max ?: 10, 100)
            def rango
     
            for(int i =0; i<documentoInstance.size();i++){
                def fecha=documentoInstance.fechaCaptura[i].format(("yyyy-MM-dd"))
                def splitFecha = fecha.split("-")
            
                def year=(splitFecha[0] as int)
                def mes=(splitFecha[1] as int)-1
                def dia=(splitFecha[2] as int)
           
           
                def yearFechaMenor
                def yearFechaMayor
            
                yearFechaMenor=fechaMenor.get(Calendar.YEAR)
                yearFechaMayor=fechaMayor.get(Calendar.YEAR)
            
                fechaMenor.set(year, mes, dia)
           
                if(yearFechaMenor == yearFechaMayor){
               
                    rango=(fechaMayor.get(Calendar.DAY_OF_YEAR))-(fechaMenor.get(Calendar.DAY_OF_YEAR))
                    listaHolgura.add(rango)
                
               
                }
          
            
            }
        
        
            [documentoInstanceList: Documento.findAll(query, mapa), documentoInstanceTotal: documentoInstance.size(), listaHolgura:listaHolgura]
            
            
        }else if(rolee==4){
            def  documentoInstance = Documento.findAll("From Documento d where d.folio like'%GIRAS%' order by d.fechaCaptura desc")
        
            def listaHolgura =[]
        
            GregorianCalendar fechaMayor = Calendar.getInstance()
            GregorianCalendar fechaMenor = Calendar.getInstance()
        
            def max = params?.max==null?10:params?.max as int
            def offset = params?.offset==null?0: params?.offset as int
            def fechaHoy = new Date()
        
        
        
            def mapa = [max:max, offset:offset]
            def query="From Documento d where d.folio like'%GIRAS%' order by d.fechaCaptura desc"
            // params.max = Math.min(max ?: 10, 100)
            def rango
     
            for(int i =0; i<documentoInstance.size();i++){
                def fecha=documentoInstance.fechaCaptura[i].format(("yyyy-MM-dd"))
                def splitFecha = fecha.split("-")
            
                def year=(splitFecha[0] as int)
                def mes=(splitFecha[1] as int)-1
                def dia=(splitFecha[2] as int)
           
           
                def yearFechaMenor
                def yearFechaMayor
            
                yearFechaMenor=fechaMenor.get(Calendar.YEAR)
                yearFechaMayor=fechaMayor.get(Calendar.YEAR)
            
                fechaMenor.set(year, mes, dia)
           
                if(yearFechaMenor == yearFechaMayor){
               
                    rango=(fechaMayor.get(Calendar.DAY_OF_YEAR))-(fechaMenor.get(Calendar.DAY_OF_YEAR))
                    listaHolgura.add(rango)
                
               
                }
          
            
            }
        
        
            [documentoInstanceList: Documento.findAll(query, mapa), documentoInstanceTotal: documentoInstance.size(), listaHolgura:listaHolgura]
            
            
        }else if(rolee==1){
            def  documentoInstance = Documento.findAll("From Documento d order by d.fechaCaptura desc")
        
            def listaHolgura =[]
        
            GregorianCalendar fechaMayor = Calendar.getInstance()
            GregorianCalendar fechaMenor = Calendar.getInstance()
        
            def max = params?.max==null?10:params?.max as int
            def offset = params?.offset==null?0: params?.offset as int
            def fechaHoy = new Date()
        
        
        
            def mapa = [max:max, offset:offset]
            def query="From Documento d order by d.fechaCaptura desc"
            // params.max = Math.min(max ?: 10, 100)
            def rango
     
            for(int i =0; i<documentoInstance.size();i++){
                def fecha=documentoInstance.fechaCaptura[i].format(("yyyy-MM-dd"))
                def splitFecha = fecha.split("-")
            
                def year=(splitFecha[0] as int)
                def mes=(splitFecha[1] as int)-1
                def dia=(splitFecha[2] as int)
           
           
                def yearFechaMenor
                def yearFechaMayor
            
                yearFechaMenor=fechaMenor.get(Calendar.YEAR)
                yearFechaMayor=fechaMayor.get(Calendar.YEAR)
            
                fechaMenor.set(year, mes, dia)
           
                if(yearFechaMenor == yearFechaMayor){
               
                    rango=(fechaMayor.get(Calendar.DAY_OF_YEAR))-(fechaMenor.get(Calendar.DAY_OF_YEAR))
                    listaHolgura.add(rango)
                
               
                }
          
            
            }
        
        
            [documentoInstanceList: Documento.findAll(query, mapa), documentoInstanceTotal: documentoInstance.size(), listaHolgura:listaHolgura]
            
            
        }
        
        
        
        
        
        
    }

    

    def buscarDocPorFolio(){
        
        
    }
    
    def buscarDocDep(){
        
       [documentoInstanceTotal: 10]
    }
    
    
    def buscarDocPorStatus(){
        def fechaInicio = new Date()
        def fechaFin = new Date()  
        
               
        fechaInicio = fechaInicio.format("yyyy-MM-dd"+' 00:00:00')
        fechaFin = fechaFin.format("yyyy-MM-dd"+' 23:59:59')
        
        def max = params?.max==null?10:params?.max as int
        def offset = params?.offset==null?0: params?.offset as int  
        def mapa = [max:max, offset:offset]         
        
        def query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}'"                        
        def total=10
             
       
        //params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
        [documentoInstanceList: Documento.findAll(query, mapa), documentoInstanceTotal: total, fechaInicio:params.fechaInicio,fechaFin:params.fechaFin]
        
        
    }
    
    def consultaDocPorStatus(){
        
        def fechaInicio = new Date()
        def fechaFin = new Date()  
        
        fechaInicio = params.fechaInicio
        fechaFin = params.fechaFin        
        fechaInicio = fechaInicio.format("yyyy-MM-dd"+' 00:00:00')
        fechaFin = fechaFin.format("yyyy-MM-dd"+' 23:59:59')
        
        def status = params?.status as String
         
        
        def max = params?.max==null?80:params?.max as int
        def offset = params?.offset==null?0: params?.offset as int
        def mapa = [max:max, offset:offset]             
        
        
        
        def statusInt
        if(status.equals("Creado")){
            statusInt=0 as int
        }else if(status.equals("Turnado")){
            statusInt=1 as int
        }else if(status.equals("Con Seguimiento")){
            statusInt=2 as int
        }else if(status.equals("Terminado")){
            statusInt=3 as int
        }
        
        def query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}' and d.status=${statusInt}"                        
        def total=10
        def docInsta = Documento.findAll(query)
        // params.max = Math.min(max ?: 10, 100)
   
        
        render(view: "buscarDocPorStatus", model: [documentoInstanceList: Documento.findAll(query, mapa), documentoInstanceTotal: docInsta.size(), fechaInicio:params.fechaInicio,fechaFin:params.fechaFin, status:status] )
        return 
    }
    def buscarDocPorRemitente(){
//        def fechaInicio = new Date()
//        def fechaFin = new Date()  
//        
//               
//        fechaInicio = fechaInicio.format("yyyy-MM-dd"+' 00:00:00')
//        fechaFin = fechaFin.format("yyyy-MM-dd"+' 23:59:59')
//        
//        
//        
//       /* params.max = Math.min(params.max ? params.int('max') : 10, 100)
//    def ls = Book.executeQuery("from Book a",[max: params.max, offset: params.offset])
//    def totalCount = Book.executeQuery("from Book a").size()
//    [bookInstanceList: ls, bookInstanceTotal: totalCount]*/
//        
//        
//        
//        
//        
//        
//        def max = params?.max==null?10:params?.max as int
//            def offset = params?.offset==null?0: params?.offset as int
//         
//        
//        def mapa = [max:max, offset:offset]                
//        def query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}'"                        
//        
//        def total //= Documento
//        total=Documento.executeQuery("Select count(*) From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}'")
//        //def totalcount=total.count()    
//        
//        //params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
        [documentoInstanceTotal: 10]
        
        
        
    }
    
    def consultaDocPorRemitente(){
        
        if(params?.personaa){
            params.persona.id=params?.personaa
            
        }
        
        
        if(!params["persona"] && params.personaa==null){
            flash.error = "Por favor, Escriba el nombre del remitente y elija en la lista para poder obtener los resultados deseados"
            redirect(action: "buscarDocPorRemitente")
            return
        }
        
        def fechaInicio = new Date()
        def fechaFin = new Date()  
        
        fechaInicio = params.fechaInicio
        fechaFin = params.fechaFin        
        fechaInicio = fechaInicio.format("yyyy-MM-dd"+' 00:00:00')
        fechaFin = fechaFin.format("yyyy-MM-dd"+' 23:59:59')
        def idRemitente
        if(params.personaa){
            
            idRemitente = params.personaa as int
        }else{
        
        idRemitente = params.persona.id as int
        }//fin else
        def personaInstance=Persona.get(idRemitente)
        def nombreRemitente=personaInstance.nombre
        
        def max = params?.max==null?10:params?.max as int
        def offset = params?.offset==null?0: params?.offset as int
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def mapa = [max:max, offset:offset]   
        
        def query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}' and d.persona=${idRemitente}"                        
        def total=10
        
        def totalDoc = Documento
        //totalDoc = totalDoc.findAll("Select count(d.id) From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}' and d.persona=${idRemitente}")
        def queryTotal="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}' and d.persona=${idRemitente}"
//def totalcount = totalDoc.count()
        // params.max = Math.min(max ?: 10, 100)
        
        render(view: "buscarDocPorRemitente", model: [documentoInstanceList: Documento.findAll(query, mapa), documentoInstanceTotal: (totalDoc.findAll(queryTotal)).size() as int, fechaInicio:params.fechaInicio,fechaFin:params.fechaFin, nombreRemitente:nombreRemitente, person:params?.persona.id] )
        return 
        
    }
    
    def buscarDocPorAsunto(){
        def fechaInicio = new Date()
        def fechaFin = new Date()  
        
               
        fechaInicio = fechaInicio.format("yyyy-MM-dd"+' 00:00:00')
        fechaFin = fechaFin.format("yyyy-MM-dd"+' 23:59:59')
        
        def max = params?.max==null?10:params?.max as int
        def offset = params?.offset==null?0: params?.offset as int  
        def mapa = [max:max, offset:offset]                
        def query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}'"                        
        def total=10
             
        params.max = Math.min(max ?: 10, 100)
        //params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
        [documentoInstanceList: Documento.findAll(query, mapa), documentoInstanceTotal: total, fechaInicio:params.fechaInicio,fechaFin:params.fechaFin]
        
    }
    
    
    def consultaDocPorAsunto(){
        
        if(!params.cadena){
            flash.error = "Por favor, Escriba una palabra para buscar en los asuntos de los documentos..."
            redirect(action: "buscarDocPorAsunto")
            return
        }
        
        def fechaInicio = new Date()
        def fechaFin = new Date()  
        
        fechaInicio = params.fechaInicio
        fechaFin = params.fechaFin        
        fechaInicio = fechaInicio.format("yyyy-MM-dd"+' 00:00:00')
        fechaFin = fechaFin.format("yyyy-MM-dd"+' 23:59:59')
        
        def cadena = params.cadena as String
        def max = params?.max==null?80:params?.max as int
        def offset = params?.offset==null?0: params?.offset as int
        def mapa = [max:max, offset:offset]                
        def query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}' and d.asunto like '%${cadena}%'"                        
        def total=10
                      
        // params.max = Math.min(max ?: 10, 100)
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
        render(view: "buscarDocPorAsunto", model: [documentoInstanceList: Documento.findAll(query, mapa), documentoInstanceTotal: 10, fechaInicio:params.fechaInicio,fechaFin:params.fechaFin, cadena:cadena] )
        return 
        
    }
    
    

    
    def showDocTurnado(Long id){
        def documentoInstance = Documento.get(id)
        if (!documentoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }

        def idDoc = id as int
        
        def turnadoInstance = Turnado.findAll("From Turnado t where t.documento=${idDoc}")
        def seguimientoInstance = Seguimiento.findAll("From Seguimiento s where s.documento=${idDoc} order by s.fechaCaptura desc")
        
        [documentoInstance: documentoInstance, turnadoInstance:turnadoInstance, seguimientoInstance:seguimientoInstance]
    }
    
    def show(Long id) {
        def documentoInstance = Documento.get(id)
//        println "documento: " + documentoInstance.folio
        if (!documentoInstance) {
            
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }        
        def idDoc = id as int
        
        def turnadoInstance = Turnado.findAll("From Turnado t where t.documento=${idDoc}")
        def seguimientoInstance = Seguimiento.findAll("From Seguimiento s where s.documento=${idDoc} order by s.fechaCaptura desc")
       
        [documentoInstance: documentoInstance, turnadoInstance:turnadoInstance, seguimientoInstance:seguimientoInstance]
        
    }

    def edit(Long id) {
		def documentoInstance = Documento.get(id)
        if (!documentoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")    
            return
        }
        def indicacionInstance = Indicacion.findAll("From Indicacion")
        [documentoInstance: documentoInstance, indicacionInstance:indicacionInstance]
    }
    
    def editGiras(Long id) {
        def documentoInstance = Documento.get(id)
        if (!documentoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")    
            return
        }
        def indicacionInstance = Indicacion.findAll("From Indicacion")
        [documentoInstance: documentoInstance, indicacionInstance:indicacionInstance]
    }

    def update(Long id, Long version) {
        
        def documentoInstance = Documento.get(id)     
        
        if (!documentoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (documentoInstance.version > version) {
                documentoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'documento.label', default: 'Documento')] as Object[],
                          "Another user has updated this Documento while you were editing")
                render(view: "edit", model: [documentoInstance: documentoInstance])
                return
            }
        }
        
        documentoInstance.signatario = params.signatario
        documentoInstance.presente=params.presente
        documentoInstance.asunto=params.asunto
        documentoInstance.tipoDocumento=TipoDocumento.get(params.tipoDocumento.id as int)
        documentoInstance.indicacion=Indicacion.get(params.indicacion.id as int)
		documentoInstance.observacion=params.observacion
        documentoInstance.indicacionTexto=params.indicacionTexto
        //documentoInstance.numOficio=params.numOficio
        documentoInstance.municipio=Municipio.get(params.municipio.id as int)
        documentoInstance.prioridad=params.prioridad
        documentoInstance.evento=params.evento
        documentoInstance.fechaRecibido=params.fechaRecibido
        documentoInstance.turnadoInterno=params.turnadoInterno.toString()
        documentoInstance.dirigido = params.dirigido
        
        
        if(!params["persona"] && !params["dependenciaRemitente"]){
           
//            println"se queda como esta..."
            
            if (!documentoInstance.save(flush: true)) {
                render(view: "edit", model: [documentoInstance: documentoInstance])
                return
            }

            flash.message = message(code: 'default.updated.message', args: [message(code: 'documento.label', default: 'Documento'), documentoInstance.id])
            redirect(action: "show", id: documentoInstance.id)
            
        
        }//fin if !params
        if(params["persona"] && !params["dependenciaRemitente"]){
      
//            println"se agrega persona y se quita dependencia"
                
               
            documentoInstance.dependenciaRemitente=null//null a depRemitente
            documentoInstance.persona=Persona.get(params.persona.id as int)
            if (!documentoInstance.save(flush: true)) {
                render(view: "edit", model: [documentoInstance: documentoInstance])
                return
            }
                
            flash.message = ("El documento se ha modificado correctamente...")
            redirect(action: "show", id: documentoInstance.id)
        }//fin if params
        if(!params["persona"] && params["dependenciaRemitente"]){
           
//            println"se quita persona y se agrega dependencia..."
                
            documentoInstance.persona=null
            documentoInstance.dependenciaRemitente=Dependencia.get(params.dependenciaRemitente.id as int)
            if (!documentoInstance.save(flush: true)) {
                render(view: "edit", model: [documentoInstance: documentoInstance])
                return
            }
                
            flash.message = ("El documento se ha modificado correctamente...")
            redirect(action: "show", id: documentoInstance.id)
        }
        if(params["persona"] && params["dependenciaRemitente"]){
           
//            println"No debio de guardar ni maiz..."
                
                
            flash.error = ("Porfavor elija solo un remitente...")
            redirect(action: "show", id: documentoInstance.id)
        }
        
        
    }
    
    def updateDocumentoCreado(Long id, Long version) {
        
        def documentoInstance = Documento.get(id)
        
        
        
        if (!documentoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (documentoInstance.version > version) {
                documentoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'documento.label', default: 'Documento')] as Object[],
                          "Another user has updated this Documento while you were editing")
                render(view: "editDocumentoCreado", model: [documentoInstance: documentoInstance])
                return
            }
        }

        documentoInstance.signatario = params.signatario
        documentoInstance.asunto=params.asunto
		documentoInstance.observacion=params.observacion
        documentoInstance.tipoDocumento=TipoDocumento.get(params.tipoDocumento.id as int)
        //documentoInstance.municipio=Municipio.get(params.municipio.id as int)
        
        if(!params["persona"] && !params["dependenciaRemitente"]){
           
//            println"se queda como esta..."
            if (!documentoInstance.save(flush: true)) {
                render(view: "editDocumentoCreado", model: [documentoInstance: documentoInstance])
                return
            }

            flash.message = message(code: 'default.updated.message', args: [message(code: 'documento.label', default: 'Documento'), documentoInstance.id])
            redirect(action: "showDocumentoCreado", id: documentoInstance.id)
            
        
        }//fin if !params
        if(params["persona"] && !params["dependenciaRemitente"]){
      
//            println"se agrega persona y se quita dependencia"
                
               
            documentoInstance.dependenciaRemitente=null//null a depRemitente
            documentoInstance.persona=Persona.get(params.persona.id as int)
            if (!documentoInstance.save(flush: true)) {
                render(view: "editDocumentoCreado", model: [documentoInstance: documentoInstance])
                return
            }
                
            flash.message = ("El documento se ha modificado correctamente...")
            redirect(action: "showDocumentoCreado", id: documentoInstance.id)
        }//fin if params
        if(!params["persona"] && params["dependenciaRemitente"]){
           
//            println"se quita persona y se agrega dependencia..."
                
            documentoInstance.persona=null
            documentoInstance.dependenciaRemitente=Dependencia.get(params.dependenciaRemitente.id as int)
            if (!documentoInstance.save(flush: true)) {
                render(view: "editDocumentoCreado", model: [documentoInstance: documentoInstance])
                return
            }
                
            flash.message = ("El documento se ha modificado correctamente...")
            redirect(action: "showDocumentoCreado", id: documentoInstance.id)
        }
        if(params["persona"] && params["dependenciaRemitente"]){
           
//            println"No debio de guardar ni maiz..."
                
                
            flash.error = ("Porfavor elija solo un remitente...")
            redirect(action: "showDocumentoCreado", id: documentoInstance.id)
        }
        
        
    }

    def delete(Long id) {
        def documentoInstance = Documento.get(id)
        if (!documentoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }

        try {
            documentoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "show", id: id)
        }
    }
     def buscadorAjaxIndicaciones () {
        
        	def Cadena = params.id as int   
        	if(Cadena!=null){
            		
        		def listIndicaciones = Indicacion.findAll("FROM Indicacion i WHERE i.id = ${Cadena}")  
       
      			def resultadoFormateado = listIndicaciones.collect {
            		[
                		indicacion: it.indicacion            
            		]
       		 	} 	       
       		 	render resultadoFormateado as JSON       
    		}else{
        		def listIndicaciones
       			def resultadoFormateado = listIndicaciones.collect {
            		[
                		indicacion: it.indicacion="No se seleccionó ningún elemento"            
            		]
        	}   
        	render resultadoFormateado as JSON      
    		} 
          
    }
    //Long id, Long version
    def documentTerminado(Long id){
        // solo se actualiza el estatus en la base de datos
    
        // status 0 -----> creado  
        // status 1 -----> turnado
        // status 2 -----> con seguimiento
        // status 3 -----> Terminado
        
     
         def documentoInstance = Documento.get(id)
        if( documentoInstance.status==2 ){
            
               Documento.executeUpdate("update Documento d set d.status=3 " +
                     "where d.id=${id as int}")
                     redirect(action: "list")
         }
        else{
                   redirect(action: "list")
             }
}
def buscarGeneral(){
        def fechaInicio = new Date()
        def fechaFin = new Date()  
        
               
        fechaInicio = fechaInicio.format("yyyy-MM-dd"+' 00:00:00')
        fechaFin = fechaFin.format("yyyy-MM-dd"+' 23:59:59')
        
        def max = params?.max==null?10:params?.max as int
        def offset = params?.offset==null?0: params?.offset as int  
        def mapa = [max:max, offset:offset]         
        
        def query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}'"                        
        def total=10
             
       
        //params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
        [documentoInstanceList: null, documentoInstanceTotal: 0, fechaInicio:params.fechaInicio,fechaFin:params.fechaFin]
        
        
    }
    
     
    def buscarGeneralGiras(){
        def fechaInicio = new Date()
        def fechaFin = new Date()  
        
               
        fechaInicio = fechaInicio.format("yyyy-MM-dd"+' 00:00:00')
        fechaFin = fechaFin.format("yyyy-MM-dd"+' 23:59:59')
        
        def max = params?.max==null?10:params?.max as int
        def offset = params?.offset==null?0: params?.offset as int  
        def mapa = [max:max, offset:offset]         
        
        def query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}'"                        
        def total=10
             
       
        //params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
        [documentoInstanceList: null, documentoInstanceTotal: 0, fechaInicio:params.fechaInicio,fechaFin:params.fechaFin]
        
        
    }
    
    def consultaGeneral(){
         
        def max = params?.max==null?10:params?.max as int
        def offset = params?.offset==null?0: params?.offset as int  
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def mapa = [max:max, offset:offset]       
        def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def user=UsuarioSistema.get(idUsuario as int)
        def rolee=user.authorities.id[0] as int//rol del usuario
       
         def fecha1
         def fecha2
        
        if(params.paginacion.equals("si")){
            fecha1 = params.fechaInicio.split('-')
            fecha2 = params.fechaFin.split('-')
        }else{
            fecha1 = params.fechaInicio.format("yyyy-MM-dd").split('-')
            fecha2 = params.fechaFin.format("yyyy-MM-dd").split('-')
        }
        
        fecha1[1] = (fecha1[1] as int) - 1 
        fecha2[1] = (fecha2[1] as int) - 1         
        
        def g = new GregorianCalendar(fecha1[0] as int, fecha1[1]  as int, fecha1[2] as int)
        //g.setTime((Date) formatter.parse(params.fechaInicio.format("yyyy-MM-dd") as String))
        def g2 = new GregorianCalendar(fecha2[0] as int, fecha2[1]  as int, fecha2[2] as int)
        //g2.setTime((Date) formatter.parse(params.fechaFin.format("yyyy-MM-dd") as String))
                
        def fechaInicio = g.format("yyyy-MM-dd"+' 00:00:00')
        def fechaFin = g2.format("yyyy-MM-dd"+' 23:59:59')        
        
       def query     
       
       
       def folio
       def remitente
       def idTipoDocumento = params.tipoDocumento.id as int
       def asunto
       def turnadoInterno 
       
       if (params.folio  == ""){  folio = "" } else{  folio = " and d.folio like '%${params.folio}%' "  }
       if (params.remitente  == ""){  remitente = "" } else{  remitente = " and d.persona in (select p.id from Persona p where p.nombre like '%${params.remitente}%')  " }
       if (idTipoDocumento == 0){ idTipoDocumento = "" }else{ idTipoDocumento = " and d.tipoDocumento = '${idTipoDocumento}' " }
       if (params.asunto  == ""){  asunto = "" } else{ asunto = " and d.asunto like '%${params.asunto}%' "  }
       if (params.turnadoInterno  == ""){ turnadoInterno  = "" } else{ turnadoInterno = " and d.turnadoInterno like '%${params.turnadoInterno}%'"}

 
        if(rolee==4){
            
            query="From Documento d where d.fechaRecibido  >=  '${fechaInicio}' AND d.fechaRecibido <= '${fechaFin}' ${folio} ${remitente} ${idTipoDocumento} ${asunto} AND d.folio like'%GIRAS%' order by fechaRecibido asc"    
        //    query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}' and d.folio like '%${params.folio}%' and d.numOficio like '%${params.numOficio}%' and d.persona in (select p.id from Persona p where p.nombre like '%${params.remitente}%')  and d.tipoDocumento in (select t.id from TipoDocumento t where t.tipoDocumento like '%${params.tipoDocumento}%' )  order by fechaRecibido asc"    
        }
        if(rolee==3){
            
            query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}' ${folio} ${remitente} ${idTipoDocumento} ${asunto} ${turnadoInterno} AND d.folio like'%DCCA%' order by fechaRecibido asc"    
        //    query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}' and d.folio like '%${params.folio}%' and d.numOficio like '%${params.numOficio}%' and d.persona in (select p.id from Persona p where p.nombre like '%${params.remitente}%')  and d.tipoDocumento in (select t.id from TipoDocumento t where t.tipoDocumento like '%${params.tipoDocumento}%' )  order by fechaRecibido asc"    
        }
        if(rolee==1){
            
            query="From Documento d where d.fechaRecibido  >=  '${fechaInicio}' AND d.fechaRecibido <= '${fechaFin}' ${folio} ${remitente} ${idTipoDocumento} ${asunto} ${turnadoInterno} order by fechaRecibido asc"    

        }
        
        //println "params "+params
        //println "query "+query         
        def docInsta = Documento.executeQuery("select count(d.id)  "+query)    
        def totaldocInsta = docInsta[0] as Long
        
       params.fechaInicio2 = g.format("yyyy-MM-dd")
       params.fechaInicio = g.time
       params.fechaFin2 = g2.format("yyyy-MM-dd")
       params.fechaFin=g2.time
        
       render(view: "buscarGeneral", model: [documentoInstanceList: Documento.findAll(query, mapa), documentoInstanceTotal: totaldocInsta, params:params] )
       return 
     }
     
    def consultaGeneralGiras(){
         
        def max = params?.max==null?10:params?.max as int
        def offset = params?.offset==null?0: params?.offset as int  
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def mapa = [max:max, offset:offset]       
        def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def user=UsuarioSistema.get(idUsuario as int)
        def rolee=user.authorities.id[0] as int//rol del usuario
         def fecha1
         def fecha2
        
        if(params.paginacion.equals("si")){
            fecha1 = params.fechaInicio.split('-')
            fecha2 = params.fechaFin.split('-')
        }else{
            fecha1 = params.fechaInicio.format("yyyy-MM-dd").split('-')
            fecha2 = params.fechaFin.format("yyyy-MM-dd").split('-')
        }
        
        fecha1[1] = (fecha1[1] as int) - 1 
        fecha2[1] = (fecha2[1] as int) - 1         
        
        def g = new GregorianCalendar(fecha1[0] as int, fecha1[1]  as int, fecha1[2] as int)
        //g.setTime((Date) formatter.parse(params.fechaInicio.format("yyyy-MM-dd") as String))
        def g2 = new GregorianCalendar(fecha2[0] as int, fecha2[1]  as int, fecha2[2] as int)
        //g2.setTime((Date) formatter.parse(params.fechaFin.format("yyyy-MM-dd") as String))
                
        def fechaInicio = g.format("yyyy-MM-dd"+' 00:00:00')
        def fechaFin = g2.format("yyyy-MM-dd"+' 23:59:59')        
        
        def query     
        
       def folio
       def remitente
       def asunto
             
       if (params.folio  == ""){  folio = "" } else{  folio = " and d.folio like '%${params.folio}%' "  }
       if (params.remitente  == ""){  remitente = "" } else{  remitente = " and d.persona in (select p.id from Persona p where p.nombre like '%${params.remitente}%')  " }
       if (params.asunto  == ""){  asunto = "" } else{ asunto = " and d.asunto like '%${params.asunto}%' "  }
              
       query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}' ${folio} ${remitente} ${asunto}  AND d.folio like'%DCCA%' AND tipo_documento_id=8 order by folio asc"    

        
        
        //println "params "+params
        //println "query "+query         
        def docInsta = Documento.executeQuery("select count(d.id)  "+query)    
        def totaldocInsta = docInsta[0] as Long
        
       params.fechaInicio2 = g.format("yyyy-MM-dd")
       params.fechaInicio = g.time
       params.fechaFin2 = g2.format("yyyy-MM-dd")
       params.fechaFin=g2.time
        
       render(view: "buscarGeneralGiras", model: [documentoInstanceList: Documento.findAll(query, mapa), documentoInstanceTotal: totaldocInsta, params:params] )
       return 
     }
     
    def generarexcelconsultaGiras() {
         
         def realPath = servletContext.getRealPath("reports")
       
         def fecha1
         def fecha2
         def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
         def user=UsuarioSistema.get(idUsuario as int)
         def rolee=user.authorities.id[0] as int//rol del usuario
         
        if(params.paginacion.equals("si")){
            fecha1 = params.fechaInicio.split('-')
            fecha2 = params.fechaFin.split('-')
        }else{
            fecha1 = params.fechaInicio.format("yyyy-MM-dd").split('-')
            fecha2 = params.fechaFin.format("yyyy-MM-dd").split('-')
        }
        
        fecha1[1] = (fecha1[1] as int) - 1 
        fecha2[1] = (fecha2[1] as int) - 1         
        
        def g = new GregorianCalendar(fecha1[0] as int, fecha1[1]  as int, fecha1[2] as int)
        //g.setTime((Date) formatter.parse(params.fechaInicio.format("yyyy-MM-dd") as String))
        def g2 = new GregorianCalendar(fecha2[0] as int, fecha2[1]  as int, fecha2[2] as int)
        //g2.setTime((Date) formatter.parse(params.fechaFin.format("yyyy-MM-dd") as String))
                
        def fechaInicio = g.format("yyyy-MM-dd"+' 00:00:00')
        def fechaFin = g2.format("yyyy-MM-dd"+' 23:59:59')       
        
        def query
        
       def folio
       def remitente
       def asunto
      
       
       if (params.folio  == ""){  folio = "" } else{  folio = " and d.folio like '%${params.folio}%' "  }
       if (params.remitente  == ""){  remitente = "" } else{  remitente = " and d.persona in (select p.id from Persona p where p.nombre like '%${params.remitente}%')  " }
       if (params.asunto  == ""){  asunto = "" } else{ asunto = " and d.asunto like '%${params.asunto}%' "  }

       query="From Documento d where d.fechaRecibido  >=  '${fechaInicio}' AND d.fechaRecibido <= '${fechaFin}' ${folio} ${remitente} ${asunto} AND tipo_documento_id=8 AND turnadoInterno='Graciela Meyer' order by folio asc"    
                
        def listDocs = Documento.findAll(query)
        def listaSeguimientos = []  
        def seguimientos
        def listaTurnados = []
        def turnados
        def headers = ['Fecha','Remitente', 'Municipio', 'Asunto']
        def count = 0
        def reporter = new WebXlsxExporter("$realPath/reporteGiras.xlsx")
        reporter.with {
            
            setResponseHeaders(response)
           
            fillHeader(headers)
            
            listDocs.each() {    
                
                listaSeguimientos = Seguimiento.findAllByDocumento(Documento.get(it.id),[sort:"fechaCaptura",order:"asc"])
                
                seguimientos = ""
                listaSeguimientos.each() {
                    seguimientos = seguimientos +" "+ it.fechaCaptura.format("dd-MM-yyyy") +" "+ it.seguimiento
                }
              
                listaTurnados = Turnado.findAllByDocumento(Documento.get(it.id))           
                
              //println "observacion: "+it.observacion
           
              def fechaTemp
              def statusTemp
              def lugar
              def anyRemitente, direccionRemitente, telRemitente
             
           //   if(it.fechaVencimiento == null || it.fechaVencimiento.equals("")){
              //println "fecha Vencimiento nula "
             // fechaTemp = ""
              //}else{
              //println "Vencimiento "+it.fechaVencimiento.format("dd-MM-yyyy")    
              //fechaTemp = it.fechaVencimiento.format("dd-MM-yyyy")
              //}
               
                if(it.status == 0) statusTemp = "Creado"
                if(it.status == 1) statusTemp = "Turnado"
                if(it.status == 2) statusTemp = "Seguimiento"
                if(it.status == 3) statusTemp = "Concluido"
                if(it.persona==null){ 
//                    println "dependencia: "+ it.dependenciaRemitente
//                    println "direccion: "+ it.dependenciaRemitente.calleNumero+ " "+it.dependenciaRemitente.colonia
//                    telRemitente = ""
//                  println "municipio: " + it.dependenciaRemitente.municipio.toString()
                    anyRemitente = it.dependenciaRemitente
                    direccionRemitente = it.dependenciaRemitente.calleNumero+ " "+it.dependenciaRemitente.colonia
                    telRemitente = ""
                    lugar = it.dependenciaRemitente.municipio.toString()
                }
                if(it.persona!=null){ 
                    anyRemitente = it.persona.nombre
                    direccionRemitente = it.persona.calleNumero+" "+it.persona.colonia
                    telRemitente = it.persona.tel
                    if(it.persona.municipio.toString()=="null"){
                        lugar = it.persona.estado.toString()
                     }
                    else{
                         lugar = it.persona.municipio.toString()
                    }
                }
                
                count = count + 1                
                fillRow([it.fechaCaptura.format("dd-MM-yyyy"), anyRemitente.toString(), lugar,  it.asunto], count)
            }
    
            save(response.outputStream)
        }
        
    }
    
    def generarexcelconsulta() {
         
         def realPath = servletContext.getRealPath("reports")
   
         def fecha1
         def fecha2
         def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
         def user=UsuarioSistema.get(idUsuario as int)
         def rolee=user.authorities.id[0] as int//rol del usuario
         
        if(params.paginacion.equals("si")){
            fecha1 = params.fechaInicio.split('-')
            fecha2 = params.fechaFin.split('-')
        }else{
            fecha1 = params.fechaInicio.format("yyyy-MM-dd").split('-')
            fecha2 = params.fechaFin.format("yyyy-MM-dd").split('-')
        }
        
        fecha1[1] = (fecha1[1] as int) - 1 
        fecha2[1] = (fecha2[1] as int) - 1         
        
        def g = new GregorianCalendar(fecha1[0] as int, fecha1[1]  as int, fecha1[2] as int)
        //g.setTime((Date) formatter.parse(params.fechaInicio.format("yyyy-MM-dd") as String))
        def g2 = new GregorianCalendar(fecha2[0] as int, fecha2[1]  as int, fecha2[2] as int)
        //g2.setTime((Date) formatter.parse(params.fechaFin.format("yyyy-MM-dd") as String))
                
        def fechaInicio = g.format("yyyy-MM-dd"+' 00:00:00')
        def fechaFin = g2.format("yyyy-MM-dd"+' 23:59:59')       
        
       
        def query
    
       def folio 
       def remitente
       def idTipoDocumento = params.tipoDocumento.id as int
       def asunto
             
       if (params.folio  == ""){  folio = "" } else{  folio = " and d.folio like '%${params.folio}%' "  }
       if (params.remitente  == ""){  remitente = "" } else{  remitente = " and d.persona in (select p.id from Persona p where p.nombre like '%${params.remitente}%')  " }
       if (idTipoDocumento == 0){ idTipoDocumento = "" }else{ idTipoDocumento = " and d.tipoDocumento = '${idTipoDocumento}' " }
       if (params.asunto  == ""){  asunto = "" } else{ asunto = " and d.asunto like '%${params.asunto}%' "  }

        if(rolee==4){
            query="From Documento d where d.fechaRecibido  >=  '${fechaInicio}' AND d.fechaRecibido <= '${fechaFin}' ${folio} ${remitente} ${idTipoDocumento} ${asunto} AND d.folio like'%GIRAS%' order by fechaRecibido asc"    
        //    query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}' and d.folio like '%${params.folio}%' and d.numOficio like '%${params.numOficio}%' and d.persona in (select p.id from Persona p where p.nombre like '%${params.remitente}%')  and d.tipoDocumento in (select t.id from TipoDocumento t where t.tipoDocumento like '%${params.tipoDocumento}%' )  order by fechaRecibido asc"    
        
        }
        if(rolee==3){
            query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}' ${folio} ${remitente} ${idTipoDocumento} ${asunto} AND d.folio like'%DCCA%' order by fechaRecibido asc"    
        //    query="From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}' and d.folio like '%${params.folio}%' and d.numOficio like '%${params.numOficio}%' and d.persona in (select p.id from Persona p where p.nombre like '%${params.remitente}%')  and d.tipoDocumento in (select t.id from TipoDocumento t where t.tipoDocumento like '%${params.tipoDocumento}%' )  order by fechaRecibido asc"    
        }
        if(rolee==1){
            query="From Documento d where d.fechaRecibido  >=  '${fechaInicio}' AND d.fechaRecibido <= '${fechaFin}' ${folio} ${remitente} ${idTipoDocumento} ${asunto} order by fechaRecibido asc"    

        }
                
        def listDocs = Documento.findAll(query)
        def listaSeguimientos = []  
        def seguimientos
        def listaTurnados = []
        def turnados
        def headers = ['Fecha Recibido', 'Nombre', 'Dirección', 'Teléfono', 'Municipio', 'Lugar de gira', 'Localidad', 'Evento', 'Petición','Turnado', 'Folio','Estatus', 'Seguimiento','Observaciones','Turnado Interno']
        def count = 0
        def reporter = new WebXlsxExporter("$realPath/report.xlsx")
        reporter.with {
            
            setResponseHeaders(response)
           
            fillHeader(headers)
            
            listDocs.each() {    
                
                listaSeguimientos = Seguimiento.findAllByDocumento(Documento.get(it.id),[sort:"fechaCaptura",order:"asc"])
                
                seguimientos = ""
                listaSeguimientos.each() {
                    seguimientos = seguimientos +" "+ it.fechaCaptura.format("dd-MM-yyyy") +" "+ it.seguimiento
                }
              
                listaTurnados = Turnado.findAllByDocumento(Documento.get(it.id))           
                
              //println "observacion: "+it.observacion
           
              def fechaTemp
              def statusTemp
              def anyRemitente, direccionRemitente, telRemitente, municipioRemitente
              def lugar
           //   if(it.fechaVencimiento == null || it.fechaVencimiento.equals("")){
              //println "fecha Vencimiento nula "
             // fechaTemp = ""
              //}else{
              //println "Vencimiento "+it.fechaVencimiento.format("dd-MM-yyyy")    
              //fechaTemp = it.fechaVencimiento.format("dd-MM-yyyy")
              //}
              
                if(it.status == 0) statusTemp = "Creado"
                if(it.status == 1) statusTemp = "Turnado"
                if(it.status == 2) statusTemp = "Seguimiento"
                if(it.status == 3) statusTemp = "Concluido"
                if(it.persona==null){ 
//                    println "dependencia: "+ it.dependenciaRemitente
//                    println "direccion: "+ it.dependenciaRemitente.calleNumero+ " "+it.dependenciaRemitente.colonia
//                    telRemitente = ""
//                    println "municipio: " + it.dependenciaRemitente.municipio.toString()
                    anyRemitente = it.dependenciaRemitente
                    direccionRemitente = it.dependenciaRemitente.calleNumero+ " "+it.dependenciaRemitente.colonia
                    telRemitente = ""
                    lugar = it.dependenciaRemitente.municipio.toString()
                }
                if(it.persona!=null){ 
                    anyRemitente = it.persona.nombre
                    direccionRemitente = it.persona.calleNumero+" "+it.persona.colonia
                    telRemitente = it.persona.tel
                    if(it.persona.municipio.toString()=="null"){
                        lugar = it.persona.estado.toString()
                     }
                    else{
                         lugar = it.persona.municipio.toString()
                    }
                }
                count = count + 1                
                fillRow([it.fechaRecibido.format("dd-MM-yyyy"),anyRemitente.toString(), lugar, telRemitente, municipioRemitente.toString(), it.municipio.toString(), it.localidad.toString(), it.evento, it.asunto, listaTurnados.dependencia.toString(), it.folio.toString() ,statusTemp.toString(),seguimientos.toString(), it.observacion.toString(),it.turnadoInterno.toString()],count)
            }
    
            save(response.outputStream)
        }
        
    }
    def ajaxGetLocalidad(){
        
               
        def Cadena = params.id as String   
        def listLocalidad = Localidad.findAll("FROM Localidad u WHERE u.municipio=${Cadena} order by nombre")  
       
        def resultadoFormateado = listLocalidad.collect {
            [
                id: it.id,                
                nombre: it.nombre            
            ]
        }        
        render resultadoFormateado as JSON       
        
    }

}
