import org.springframework.dao.DataIntegrityViolationException

class SeguimientoTarjetaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [seguimientoTarjetaInstanceList: SeguimientoTarjeta.list(params), seguimientoTarjetaInstanceTotal: SeguimientoTarjeta.count()]
    }

    def create() {
        [seguimientoTarjetaInstance: new SeguimientoTarjeta(params)]
    }

    def save() {
        def seguimientoTarjetaInstance = new SeguimientoTarjeta(params)
        if (!seguimientoTarjetaInstance.save(flush: true)) {
            render(view: "create", model: [seguimientoTarjetaInstance: seguimientoTarjetaInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'seguimientoTarjeta.label', default: 'SeguimientoTarjeta'), seguimientoTarjetaInstance.id])
        redirect(action: "show", id: seguimientoTarjetaInstance.id)
    }

    def show(Long id) {
        def seguimientoTarjetaInstance = SeguimientoTarjeta.get(id)
        if (!seguimientoTarjetaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seguimientoTarjeta.label', default: 'SeguimientoTarjeta'), id])
            redirect(action: "list")
            return
        }

        [seguimientoTarjetaInstance: seguimientoTarjetaInstance]
    }

    def edit(Long id) {
        def seguimientoTarjetaInstance = SeguimientoTarjeta.get(id)
        if (!seguimientoTarjetaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seguimientoTarjeta.label', default: 'SeguimientoTarjeta'), id])
            redirect(action: "list")
            return
        }

        [seguimientoTarjetaInstance: seguimientoTarjetaInstance]
    }

    def update(Long id, Long version) {
        def seguimientoTarjetaInstance = SeguimientoTarjeta.get(id)
        if (!seguimientoTarjetaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seguimientoTarjeta.label', default: 'SeguimientoTarjeta'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (seguimientoTarjetaInstance.version > version) {
                seguimientoTarjetaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'seguimientoTarjeta.label', default: 'SeguimientoTarjeta')] as Object[],
                          "Another user has updated this SeguimientoTarjeta while you were editing")
                render(view: "edit", model: [seguimientoTarjetaInstance: seguimientoTarjetaInstance])
                return
            }
        }

        seguimientoTarjetaInstance.properties = params

        if (!seguimientoTarjetaInstance.save(flush: true)) {
            render(view: "edit", model: [seguimientoTarjetaInstance: seguimientoTarjetaInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'seguimientoTarjeta.label', default: 'SeguimientoTarjeta'), seguimientoTarjetaInstance.id])
        redirect(action: "show", id: seguimientoTarjetaInstance.id)
    }

    def delete(Long id) {
        def seguimientoTarjetaInstance = SeguimientoTarjeta.get(id)
        if (!seguimientoTarjetaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'seguimientoTarjeta.label', default: 'SeguimientoTarjeta'), id])
            redirect(action: "list")
            return
        }

        try {
            seguimientoTarjetaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'seguimientoTarjeta.label', default: 'SeguimientoTarjeta'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'seguimientoTarjeta.label', default: 'SeguimientoTarjeta'), id])
            redirect(action: "show", id: id)
        }
    }
}
