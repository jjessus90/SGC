import org.springframework.dao.DataIntegrityViolationException

class IndicacionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10,100)
        [indicacionInstanceList: Indicacion.list(params), indicacionInstanceTotal: Indicacion.count()]
    }

    def create() {
        [indicacionInstance: new Indicacion(params)]
    }

    def save() {
        def indicacionInstance = new Indicacion(params)
        if (!indicacionInstance.save(flush: true)) {
            render(view: "create", model: [indicacionInstance: indicacionInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'indicacion.label', default: 'Indicacion'), indicacionInstance.id])
        redirect(action: "show", id: indicacionInstance.id)
    }

    def show(Long id) {
        def indicacionInstance = Indicacion.get(id)
        if (!indicacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'indicacion.label', default: 'Indicacion'), id])
            redirect(action: "list")
            return
        }

        [indicacionInstance: indicacionInstance]
    }

    def edit(Long id) {
        def indicacionInstance = Indicacion.get(id)
        if (!indicacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'indicacion.label', default: 'Indicacion'), id])
            redirect(action: "list")
            return
        }

        [indicacionInstance: indicacionInstance]
    }

    def update(Long id, Long version) {
        def indicacionInstance = Indicacion.get(id)
        if (!indicacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'indicacion.label', default: 'Indicacion'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (indicacionInstance.version > version) {
                indicacionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'indicacion.label', default: 'Indicacion')] as Object[],
                          "Another user has updated this Indicacion while you were editing")
                render(view: "edit", model: [indicacionInstance: indicacionInstance])
                return
            }
        }

        indicacionInstance.properties = params

        if (!indicacionInstance.save(flush: true)) {
            render(view: "edit", model: [indicacionInstance: indicacionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'indicacion.label', default: 'Indicacion'), indicacionInstance.id])
        redirect(action: "show", id: indicacionInstance.id)
    }

    def delete(Long id) {
        def indicacionInstance = Indicacion.get(id)
        if (!indicacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'indicacion.label', default: 'Indicacion'), id])
            redirect(action: "list")
            return
        }

        try {
            indicacionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'indicacion.label', default: 'Indicacion'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'indicacion.label', default: 'Indicacion'), id])
            redirect(action: "show", id: id)
        }
    }
}
