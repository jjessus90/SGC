import org.springframework.dao.DataIntegrityViolationException
import grails.converters.*
import java.util.*;
import org.springframework.*

class TarjetaInformativaController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [tarjetaInformativaInstanceList: TarjetaInformativa.list(params), tarjetaInformativaInstanceTotal: TarjetaInformativa.count()]
    }

    def create() {
        [tarjetaInformativaInstance: new TarjetaInformativa(params)]
    }

    def save() {
        def idUsuario = springSecurityService.principal.id
        //def usuarioSistemaControllerInstance = UsuarioSistema.get(idUsuario as int)
        def user=UsuarioSistema.get(idUsuario as int)
        def rolee=user.authorities.id[0] as int
//        println"el rol es: "+rolee        
                
        def date=new Date()
        def year = ((date.getYear() as int)+1900);

        def tarjetaInformativaInstance = new TarjetaInformativa(params)

        def queryExist=TarjetaInformativa.executeQuery("Select Max(d.id) From TarjetaInformativa d")
        def idTarjeta=queryExist[0]
        def tarjetaInst

        if(!idTarjeta && year==2016){
           
            tarjetaInformativaInstance.numTarjeta="ST"+"/"+"0001/"+year
            
        }else if(idTarjeta){
            
            tarjetaInst = TarjetaInformativa.get(queryExist[0] as int)
            println "e???: "+tarjetaInst
            def splitfolio=(tarjetaInst.numTarjeta).split("/")
            
            def asIntFolio = splitfolio[1] as int
            asIntFolio=asIntFolio+1
            asIntFolio = asIntFolio as String
             
            asIntFolio=asIntFolio.padLeft(4,"0")
            tarjetaInformativaInstance.numTarjeta= "ST"+"/"+asIntFolio+"/"+year
            
        }
        tarjetaInformativaInstance.status = 0
        tarjetaInformativaInstance.fechaCaptura= new Date()

        if (!tarjetaInformativaInstance.save(flush: true)) {
            render(view: "create", model: [tarjetaInformativaInstance: tarjetaInformativaInstance])
            return
        }



        flash.message = message(code: 'default.created.message', args: [message(code: 'tarjetaInformativa.label', default: 'TarjetaInformativa'), tarjetaInformativaInstance.id])
        redirect(action: "show", id: tarjetaInformativaInstance.id)
    }

    def show(Long id) {
        def tarjetaInformativaInstance = TarjetaInformativa.get(id)
        if (!tarjetaInformativaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarjetaInformativa.label', default: 'TarjetaInformativa'), id])
            redirect(action: "list")
            return
        }

        [tarjetaInformativaInstance: tarjetaInformativaInstance]
    }

    def edit(Long id) {
        def tarjetaInformativaInstance = TarjetaInformativa.get(id)
        if (!tarjetaInformativaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarjetaInformativa.label', default: 'TarjetaInformativa'), id])
            redirect(action: "list")
            return
        }

        [tarjetaInformativaInstance: tarjetaInformativaInstance]
    }

    def update(Long id, Long version) {
        def tarjetaInformativaInstance = TarjetaInformativa.get(id)
        if (!tarjetaInformativaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarjetaInformativa.label', default: 'TarjetaInformativa'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (tarjetaInformativaInstance.version > version) {
                tarjetaInformativaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'tarjetaInformativa.label', default: 'TarjetaInformativa')] as Object[],
                          "Another user has updated this TarjetaInformativa while you were editing")
                render(view: "edit", model: [tarjetaInformativaInstance: tarjetaInformativaInstance])
                return
            }
        }

        tarjetaInformativaInstance.properties = params

        if (!tarjetaInformativaInstance.save(flush: true)) {
            render(view: "edit", model: [tarjetaInformativaInstance: tarjetaInformativaInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'tarjetaInformativa.label', default: 'TarjetaInformativa'), tarjetaInformativaInstance.id])
        redirect(action: "show", id: tarjetaInformativaInstance.id)
    }

    def delete(Long id) {
        def tarjetaInformativaInstance = TarjetaInformativa.get(id)
        if (!tarjetaInformativaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarjetaInformativa.label', default: 'TarjetaInformativa'), id])
            redirect(action: "list")
            return
        }

        try {
            tarjetaInformativaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'tarjetaInformativa.label', default: 'TarjetaInformativa'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'tarjetaInformativa.label', default: 'TarjetaInformativa'), id])
            redirect(action: "show", id: id)
        }
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
}
