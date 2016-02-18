import org.springframework.dao.DataIntegrityViolationException
import grails.converters.*

class PersonaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [personaInstanceList: Persona.list(params), personaInstanceTotal: Persona.count()]
    }

    def create() {
        [personaInstance: new Persona(params)]
    }

    def save() {
        def personaInstance = new Persona(params)
         
        if (!personaInstance.save(flush: true)) {
            render(view: "create", model: [personaInstance: personaInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'persona.label', default: 'Persona'), personaInstance.id])
        redirect(action: "show", id: personaInstance.id)
    }

    def show(Long id) {
        def personaInstance = Persona.get(id)
        if (!personaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'persona.label', default: 'Persona'), id])
            redirect(action: "list")
            return
        }

        [personaInstance: personaInstance]
    }

    def edit(Long id) {
        def personaInstance = Persona.get(id)
        if (!personaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'persona.label', default: 'Persona'), id])
            redirect(action: "list")
            return
        }

        [personaInstance: personaInstance]
    }

    def update(Long id, Long version) {
        def personaInstance = Persona.get(id)
        if (!personaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'persona.label', default: 'Persona'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (personaInstance.version > version) {
                personaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'persona.label', default: 'Persona')] as Object[],
                          "Another user has updated this Persona while you were editing")
                render(view: "edit", model: [personaInstance: personaInstance])
                return
            }
        }

        personaInstance.properties = params

        if (!personaInstance.save(flush: true)) {
            render(view: "edit", model: [personaInstance: personaInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'persona.label', default: 'Persona'), personaInstance.id])
        redirect(action: "show", id: personaInstance.id)
    }

    def delete(Long id) {
        def personaInstance = Persona.get(id)
        if (!personaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'persona.label', default: 'Persona'), id])
            redirect(action: "list")
            return
        }

        try {
            personaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'persona.label', default: 'Persona'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'persona.label', default: 'Persona'), id])
            redirect(action: "show", id: id)
        }
    }
    def Personass(  ){        
    }
    def busquedaPersonaAjax(){n personass.gsp
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
    
    def consultaPorPersona(){       
        if(params?.personaa){
            params.persona.id=params?.personaa
            
        }       
        if(!params["persona"] && params.personaa==null){
            flash.error = "Por favor, Escriba el nombre de la persona y elija en la lista para poder obtener los resultados deseados"
            redirect(action: "Personass")
            return
        }        
        def idPersona
        if(params.personaa){
            
            idPersona = params.personaa as int
        }else{
        
            idPersona = params.persona.id as int
        }//fin else
        def personaInstance=Persona.get(idPersona)
        def nombrePerson=personaInstance.nombre
        
        def max = params?.max==null?10:params?.max as int
        def offset = params?.offset==null?0: params?.offset as int
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def mapa = [max:max, offset:offset]   
        
        def query="From Persona d where d.id=${idPersona}"                        
        def total=10
        
        def totalPer = Persona
        //totalDoc = totalDoc.findAll("Select count(d.id) From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}' and d.persona=${idRemitente}")
        def queryTotal="From Persona d where d.id=${idPersona}"
        //def totalcount = totalDoc.count()
        // params.max = Math.min(max ?: 10, 100)
        
        render(view: "Personass", model: [personaInstanceList: Persona.findAll(query, mapa), personaInstanceTotal: (totalPer.findAll(queryTotal)).size() as int,nombrePersona:nombrePerson, person:params?.persona.id] )
        return      
    }
    def ajaxGetMunicipio(){
        
               
        def Cadena = params.id as String   
        def listMunicipio = Municipio.findAll("FROM Municipio u WHERE u.estado=${Cadena} order by nombre")  
       
        def resultadoFormateado = listMunicipio.collect {
            [
                id: it.id,                
                nombre: it.nombre            
            ]
        }        
        render resultadoFormateado as JSON       
        
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
  
    
}
