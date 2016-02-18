import org.springframework.dao.DataIntegrityViolationException
import grails.converters.*

class DependenciaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [dependenciaInstanceList: Dependencia.list(params), dependenciaInstanceTotal: Dependencia.count()]
    }

    def create() {
        [dependenciaInstance: new Dependencia(params)]
    }

    def save() {
        def dependenciaInstance = new Dependencia(params)
        if (!dependenciaInstance.save(flush: true)) {
            render(view: "create", model: [dependenciaInstance: dependenciaInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'dependencia.label', default: 'Dependencia'), dependenciaInstance.id])
        redirect(action: "show", id: dependenciaInstance.id)
    }

    def show(Long id) {
        def dependenciaInstance = Dependencia.get(id)
        if (!dependenciaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dependencia.label', default: 'Dependencia'), id])
            redirect(action: "list")
            return
        }

        [dependenciaInstance: dependenciaInstance]
    }

    def edit(Long id) {
        def dependenciaInstance = Dependencia.get(id)
        if (!dependenciaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dependencia.label', default: 'Dependencia'), id])
            redirect(action: "list")
            return
        }

        [dependenciaInstance: dependenciaInstance]
    }

    def update(Long id, Long version) {
        def dependenciaInstance = Dependencia.get(id)
        if (!dependenciaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dependencia.label', default: 'Dependencia'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (dependenciaInstance.version > version) {
                dependenciaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'dependencia.label', default: 'Dependencia')] as Object[],
                          "Another user has updated this Dependencia while you were editing")
                render(view: "edit", model: [dependenciaInstance: dependenciaInstance])
                return
            }
        }

        dependenciaInstance.properties = params

        if (!dependenciaInstance.save(flush: true)) {
            render(view: "edit", model: [dependenciaInstance: dependenciaInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'dependencia.label', default: 'Dependencia'), dependenciaInstance.id])
        redirect(action: "show", id: dependenciaInstance.id)
    }

    def delete(Long id) {
        def dependenciaInstance = Dependencia.get(id)
        if (!dependenciaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dependencia.label', default: 'Dependencia'), id])
            redirect(action: "list")
            return
        }

        try {
            dependenciaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'dependencia.label', default: 'Dependencia'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'dependencia.label', default: 'Dependencia'), id])
            redirect(action: "show", id: id)
        }
    }
    def Dependencias( ){
      
  }
    
    
    def busquedaDependenciaAjax( ){
        // se utiliza p/ajax en dependencias.gsp
     
        def Cadena = params.id as String   
        def list = new Dependencia( )
        def listDependencias = Dependencia.findAll("FROM Dependencia d WHERE d.nombre like '%${Cadena}%'")  
       
        def resultadoFormateado = listDependencias.collect {
            [
                id: it.id,                
                nombre: it.nombre            
            ]
        }        
        render resultadoFormateado as JSON     
        
    
    }
    
    
    
   def  consultaPorDependencia( ){
    
        if(params?.dependenciaa){
            params.dependencia.id=params?.dependenciaa
            
        }
        
        
        if(!params["dependencia"] && params.dependenciaa==null){
            flash.error = "Por favor, Escriba el nombre de la Dependencia y elija en la lista para poder obtener los resultados deseados"
            redirect(action: "Dependencias")
            return
        }
        
        def idDependencia
        if(params.personaa){
            
            idDependencia = params.dependencia as int
        }else{
        
            idDependencia = params.dependencia.id as int
        }//fin else
        def DependenciaInstance=Dependencia.get(idDependencia)
        def nombreDependencia=DependenciaInstance.nombre
        
        def max = params?.max==null?10:params?.max as int
        def offset = params?.offset==null?0: params?.offset as int
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def mapa = [max:max, offset:offset]   
        
        def query="From Dependencia d where d.id=${idDependencia}"                        
        def total=10
        
        def totalDep = Dependencia
        //totalDoc = totalDoc.findAll("Select count(d.id) From Documento d where d.fechaCaptura  >=  '${fechaInicio}' AND d.fechaCaptura <= '${fechaFin}' and d.persona=${idRemitente}")
        def queryTotal="From Dependencia d where d.id=${idDependencia}"
//def totalcount = totalDoc.count()
        // params.max = Math.min(max ?: 10, 100)
        
        render(view: "Dependencias", model: [dependenciaInstanceList: Dependencia.findAll(query, mapa), dependenciaInstanceTotal: (totalDep.findAll(queryTotal)).size() as int,nombreDependencia:nombreDependencia, depen:params?.dependencia.id] )
        return 
        
        
    }
}
