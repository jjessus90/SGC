

import org.junit.*
import grails.test.mixin.*

@TestFor(TurnadoController)
@Mock(Turnado)
class TurnadoControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/turnado/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.turnadoInstanceList.size() == 0
        assert model.turnadoInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.turnadoInstance != null
    }

    void testSave() {
        controller.save()

        assert model.turnadoInstance != null
        assert view == '/turnado/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/turnado/show/1'
        assert controller.flash.message != null
        assert Turnado.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/turnado/list'

        populateValidParams(params)
        def turnado = new Turnado(params)

        assert turnado.save() != null

        params.id = turnado.id

        def model = controller.show()

        assert model.turnadoInstance == turnado
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/turnado/list'

        populateValidParams(params)
        def turnado = new Turnado(params)

        assert turnado.save() != null

        params.id = turnado.id

        def model = controller.edit()

        assert model.turnadoInstance == turnado
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/turnado/list'

        response.reset()

        populateValidParams(params)
        def turnado = new Turnado(params)

        assert turnado.save() != null

        // test invalid parameters in update
        params.id = turnado.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/turnado/edit"
        assert model.turnadoInstance != null

        turnado.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/turnado/show/$turnado.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        turnado.clearErrors()

        populateValidParams(params)
        params.id = turnado.id
        params.version = -1
        controller.update()

        assert view == "/turnado/edit"
        assert model.turnadoInstance != null
        assert model.turnadoInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/turnado/list'

        response.reset()

        populateValidParams(params)
        def turnado = new Turnado(params)

        assert turnado.save() != null
        assert Turnado.count() == 1

        params.id = turnado.id

        controller.delete()

        assert Turnado.count() == 0
        assert Turnado.get(turnado.id) == null
        assert response.redirectedUrl == '/turnado/list'
    }
}
