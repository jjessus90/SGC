

import org.junit.*
import grails.test.mixin.*

@TestFor(SeguimientoTarjetaController)
@Mock(SeguimientoTarjeta)
class SeguimientoTarjetaControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/seguimientoTarjeta/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.seguimientoTarjetaInstanceList.size() == 0
        assert model.seguimientoTarjetaInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.seguimientoTarjetaInstance != null
    }

    void testSave() {
        controller.save()

        assert model.seguimientoTarjetaInstance != null
        assert view == '/seguimientoTarjeta/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/seguimientoTarjeta/show/1'
        assert controller.flash.message != null
        assert SeguimientoTarjeta.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/seguimientoTarjeta/list'

        populateValidParams(params)
        def seguimientoTarjeta = new SeguimientoTarjeta(params)

        assert seguimientoTarjeta.save() != null

        params.id = seguimientoTarjeta.id

        def model = controller.show()

        assert model.seguimientoTarjetaInstance == seguimientoTarjeta
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/seguimientoTarjeta/list'

        populateValidParams(params)
        def seguimientoTarjeta = new SeguimientoTarjeta(params)

        assert seguimientoTarjeta.save() != null

        params.id = seguimientoTarjeta.id

        def model = controller.edit()

        assert model.seguimientoTarjetaInstance == seguimientoTarjeta
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/seguimientoTarjeta/list'

        response.reset()

        populateValidParams(params)
        def seguimientoTarjeta = new SeguimientoTarjeta(params)

        assert seguimientoTarjeta.save() != null

        // test invalid parameters in update
        params.id = seguimientoTarjeta.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/seguimientoTarjeta/edit"
        assert model.seguimientoTarjetaInstance != null

        seguimientoTarjeta.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/seguimientoTarjeta/show/$seguimientoTarjeta.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        seguimientoTarjeta.clearErrors()

        populateValidParams(params)
        params.id = seguimientoTarjeta.id
        params.version = -1
        controller.update()

        assert view == "/seguimientoTarjeta/edit"
        assert model.seguimientoTarjetaInstance != null
        assert model.seguimientoTarjetaInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/seguimientoTarjeta/list'

        response.reset()

        populateValidParams(params)
        def seguimientoTarjeta = new SeguimientoTarjeta(params)

        assert seguimientoTarjeta.save() != null
        assert SeguimientoTarjeta.count() == 1

        params.id = seguimientoTarjeta.id

        controller.delete()

        assert SeguimientoTarjeta.count() == 0
        assert SeguimientoTarjeta.get(seguimientoTarjeta.id) == null
        assert response.redirectedUrl == '/seguimientoTarjeta/list'
    }
}
