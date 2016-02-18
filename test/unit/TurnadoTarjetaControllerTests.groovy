

import org.junit.*
import grails.test.mixin.*

@TestFor(TurnadoTarjetaController)
@Mock(TurnadoTarjeta)
class TurnadoTarjetaControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/turnadoTarjeta/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.turnadoTarjetaInstanceList.size() == 0
        assert model.turnadoTarjetaInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.turnadoTarjetaInstance != null
    }

    void testSave() {
        controller.save()

        assert model.turnadoTarjetaInstance != null
        assert view == '/turnadoTarjeta/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/turnadoTarjeta/show/1'
        assert controller.flash.message != null
        assert TurnadoTarjeta.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/turnadoTarjeta/list'

        populateValidParams(params)
        def turnadoTarjeta = new TurnadoTarjeta(params)

        assert turnadoTarjeta.save() != null

        params.id = turnadoTarjeta.id

        def model = controller.show()

        assert model.turnadoTarjetaInstance == turnadoTarjeta
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/turnadoTarjeta/list'

        populateValidParams(params)
        def turnadoTarjeta = new TurnadoTarjeta(params)

        assert turnadoTarjeta.save() != null

        params.id = turnadoTarjeta.id

        def model = controller.edit()

        assert model.turnadoTarjetaInstance == turnadoTarjeta
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/turnadoTarjeta/list'

        response.reset()

        populateValidParams(params)
        def turnadoTarjeta = new TurnadoTarjeta(params)

        assert turnadoTarjeta.save() != null

        // test invalid parameters in update
        params.id = turnadoTarjeta.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/turnadoTarjeta/edit"
        assert model.turnadoTarjetaInstance != null

        turnadoTarjeta.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/turnadoTarjeta/show/$turnadoTarjeta.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        turnadoTarjeta.clearErrors()

        populateValidParams(params)
        params.id = turnadoTarjeta.id
        params.version = -1
        controller.update()

        assert view == "/turnadoTarjeta/edit"
        assert model.turnadoTarjetaInstance != null
        assert model.turnadoTarjetaInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/turnadoTarjeta/list'

        response.reset()

        populateValidParams(params)
        def turnadoTarjeta = new TurnadoTarjeta(params)

        assert turnadoTarjeta.save() != null
        assert TurnadoTarjeta.count() == 1

        params.id = turnadoTarjeta.id

        controller.delete()

        assert TurnadoTarjeta.count() == 0
        assert TurnadoTarjeta.get(turnadoTarjeta.id) == null
        assert response.redirectedUrl == '/turnadoTarjeta/list'
    }
}
