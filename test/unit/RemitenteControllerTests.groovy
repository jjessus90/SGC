

import org.junit.*
import grails.test.mixin.*

@TestFor(RemitenteController)
@Mock(Remitente)
class RemitenteControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/remitente/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.remitenteInstanceList.size() == 0
        assert model.remitenteInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.remitenteInstance != null
    }

    void testSave() {
        controller.save()

        assert model.remitenteInstance != null
        assert view == '/remitente/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/remitente/show/1'
        assert controller.flash.message != null
        assert Remitente.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/remitente/list'

        populateValidParams(params)
        def remitente = new Remitente(params)

        assert remitente.save() != null

        params.id = remitente.id

        def model = controller.show()

        assert model.remitenteInstance == remitente
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/remitente/list'

        populateValidParams(params)
        def remitente = new Remitente(params)

        assert remitente.save() != null

        params.id = remitente.id

        def model = controller.edit()

        assert model.remitenteInstance == remitente
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/remitente/list'

        response.reset()

        populateValidParams(params)
        def remitente = new Remitente(params)

        assert remitente.save() != null

        // test invalid parameters in update
        params.id = remitente.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/remitente/edit"
        assert model.remitenteInstance != null

        remitente.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/remitente/show/$remitente.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        remitente.clearErrors()

        populateValidParams(params)
        params.id = remitente.id
        params.version = -1
        controller.update()

        assert view == "/remitente/edit"
        assert model.remitenteInstance != null
        assert model.remitenteInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/remitente/list'

        response.reset()

        populateValidParams(params)
        def remitente = new Remitente(params)

        assert remitente.save() != null
        assert Remitente.count() == 1

        params.id = remitente.id

        controller.delete()

        assert Remitente.count() == 0
        assert Remitente.get(remitente.id) == null
        assert response.redirectedUrl == '/remitente/list'
    }
}
