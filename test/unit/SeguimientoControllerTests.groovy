

import org.junit.*
import grails.test.mixin.*

@TestFor(SeguimientoController)
@Mock(Seguimiento)
class SeguimientoControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/seguimiento/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.seguimientoInstanceList.size() == 0
        assert model.seguimientoInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.seguimientoInstance != null
    }

    void testSave() {
        controller.save()

        assert model.seguimientoInstance != null
        assert view == '/seguimiento/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/seguimiento/show/1'
        assert controller.flash.message != null
        assert Seguimiento.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/seguimiento/list'

        populateValidParams(params)
        def seguimiento = new Seguimiento(params)

        assert seguimiento.save() != null

        params.id = seguimiento.id

        def model = controller.show()

        assert model.seguimientoInstance == seguimiento
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/seguimiento/list'

        populateValidParams(params)
        def seguimiento = new Seguimiento(params)

        assert seguimiento.save() != null

        params.id = seguimiento.id

        def model = controller.edit()

        assert model.seguimientoInstance == seguimiento
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/seguimiento/list'

        response.reset()

        populateValidParams(params)
        def seguimiento = new Seguimiento(params)

        assert seguimiento.save() != null

        // test invalid parameters in update
        params.id = seguimiento.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/seguimiento/edit"
        assert model.seguimientoInstance != null

        seguimiento.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/seguimiento/show/$seguimiento.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        seguimiento.clearErrors()

        populateValidParams(params)
        params.id = seguimiento.id
        params.version = -1
        controller.update()

        assert view == "/seguimiento/edit"
        assert model.seguimientoInstance != null
        assert model.seguimientoInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/seguimiento/list'

        response.reset()

        populateValidParams(params)
        def seguimiento = new Seguimiento(params)

        assert seguimiento.save() != null
        assert Seguimiento.count() == 1

        params.id = seguimiento.id

        controller.delete()

        assert Seguimiento.count() == 0
        assert Seguimiento.get(seguimiento.id) == null
        assert response.redirectedUrl == '/seguimiento/list'
    }
}
