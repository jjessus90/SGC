import org.springframework.dao.DataIntegrityViolationException
import grails.converters.*

class ClasificacionArchivoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [clasificacionArchivoInstanceList: ClasificacionArchivo.list(params), clasificacionArchivoInstanceTotal: ClasificacionArchivo.count()]
    }

    def create() {
        [clasificacionArchivoInstance: new ClasificacionArchivo(params)]
    }

    def save() {
        def clasificacionArchivoInstance = new ClasificacionArchivo(params)
        if (!clasificacionArchivoInstance.save(flush: true)) {
            render(view: "create", model: [clasificacionArchivoInstance: clasificacionArchivoInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'clasificacionArchivo.label', default: 'ClasificacionArchivo'), clasificacionArchivoInstance.id])
        redirect(action: "show", id: clasificacionArchivoInstance.id)
    }

    def show(Long id) {
        def clasificacionArchivoInstance = ClasificacionArchivo.get(id)
        if (!clasificacionArchivoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'clasificacionArchivo.label', default: 'ClasificacionArchivo'), id])
            redirect(action: "list")
            return
        }

        [clasificacionArchivoInstance: clasificacionArchivoInstance]
    }

    def edit(Long id) {
        def clasificacionArchivoInstance = ClasificacionArchivo.get(id)
        if (!clasificacionArchivoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'clasificacionArchivo.label', default: 'ClasificacionArchivo'), id])
            redirect(action: "list")
            return
        }

        [clasificacionArchivoInstance: clasificacionArchivoInstance]
    }

    def update(Long id, Long version) {
        def clasificacionArchivoInstance = ClasificacionArchivo.get(id)
        if (!clasificacionArchivoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'clasificacionArchivo.label', default: 'ClasificacionArchivo'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (clasificacionArchivoInstance.version > version) {
                clasificacionArchivoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'clasificacionArchivo.label', default: 'ClasificacionArchivo')] as Object[],
                          "Another user has updated this ClasificacionArchivo while you were editing")
                render(view: "edit", model: [clasificacionArchivoInstance: clasificacionArchivoInstance])
                return
            }
        }

        clasificacionArchivoInstance.properties = params

        if (!clasificacionArchivoInstance.save(flush: true)) {
            render(view: "edit", model: [clasificacionArchivoInstance: clasificacionArchivoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'clasificacionArchivo.label', default: 'ClasificacionArchivo'), clasificacionArchivoInstance.id])
        redirect(action: "show", id: clasificacionArchivoInstance.id)
    }

    def delete(Long id) {
        def clasificacionArchivoInstance = ClasificacionArchivo.get(id)
        if (!clasificacionArchivoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'clasificacionArchivo.label', default: 'ClasificacionArchivo'), id])
            redirect(action: "list")
            return
        }

        try {
            clasificacionArchivoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'clasificacionArchivo.label', default: 'ClasificacionArchivo'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'clasificacionArchivo.label', default: 'ClasificacionArchivo'), id])
            redirect(action: "show", id: id)
        }
    }
    def ajaxGetDependencias(){
        
               
        def Cadena = params.id as String  
        
        def listClasificacion = ClasificacionArchivo.findAll("FROM ClasificacionArchivo u WHERE u.tipoDependencia='${Cadena}' and status='1' order by dependencia")  
        
        def resultadoFormateado = listClasificacion.collect {
            [
                id: it.id,                
                dependencia: it.dependencia            
            ]
        }        
        render resultadoFormateado as JSON       
        
    }
    
}
